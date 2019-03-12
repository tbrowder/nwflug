#!/usr/bin/env perl6

use Date::Names;

use lib <./lib>;
use BB-Email;
use BB-Cross;
use BB-Props;
use NW-Email;
use NW-Cross;
use NW-Props;


# calculate meeting dates and PR media deadlines
if !@*ARGS {
    say qq:to/HERE/;
    Usage: $*PROGRAM go | [y=YYYY] [m=N|MMM][debug][test][print][Props]
    HERE
    exit;
}

my $test  = 0;
my $debug = 0;
my $print = 0;
my $do-props = 0;
# add more sophisticated arg handling
my $y = DateTime.now.year; # default
my $m = 0;                 # use all months
for @*ARGS {
    #say "DEBUG: arg '$_'";
    when /:i ^ '-'? 'y='(\d**4)/ {
        $y = +$0;
    }
    when /:i '-'? 'm='(\S+)/ {
        $m = ~$0;
    }
    when /:i ^d/ {
        $debug = 1;
    }
    when /:i ^t/ {
        $test = 1;
    }
    when /^ P / {
        $do-props = 1;
    }
    when /^ p / {
        $print = 1;
    }
    default {
        die "FATAL: Unknown arg '$_'";
    }
}

my $dn = Date::Names.new: :dset('dow3'), :mset('mon');

# start with the first day of the desired year:
if $m ~~ /(\D+)/ {
    # transform name to number
    my $mnam = ~$0;
    given $mnam {
        when /:i ^jan/ { $m =  1; }
        when /:i ^feb/ { $m =  2; }
        when /:i ^mar/ { $m =  3; }
        when /:i ^apr/ { $m =  4; }
        when /:i ^may/ { $m =  5; }
        when /:i ^jun/ { $m =  6; }
        when /:i ^jul/ { $m =  7; }
        when /:i ^aug/ { $m =  8; }
        when /:i ^sep/ { $m =  9; }
        when /:i ^oct/ { $m = 10; }
        when /:i ^nov/ { $m = 11; }
        when /:i ^dec/ { $m = 12; }
        default {
            die "Unknown or month input '$_'";
        }
    }
}

#say "DEBUG: input mon num is $m"; exit;

my $D = Date.new: :year($y);

# how many days in the year of interest?
my $ndays = $D.is-leap-year ?? 366 !! 365;

# save the date info for all days
my @days;
my @first-mondays;
for 1..12 -> $mon {
    $D = Date.new: :year($y), :month($mon);
    my $ndays = $D.days-in-month;
    my $first-monday = 0;
    for 1..$ndays -> $day {
        my $d = Date.new: :year($y), :month($mon), :day($day);
        @days.append: $d;
        # get the dow
        my $dow = $d.day-of-week;
        if !$first-monday && $dow == 1 {
            # a Monday!
            my $mnam = $dn.mon($mon);
            #say "First Monday in $mnam is $day";
            $first-monday = $day;
            @first-mondays.append: $d;
        }
    }
}

# show the pertinent dates
# constant delta days:
# BAY BEACON
constant $bb-pub = -5;            # publish in the paper the wednesday prior to the mtg
constant $bb-send = $bb-pub - 14; # send email two weeks prior to desired paper
# NWF DAILY NEWS
constant $nw-pub = -1;            # publish in the paper the sunday prior to the mtg
constant $nw-send = $nw-pub - 22; # send email 22 days prior to desired paper
constant $all-send = $nw-send;

my $mtg-date;
my $email-date;
my $nw-pub-date;
my $bb-pub-date;

for @first-mondays -> $d {
    my $mon  = $d.month;

    # calculate pertinent dates
    $mtg-date    = $d;
    $email-date  = $d.earlier: :days(-$all-send);
    $bb-pub-date = $d.earlier: :days(-$bb-pub);
    $nw-pub-date = $d.earlier: :days(-$nw-pub);

    # if testing we want start and finish with March
    next if $test && $mon < 3 || $mon > 3 && $test;
    # if we have entered another month
    next if $m && $mon < $m || $mon > $m;

    my $mnam = $dn.mon($mon);
    my $day  = $d.day;
    say "First Monday in $mnam is $day";
    #my $mtg-date = sprintf "%04d-%02d-%02d", $y, $mon, $day;
    #my $mtg-date-std-format = date-std-fmt $d; # sprintf "%s %d, %s", $mnam, $day, $y;

    # a dir per meeting date
    my $dir = 'mtg-' ~ $mtg-date;
    if $dir.IO.d {
        say "Meeting directory '$dir' exists...ignoring" if $debug;
    }
    else {
        say "Need to create meeting directory '$dir'";
        mkdir $dir;
    }

    # print pertinent dates
    say "  send email to Bay Beacon and NWF Daily News: $email-date";
    say "  publish in Bay Beacon:                       $bb-pub-date";
    say "  publish in NWF Daily News:                   $nw-pub-date";

    # if we have entered another month
    last if $m == $mon;
}

if !$m {
    say "Exiting, cannot create docx files for multiple months yet.";
    exit;
}

if !$print {
    my $ans = prompt "\nDo you want to create the docx files (y/n) => ";
    if $ans ~~ /:i ^y/ {
        say "You entered 'YES'";
        ++$print;
    }
    else {
        say "You did NOT enter 'y' or 'Y'...exiting";
        exit;
    }
}


my @ofils;

print-all-docs :$mtg-date, :$email-date, :$nw-pub-date, :$bb-pub-date;



my $nf = +@ofils;
say "Normal end.";
if $nf {
    my $s = $nf > 1 ?? 's' !! '';
    say "See output file$s:";
    say "  $_" for @ofils;
}
else {
    say "No files were created.";
}

##### SUBROUTINES #####
sub print-all-docs(
    # note all following dates are in format: yyyy-mm-dd
    :$mtg-date!,
    :$email-date!,
    :$nw-pub-date!,
    :$bb-pub-date!,
    :$do-props,
    :$debug,
) {
    # we need three dates as input:
    #   date to send email
    #   date to publish in NWFDN
    #   date to publish in Bay Beacon

    # define string vars used:
    my $mtg-month-name         = $dn.mon($mtg-date.month);
    my $mtg-date-std-format    = date-std-fmt $mtg-date;    # June 4, 2019
    my $bb-pub-date-std-format = date-std-fmt $bb-pub-date; # June 4, 2019
    my $nw-pub-date-std-format = date-std-fmt $nw-pub-date; # September 21, 2020

    # output file names without suffixes
    my $f0 = "bay-beacon-email-{$email-date}";
    my $f1 = "bay-beacon-presr-CROSS-{$email-date}";
    my $f2 = "bay-beacon-presr-PROPS-{$email-date}";
    my $f3 = "nwfdn-email-{$email-date}";
    my $f4 = "nwfdn-presr-CROSS-{$email-date}";
    my $f5 = "nwfdn-presr-PROPS-{$email-date}";
    my @list = $f0, $f1, $f2, $f3, $f4, $f5;
    if 1 {
        say "DEBUG: base names:";
        say "  $_" for @list;
    }

    # first step is tranforming test templates to show the proper dates

    # second step is transforming the markdown into docx

    # third step is to submit the emails

    print-nw-email;
    print-nw-presser;
    print-bb-email;
    print-bb-presser;

}

sub print-nw-email() {
}

sub print-nw-presser() {
}

sub print-bb-email() {
}

sub print-bb-presser() {
}

multi sub date-std-fmt(Date $D) {
    # e.g., "May 7, 2019"
    my $y = $D.year;
    my $d = $D.day;
    my $m = $D.month;
    state $dn = Date::Names.new: :mset('mon');

    return sprintf "%s %d, %d", $dn.mon($m), $d, $y;
}
