#!/usr/bin/env perl6

# calculate meeting dates and PR media deadlines
my %mon = [ :1Jan, :2Feb, :3Mar, :4Apr, :5May, :6Jun, :7Jul, :8Aug, :9Sep, :10Oct, :11Nov, :12Dec ];
my %dow = [ :1Mon, :2Tue, :3Wed, :4Thu, :5Fri, :6Sat, :7Sun ];
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
            say "First Monday in $mnam is $day";
            $first-monday = $day;
            @first-mondays.append: $d;
        }
    }
}
 
