#!/usr/bin/env perl6

use Date::Names;

my $test  = 1;
my $debug = 1;

# calculate meeting dates and PR media deadlines
if !@*ARGS {
    say "Usage: $*PROGRAM <year>";
    exit;
}

# start with the first day of the desired year:
my $y = @*ARGS.shift;
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
            my $mnam = %mon{$mon};
            #say "First Monday in $mnam is $day";
            $first-monday = $day;
            @first-mondays.append: $d;
        }
    }
}

for @first-mondays -> $d {
    my $mon  = $d.month;

    # if testing we want start and finish with March
    next if $mon < 3 || $mon > 3 && $test;

    my $mnam = %mon{$mon};
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
}
 
##### SUBROUTINES #####
sub print-bay-beacon(Date $d, :$props) {
    # create the text string, then convert to docx
}

