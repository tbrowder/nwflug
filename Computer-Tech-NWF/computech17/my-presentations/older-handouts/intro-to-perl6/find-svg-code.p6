#!/usr/bin/env perl6

# collect the raw data
my $f1 = 'allsvg.txt';
my @fi = [$f1];

# output cleaned data
my $f1o = 'allsvg.txt.clean';
my @fo = [$f1o];
my $f3o = 'allsvg-dirs.txt';

if not $f1.IO.e {
    shell "locate .svg | grep '.svg\$' > $f1";
}

# dirs to ignore
my regex dirs {
  ^
  \s*
  [   # non-capturing grouping
    | '/home/tbrowde/.config'
    | '/home/tbrowde/.rakudobrew'
    | '/home/tbrowde/Downloads'
    | '/home/tbrowde/rakudo-star-2015.07'
    | '/usr/local/apache2/icons'
    | '/usr/local/bzr-repos/1-postorius'
    | '/usr/local/git-repos/github/brlcad-debian-package.git'
    | '/usr/local/opt/smartsvn'
    | '/usr/local/people/tbrowde/mydata/OxygenXMLEditor'
    | '/usr/local/people/tbrowde/mydata/tbrowde-home-bzr/perl6'
    | '/perl5-repo-forks/rakudo-and-nqp-internals-course'
    | '/usr/local/share'
    | '/usr/local/src'
    | '/usr/share'
    | '/var/lib'
  ]
}

my (%svg, %sd);
for @fi -> $fi {
  say "Working file '$fi'...";
  # open input file
  my $fpi = open($fi);
  
  my ($fo, %h);
  if $fi eq $f1 {
    $fo = $f1o;
    %h = %svg;
  }
  else {
    die "What!";
  }
  
  # open output file
  my $fpo = open($fo, :w);
  
  # keep track of maxlen of file name for neater output
  my $mlen = 0;
  # read the files and strip lines with certain dirs
  LINE:
  for $fpi.lines -> $line {
    #say "DEBUG line: $line";
    
    # ignore certain dirs and files
    if $line ~~ / <dirs> / {
      #say "Skipping line '$line'.";
      next LINE;
    }
    
    $line.chomp;
    
    # skip if non-existent
    next LINE if !$line.IO.f; # 'ell'
    
    # ignore symlinks
    next LINE if $line.IO.l; # 'ell'
    
    my $idx = $line.rindex('/');
    if $idx {
      my $dir = $line.substr(0, $idx);
      #say "DEBUG: dir is a ", $dir.WHAT;
      my $fil = $line.substr($idx+1);
      
      if not %sd{$dir}:exists {
	%sd{$dir} = 1;
      }
      
      # chop dir
      #my $slen = 80;
      #$dir = $dir.substr(0, $slen);
      
      # get file size
      #my $fsiz = $line.IO.s;
      
      # get file mtime
      my $mtime_inst = $line.IO.modified; # mtime, a time integer
      my $mtime = DateTime.new($mtime_inst).posix;
      #say "DEBUG: time $mtime";
      
      if %h{$fil}:exists {
=begin comment
        if $fsiz > %h{$fil}<siz> {
          %h{$fil}<dir> = $dir;
	  %h{$fil}<siz> = $fsiz;
	}
=end comment
	
        if $mtime_inst > %h{$fil}<mtime> {
          %h{$fil}<dir>   = $dir;
	  %h{$fil}<mtime> = $mtime;
        }
      }
      else {
	# new entry
	my $len = $fil.chars;
	$mlen = $len if $len > $mlen;
	%h{$fil}<dir> = $dir;
	%h{$fil}<mtime> = $mtime;
      }
      #$fpo.say("$fil $dir");
    }
    else {
      next;
    }
  }
  
  # now output file
  for %h.sort(*.key)>>.keys -> ($fil) {
    my $dir = %h{$fil}<dir>;
    my $tim = %h{$fil}<mtime>;
    #say "DEBUG: time instant '$tim'";
    my $str = sprintf("%-*.*s $tim $dir", $mlen, $mlen, $fil);
    $fpo.say($str);
  }
}

# open last output file for dirs
@fo.push($f3o);
my $fpo = open($f3o, :w);
for %sd.sort(*.key)>>.keys -> ($dir) {
  $fpo.say($dir);
}

for @fo {
  say "See output file '$_'";
}
