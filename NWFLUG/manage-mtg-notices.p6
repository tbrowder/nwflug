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
my $force = 0;
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
    when /:i ^f/ {
        $force = 1;
    }
    when /^ P / {
        $do-props = 1;
    }
    when /^ p / {
        $print = 1;
    }
    when /:i ^g / {
        ; # go: ok
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
            say "First Monday in $mnam is $day" if $debug;
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

my @ofils;

MONTH:
for @first-mondays -> $d {
    my $mon  = $d.month; # 1..12
    my $mnam = $dn.mon($mon);

    # calculate pertinent dates
    $mtg-date    = $d;
    $email-date  = $d.earlier: :days(-$all-send);
    $bb-pub-date = $d.earlier: :days(-$bb-pub);
    $nw-pub-date = $d.earlier: :days(-$nw-pub);

    # if testing we want start and finish with March
    next if $test && ($mon < 3 || $mon > 3 && $test);
    # if we have entered another month
    next if $m && ($mon < $m || $mon > $m);

    say "DEBUG: working month '$mnam'..." if $debug;

    my $day  = $d.day;
    say "First Monday in $mnam is $day";
    #my $mtg-date = sprintf "%04d-%02d-%02d", $y, $mon, $day;
    #my $mtg-date-std-format = date-std-fmt $d; # sprintf "%s %d, %s", $mnam, $day, $y;

    # a dir per meeting date
    my $dir = 'mtg-' ~ $mtg-date;
    if $dir.IO.d {
        say "Meeting directory '$dir' exists...ignoring and skipping"; # if $debug;
        next MONTH;
    }
    else {
        say "Need to create meeting directory '$dir'";
        mkdir $dir;
    }

    # print pertinent dates
    say "  send email to Bay Beacon and NWF Daily News: $email-date";
    say "  publish in Bay Beacon:                       $bb-pub-date";
    say "  publish in NWF Daily News:                   $nw-pub-date";

    if $print {
        print-all-docs :$dir, :$mtg-date, :$email-date, :$nw-pub-date, :$bb-pub-date, :$force;
    }

    # if we have entered another month
    last if $m == $mon;
}

=begin comment
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

print-all-docs :$mtg-date, :$email-date, :$nw-pub-date, :$bb-pub-date;
=end comment


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
    :$debug,
    :$force,
    :$dir = '.';
) {
    # we need three dates as input:
    #   date to send email
    #   date to publish in NWFDN
    #   date to publish in Bay Beacon

    # define string vars used:
    my $mtg-month-name         = $mtg-date.year; #$dn.mon($mtg-date.month);
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
    if 0 {
        say "DEBUG: base names:";
        say "  $_" for @list;
    }

    for @list -> $f {
        # Bay Beacon
        my $str;
        given $f {
            when /:i bay/ {
                say "Working Bay Beacon file '$_'...";
                when /:i email / {
                    $str = get-bb-email :$bb-pub-date-std-format, :$mtg-month-name;
                }
                when /:i cross / {
                    $str = get-bb-cross :$bb-pub-date-std-format,:$mtg-date-std-format;
                }
                when /:i props / {
                    $str = get-bb-props :$bb-pub-date-std-format, :$mtg-date-std-format;
                }
                default {
                    die "FATAL: Unknown file = '$_'";
                }
            }
            # NWF Daily News
            when /:i nwfdn / {
                say "Working NWF Daily News file '$_'...";
                when /:i email / {
                    $str = get-nw-email :$nw-pub-date-std-format, :$mtg-month-name;
                }
                when /:i cross / {
                    $str = get-nw-cross :$nw-pub-date-std-format,:$mtg-date-std-format;
                }
                when /:i props / {
                    $str = get-nw-props :$nw-pub-date-std-format, :$mtg-date-std-format;
                }
                default {
                    die "FATAL: Unknown file = '$_'";
                }
            }
            default {
                die "FATAL: Unknown file = '$_'";
            }
        }

        # process the file
        my $md   = "{$dir}/{$f}.txt";
        my $docx = "{$dir}/{$f}.docx";
        spurt $md, $str;
        my $cmd = "pandoc -o $docx $md";
        shell $cmd;
        if $test {
            @ofils.append: $md;
        }
        else {
            unlink $md;
        }
        @ofils.append: $docx;

    }

}

multi sub date-std-fmt(Date $D) {
    # e.g., "May 7, 2019"
    my $y = $D.year;
    my $d = $D.day;
    my $m = $D.month;
    state $dn = Date::Names.new: :mset('mon');

    return sprintf "%s %d, %d", $dn.mon($m), $d, $y;
}
