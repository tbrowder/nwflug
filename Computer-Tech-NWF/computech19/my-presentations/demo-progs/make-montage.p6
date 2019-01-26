#!/usr/bin/env perl6

use File::Find;

use lib <./lib>;
use Montage;

if !@*ARGS {
    say qq:to/HERE/;
    Usage: $*PROGRAM gen dir=<dir> [debug]

    Options:

      gen       Generates PostScript montage(s) of eps images
                found in or below the -dir=<dir> directory.
                A max of $maxpics images are on each montage file.
                The montage ps files are converted to pdf and deleted
                unless the debug option is used.

      show      Shows info about the set of images.

    Other:

      Stats     Add group max w/h stats to show data

      debug     For developer use

      trim      Trim name to <basename> only (elim path)

    HERE
  exit;
}

my $gen   = 0;
my $show  = 0;
my $debug = 0;
my $stats = 0;
my $trim  = 0;

my $dir = '';
for @*ARGS {
    when /^ g/ { $gen = 1; $show = 0 }
    when /^ s/ { $show = 1; $gen = 0 }
    when /^ d/ { $debug = 1 }
    when /^ S/ { $stats = 1 }
    when /^ t/ { $trim = 1; }
    when /^ '-'? 'dir=' (.+) $/ {
        $dir = ~$0.IO; # ensures dir carries abs path info

        if !$dir.IO.d {
            die "FATAL: Unknown dir '$dir'";
        }
    }
    default {
        die "FATAL: Unknown arg '$_'";
    }
}

if !$dir {
    say "FATAL: No 'dir' selected.";
    exit;
}

my @eps   = find(dir => $dir, name => / ".eps" $ /).sort;
if $debug {
    if 1 {
        @eps = @eps[0];
    }
}

my $ne    = +@eps;
my $ngrps = num-groups($ne, $maxpics);

if $ne {
    my $s = $ne > 1 ?? 's' !! '';
    say "Found $ne eps file{$s} in dir '$dir'.";
    say "That will result in {$ngrps} montage file(s).";
}
else {
    say "No eps files found.";
}

# groups: 0..^N
# %data{$groupnum}
#     <group>
#            {stat1}
#            {stat2}
#            {statN}
#     <pics>
#        {$picname}
#            {stat1}
#            {stat2}
#            {statN}
my %data;
say "DEBUG: num eps files $ne" if $debug;
my $n; # use for loops
#loop ($n = 0; $n < $ngrps; ++$n) {
for ^$ngrps -> $n {
    # pics are in groups of 1..^$maxpics
    my $begin-idx = $n * $maxpics;
    my $num-in-group = $maxpics;
    my $end-idx = $begin-idx + $num-in-group - 1;
    if $end-idx > $ne - 1 {
        $end-idx = $ne - 1;
        $num-in-group = $end-idx - $begin-idx + 1;
    }
    my $remain = $ne - $end-idx - 1;

    if $debug {
        say "DEBUG: group $n:";
        say "  num in group: $num-in-group";
        say "  num remaining: $remain";
        say "  idx begin: $begin-idx";
        say "  idx end:   $end-idx";
    }
    my @pics = @eps[$begin-idx..$end-idx];
    collect-eps-data :@pics, :groupnum($n), :%data, :$debug, :$stats;
}

if $show {
    for 0..^$ngrps -> $n {
        say "Group $n stats ===========================";
        say "  num pics: {%data{$n}<pics>.elems}";
        if $stats {
            my $s = %data{$n}<group>;
            say    "  Longest name = {$s.max-nam-char-nam} ({$s.max-nam-chars} chars)";
            printf "  Max width  = {$s.maxw} points (%.2f inches)\n", $s.maxw/72;
            printf "  Min width  = {$s.minw} points (%.2f inches)\n", $s.minw/72;
            printf "  Max height = {$s.maxh} points (%.2f inches)\n", $s.maxh/72;
            printf "  Min height = {$s.minh} points (%.2f inches)\n", $s.minh/72;
            say qq:to/HERE/;
              Widest picture:    {$s.maxw-nam}
              Narrowest picture: {$s.minw-nam}
              Tallest picture:   {$s.maxh-nam}
              Shortest picture:  {$s.minh-nam}
            HERE
            printf "  Max x = {$s.maxx} points (%.2f inches)\n", $s.maxx/72;
            printf "  Min x = {$s.minx} points (%.2f inches)\n", $s.minx/72;
            printf "  Max y = {$s.maxy} points (%.2f inches)\n", $s.maxy/72;
            printf "  Min y = {$s.miny} points (%.2f inches)\n", $s.miny/72;
            say qq:to/HERE/;
              Max x picture: {$s.maxx-nam}
              Min x picture: {$s.minx-nam}
              Max y picture: {$s.maxy-nam}
              Min y picture: {$s.miny-nam}
            HERE
        }
    }
    exit;
}

die "UNEXPECTED numm \$gen" if !$gen;
my @ofils;
for ^$ngrps -> $n {
    my $psfil = "{$basename}-{$n}.ps";
    my $pdf  = "{$basename}-{$n}.pdf";
    gen-montage :%data, :groupnum($n), :psfil("$*CWD/$psfil"),
        :template("$*CWD/lib/$template"), :$trim;
    # convert to pdf
    run "ps2pdf", $psfil;
    push @ofils, $pdf;
    if $debug {
        push @ofils, $psfil;
    }
    else {
        unlink $psfil;
    }
}

say "Normal end.";
if @ofils {
    my $n = +@ofils;
    my $s = $n > 1 ?? 's' !! '';
    say "See output file$s:";
    say "  $_" for @ofils;
}
else {
    say "No output files generated.";
}
say "NOTE: \$debug is ON" if $debug;
