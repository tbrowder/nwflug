#!/usr/bin/env perl6

my $prog = $*PROGRAM.basename;

my $debug  = 0;
my $infile = 0;
my $usage  = "$prog: -i=<talk.md>";
$usage    ~= ' | --help | ? [--debug[=N]]'; # '~=' instead of '.='

# ARG/OPTION HANDLING ========================
# See [http://design.perl6.org/S06.html]
# for built-in methods similar to Getopts::Long
if !@*ARGS.elems {
  say $usage ~ "\n"; # '~' instead of '.'
  exit;
}

for @*ARGS -> $arg is copy { # 'is copy' allows modifying locally
  my $oarg = $arg; # save original for error handling
  my $val  = Any;  # 'Any' instead of 'undef'
  my $idx  = index $arg, '=';
  if $idx.defined { # index is defined if an index is found
    $val = substr $arg, $idx+1; # use substr function
    $arg = substr $arg, 0, $idx;
  }

  if ($arg eq '-i' || $arg eq '--infile') {
    $infile = $val.IO:path.basename;
  }
  elsif ($arg eq '-d' || $arg eq '--debug') {
    $debug = $val ?? $val !! 1;
  }
  elsif ($arg eq '-h' || $arg eq '--help' || $arg eq q{?}) {
    long-help();
  }
  else {
    die "FATAL:  Unknown argument '$oarg'.\n";
  }
}

# MAIN PROGRAM ========================
die "FATAL:  No such file '$infile'.\n"
  if $infile.IO !~~ :f;

my $outfile = stemname($infile) ~ '.pdoc';

my @fo = [$outfile];

say "Working file '$infile'...";
# open input file
  my $fpi = open($infile);
  
  # open output file
  my $fpo = open($outfile, :w);
  
  # read the file and strip lines with certain dirs
  LINE:
  for $fpi.lines -> $line {
    $line.chomp;
    
    #say "DEBUG line: $line";

    my $ifil = '';
    # ignore certain dirs and files
    if $line ~~ / ^ \s* \<\!\-\- \s+ insert\- (\w+) \s* $ / {
      $ifil = $0;
    }
    else {
      $fpo.print("$line\n");
      next LINE;
    }

    # skip if non-existent
    next LINE if !$line.IO.f; # 'ell'

    $fpo.print("\n");
    for $line.IO.lines -> $iline {
      $fpo.print("$iline\n");
    }
    $fpo.print("\n");
}

for @fo {
  say "See output file '$_'";
}

#### subroutines ####
sub long-help {
  say $usage;
  exit;
}

sub stemname($prog) {
  my $idx = rindex $prog, '.';
  if $idx {
    return $prog.substr(0, $idx);
  }
  return $prog;
} # stemname
