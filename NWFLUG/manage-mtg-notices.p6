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
    when /:i '-'? 'y='(\d**4)/ {
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
    when /:i ^P/ {
        $do-props = 1;
    }
    when /:i ^p/ {
        $print = 1;
    }
    default {
        die "FATAL: Unknown arg '$_'";
    }
}

my $dn = Date::Names.new: :dset('dow3'), :mset('mon3');

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

my $nw-pub-date;
my $bb-pub-date;
my $all-send-date;
for @first-mondays -> $d {
    my $mon  = $d.month;

    # calculate pertinent dates
    $all-send-date = $d.earlier: :days(-$all-send);
    $bb-pub-date  = $d.earlier: :days(-$bb-pub);
    $nw-pub-date  = $d.earlier: :days(-$nw-pub);

    # if testing we want start and finish with March
    next if $test && $mon < 3 || $mon > 3 && $test;
    # if we have entered another month
    next if $m && $mon < $m || $mon > $m;

    my $mnam = $dn.mon($mon);
    my $day  = $d.day;
    say "First Monday in $mnam is $day";
    my $mtg-date = sprintf "%04d-%02d-%02d", $y, $mon, $day;
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
    say "  send email to Bay Beacon and NWF Daily News: $all-send-date";
    say "  publish in Bay Beacon:                       $bb-pub-date";
    say "  publish in NWF Daily News:                   $nw-pub-date";

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

# first step is tranforming test templates to show the proper dates

# second step is transforming the markdown into docx

# third step is to submit the emails

my @ofils;
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
    :$mtg-month-name,
    :$email-send,
    :$nw-pub,
    :$bb-pub,
    :$do-props,
    :$debug,
) {
    # we need three dates as input:
    #   date to send email
    #   date to publish in NWFDN
    #   date to publish in Bay Beacon

    # define string vars used:
    #  $mtg-month-name;         # March <= input var by caller
    my $bb-pub-date-std-format; # June 4, 2019
    my $nw-pub-date-std-format; # September 21, 2020
    my $mtg-date-std-format;    # June 4, 2019

    # output file names without suffixes
    my $f1 = "bay-beacon-email-{$email-send}";
    my $f2 = "bay-beacon-presr-CROSS-{$email-send}";
    my $f3 = "bay-beacon-presr-PROPS-{$email-send}";
    my $f4 = "nwfdn-email-{$email-send}";
    my $f5 = "nwfdn-presr-CROSS-{$email-send}";
    my $f6 = "nwfdn-presr-PROPS-{$email-send}";

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
