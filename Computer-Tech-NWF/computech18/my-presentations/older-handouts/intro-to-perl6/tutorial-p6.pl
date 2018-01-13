#!/usr/bin/env perl6

# file: tutorial-p6.pl

# PRELIMS  ========================
use v6.c; # not required, but good practice for
          # maintenance
          # 'strict' and 'warnings' are the default

# Note: Using perl6 -v =>
#   '2015.07.1-66-g0dcbba7 built on MoarVM version 2015.07-8-gb8fdeae'

#use Data::Dump;

my $default_infile = 'tutorial-data.txt';
my $prog = $*PROGRAM.basename;

my $debug  = 0;
my $infile = 0;
my $usage  = "$prog: --go | --infile=<data file name>";
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
  if ($arg eq '-g' || $arg eq '--go') {
    $infile = $default_infile;
  }
  elsif ($arg eq '-i' || $arg eq '--infile') {
    $infile = $val;
  }
  elsif ($arg eq '-d' || $arg eq '--debug') {
    $debug = $val ?? $val !! 1;
  }
  elsif ($arg eq '-h' || $arg eq '--help' || $arg eq q{?}) {
    long_help();
  }
  else {
    die "FATAL:  Unknown argument '$oarg'.\n";
  }
}

# MAIN PROGRAM ========================
die "FATAL:  No such file '$infile'.\n"
  if $infile.IO !~~ :f;

my %user;
my @keywords = <last first job>;
my %keywords;
%keywords{@keywords} = ();

parse_data_file($infile, %user, $debug);

if $debug {
  say "DEBUG:  Dumping user hash after loading:";
  say %user.perl;
}
else {
  say 'Normal end.';
}

#### SUBROUTINES ========================
sub parse_data_file(Str $fname, # declare args
                    #Any $href,
                    %href,
                    Int $debug = 0) {

  say "Parsing input file '$fname'...";



  my $uid = Any; # p6 doesn't use 'undef'
  my $linenum = 0;
  for $fname.IO.lines -> $line is copy {
    ++$linenum;
    my $err = 0;
    # remove comments
    my $idx = index $line, '#', 0;
    if defined $idx {
      $line = $line.substr(0, $idx);
    }
    # skip blank lines
    next if $line !~~ /\S/; # '~~' and '!~~' for matching

    # every valid line must have a colon (':')
    # following a key word
    $idx = $line.index(':');
    if $idx.defined  {
      # ensure the key is lower case
      my $k = $line.substr(0, $idx).lc;
      # trim ws on both ends
      $k = $k.trim; # string object method

      my $val = $line.substr($idx+1); # use object method
      # also needs trimming
      $val = $val.trim;

      # User attributes
      if $k eq 'user' {
        $uid = $val;
	die "FATAL:  \$uid not defined."
          if !$uid.defined;
        if $uid ~~ /\D/ {
          say "ERROR:  User ID not an integer.";
          ++$err;
        }
        elsif $uid <= 0 {
          say "ERROR:  User ID not an integer > 0.";
          ++$err;
        }
        elsif %href{$uid}:exists { # 'exists' adverb
          say "ERROR:  User ID is not unique.";
          ++$err;
        }
        next;
      }

      # for the following keys, an exception will be
      # thrown if $uid is not defined
      if !$uid.defined {
        say "ERROR: User ID is not defined for this user.";
          ++$err;
      }
      elsif $k eq 'hobbies' {
	# literal string keys must be quoted
        %href{$uid}<<hobbies>> = [];
        my @h = split ',', $val;
        for @h -> $h is rw {
          # trim ws on both ends
          $h .= trim;
	  # literal string keys must be quoted
          # use '@()' instead of '@{}
          push @(%href{$uid}<hobbies>), $h;
        }
      }
      elsif %keywords{$k}:exists {
        %href{$uid}{$k} = $val;
      }
      else {
        $line .= chomp;
        say "ERROR: Unknown line format, \$k = '$k'.";
	say "  '$line'";
        ++$err;
      }
    }
    else {
      say 'ERROR: Unknown line format (no key).';
      ++$err;
    }
    if $debug {
      $line .= chomp;
      say "DEBUG: line = '$line'";
    }
    if $err {
      $line .= chomp;
      say "FATAL error in file '$fname' at line $linenum:";
      say "  '$line'";
      exit;
    }
  }
} # parse_data_file

sub long_help {
  # note indent is taken from position of ending token
  say qq:to/HERE/;
  Usage (one of the following three):

    $prog --go                      (or '-g')
    $prog --infile=<data file name> (or '-i=')
    $prog --help                    (or '-h' or '?')

  The '--go' option uses the default input file:

    $default_infile

  Any of the first two options can use the '-d' (or '--debug')
    flag for debugging.
  A debug number may be provided with '-d=N' (or '--debug=N').

  HERE

  exit;
} # long_help
# EOF ========================
