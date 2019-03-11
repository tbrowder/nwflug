#!/usr/bin/env perl6

use Date::Names;

my $test  = 0;
my $debug = 0;

# calculate meeting dates and PR media deadlines
if !@*ARGS {
    say qq:to/HERE/;
    Usage: $*PROGRAM <year> | go [<month>]
    HERE
    exit;
}

my $dn = Date::Names.new: :dset('dow3'), :mset('mon3');

# start with the first day of the desired year:
my $y = @*ARGS.shift;
my $m = @*ARGS.elems ?? @*ARGS.shift !! 0;
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
constant $bb-show = -5;            # show in the paper the wednesday prior to the mtg
constant $bb-send = $bb-show - 14; # send email two weeks prior to desired paper
# NWF DAILY NEWS
constant $nw-show = -1;            # show in the paper the sunday prior to the mtg
constant $nw-send = $nw-show - 22; # send email 22 days prior to desired paper
for @first-mondays -> $d {
    my $mon  = $d.month;

    # calculate pertinent dates
    my $nw-show-date = $d.earlier: :days(-$nw-show);
    my $nw-send-date = $d.earlier: :days(-$nw-send);
    my $bb-send-date = $d.earlier: :days(-$bb-send);
    my $bb-show-date = $d.earlier: :days(-$bb-show);

    # if testing we want start and finish with March
    next if $mon < 3 || $mon > 3 && $test;
    # if we have entered another month
    next if $mon < $m || $mon > $m && $m;

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
    say "  send email to NWF Daily News: $nw-send-date";
    say "  send email to Bay Beacon:     $bb-send-date";
    say "  show in Bay Beacon:           $bb-show-date";
    say "  show in NWF Daily News:       $nw-show-date";

}

if !$m {
    say "Exiting, cannot create docx files for multiple months yet.";
    exit;
}

my $ans = prompt "Do you want to create the docx files (y/n) => ";
if $ans ~~ /:i ^y/ {
    say "You entered 'YES'";
}
else {
    say "You did NOT enter 'y' or 'Y'...exiting";
    exit;
}
# first step is tranforming test templates to show the proper dates

# second step is transforming the markdown into docx

# third step is to submit the emails

##### SUBROUTINES #####
sub print-bay-beacon(Date $d, :$props) {
    # create the text string, then convert to docx
}
