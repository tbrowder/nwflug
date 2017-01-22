#!/usr/bin/env perl6

my @fmts = <
s5
dzslides
slidy
slideous
revealjs
beamer
>;

my ($cmd, $out);
my $base = 'agenda';
my $in = $base ~ '.pdoc';

for @fmts -> $t {
  $out = $base ~ "-$t.html";
  $cmd = "pandoc --self-contained -t $t -s $in -o $out";
  #say 'Type: ' ~ $t;
  if $t ~~ m/s5/ {
    say "  S5: '$out'";
    #shell "pandoc -D $t";
  }
  elsif $t ~~ m/dzs/ {
    say "  DZSlides: '$out'";
    #shell "pandoc -D $t";
  }
  elsif $t ~~ m/slidy/ {
    say "  Slidy: '$out'";
    #shell "pandoc -D $t";
  }
  elsif $t ~~ m/slide/ {
    say "  Slideous: '$out'";
    #shell "pandoc -D $t";
  }
  elsif $t ~~ m/rev/ {
    say "  Reveal.js: '$out'";
    #shell "pandoc -D $t";
  }
  elsif $t ~~ m/beam/ {
    $out = $base ~ "-$t.pdf";
    $cmd = "pandoc -t $t $in -o $out";
    say "  Beamer: '$out'";
    #shell "pandoc -D $t";
  }

  # execute the command
  shell $cmd;
}


