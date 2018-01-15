#!/usr/bin/env perl6

use Text::More :ALL;
use Cairo:from<Perl5>;

if !@*ARGS {
    say qq:to/HERE/;
    Usage: $*PROGRAM <options} file.text

    Converts text to eps output.
    HERE
    exit;
}

