#!/usr/bin/env perl6

#use Date::Names;

my %mon = %(
    1, 'Jan',
    2, 'Feb',
    3, 'Mar',
    4, 'Apr',
    5, 'May',
    6, 'Jun',
    7, 'Jul',
    8, 'Aug',
    9, 'Sep',
   10, 'Oct',
   11, 'Nov',
   12, 'Dec',
);


my $test  = 0;
my $debug = 0;

# calculate meeting dates and PR media deadlines
if !@*ARGS {
    say "Usage: $*PROGRAM <year> [<month>]";
    exit;
}

# start with the first day of the desired year:
my $y = @*ARGS.shift;
my $m = @*ARGS.elems ?? @*ARGS.shift !! 0;
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
    my $bb-show-date = $d.earlier: :days(-$bb-show);
    my $bb-send-date = $d.earlier: :days(-$bb-send);

    # if testing we want start and finish with March
    next if $mon < 3 || $mon > 3 && $test;
    # if we have entered another month
    next if $mon < $m || $mon > $m && $m;


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

    # print pertinent dates
    say "  send email to NWF Daily News: $nw-send-date";
    say "  send email to Bay Beacon:     $bb-show-date";
    say "  show in Bay Beacon:           $bb-send-date";
    say "  show in NWF Daily News:       $nw-show-date";
    
}
 
##### SUBROUTINES #####
sub print-bay-beacon(Date $d, :$props) {
    # create the text string, then convert to docx
}

