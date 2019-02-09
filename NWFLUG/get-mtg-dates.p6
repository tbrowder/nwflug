#!/usr/bin/env perl6

# calculate meeting dates and PR media deadlines
my %mon = [
    1,  'January', 
    2,  'February', 
    3,  'March', 
    4,  'April', 
    5,  'May', 
    6,  'June', 
    7,  'July', 
    8,  'August', 
    9,  'September', 
    10, 'October', 
    11, 'November', 
    12, 'December' 
];

my %mon-abbrev = [
    1,  'Jan', 
    2,  'Feb', 
    3,  'Mar', 
    4,  'Apr', 
    5,  'May', 
    6,  'Jun', 
    7,  'Jul', 
    8,  'Aug', 
    9,  'Sep', 
    10, 'Oct', 
    11, 'Nov', 
    12, 'Dec' 
];

my %dow = [ 
    1, 'Monday',
    2, 'Tuesday', 
    3, 'Wednesday',
    4, 'Thursday',
    5, 'Friday',
    6, 'Saturday',
    7, 'Sunday'
];

my %dow-abbrev = [ 
    1, 'Mon',
    2, 'Tue', 
    3, 'Wed',
    4, 'Thu',
    5, 'Fri',
    6, 'Sat',
    7, 'Sun'
];

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
    my $mnam = %mon{$mon};
    my $day  = $d.day;
    say "First Monday in $mnam is $day";
    my $mtg-date = sprintf "%04d-%02d-%02d", $y, $mon, $day;
    # a dir per meeting date
    my $dir = 'mtg-' ~ $mtg-date;
    if $dir.IO.d {
        say "Meeting directory '$dir' exists...ignoring";
    }
    else {
        say "Need to create meeting directory '$dir'";
        mkdir $dir;
    }
}
 
