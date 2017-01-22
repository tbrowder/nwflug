#!/usr/bin/env perl6

# collect the raw data
my $f1 = 'allpl.txt';
my $f2 = 'allpm.txt';
my @fi = [$f1, $f2];

# output cleaned data
my $f1o = 'allpl.txt.clean';
my $f2o = 'allpm.txt.clean';
my @fo = [$f1o, $f2o];
my $f3o = 'allperl-dirs.txt';

if not $f1.IO.e {
    shell "locate .pl | grep '.pl\$' > $f1";
}

if not $f2.IO.e {
    shell "locate .pm | grep '.pm\$' > $f2"; 
}

# dirs to ignore
my regex dirs {
  ^
  \s*
  [   # non-capturing grouping
    | '/home/tbrowde/.cpanm' 
    | '/home/tbrowde/.cpan' 
    | '/home/tbrowde/.rakudobrew' 
    | '/home/tbrowde/rakudo-star' 
    | '/opt' 
    | '/home/tbrowde/Downloads' 
    | '/usr/bin' 
    | '/usr/lib' 
    | '/usr/local/bin' 
    | '/usr/local/lib' 
    | '/usr/local/share' 
    | '/usr/local/src' 
    | '/usr/share' 
    | '/var/lib' 
    | '/usr/local/people/tbrowde/mydata/tbrowde-home-bzr/perl6' 
    | '/usr/local/people/tbrowde/mydata/ftagshtml' 
    | '/usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/primary-web-servers/addressbook' 
    | '/home/tbrowde/.local'
    | '/home/tbrowde/share/perl'
    | '/usr/local/git-repos/github/wwww-google-contacts.git'
    | '/usr/local/git-repos/sourceforge/tclap.git'
    | '/usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/mygnus.com'
    | '/usr/local/svn-repos/dbeaver'
    | '/home/tbrowde/vh1-home-files/vh1-mailman-files'
    | '/home/tbrowde/vh1-mailman-files'
    | '/usr/local/git-repos/ManTech-git-repos/rmtg-value-2009/0   RMTG final deliverables'
    | '/usr/local/git-repos/ManTech-git-repos/rmtg-value-2009/0 design and other devel docs'
    
  ]
}

# skip old BRL-CAD pl files and other known bad files
my regex bfils {
  | 'class0.pl'
  | 'bad_tri_cut.pl'
}

# skip other problem files
my regex pfils {
  | 'excel_funcs.pl'          # John McNamara
  | 'make_asi_color_book.pl'  # one of my PostScript files
  | 'process_bnc.pl'          # ditto
  | 'AUTO_PROG_ATTRS.pm'      # a Brawler prog
  | 'HarlemNights.pm'         # one of my PostScript files
  #| 'Helvetica.pm'            # one of my PostScript files
  #| 'HelveticaBold.pm'        # one of my PostScript files
  #| 'HelveticaBoldOblique.pm' # one of my PostScript files
  #| 'HelveticaOblique.pm'     # one of my PostScript files
}

my (%pl, %pm, %pd);
for @fi -> $fi {
  say "Working file '$fi'...";
  # open input file
  my $fpi = open($fi);
  
  my ($fo, %h);
  if $fi eq $f1 {
    $fo = $f1o;
    %h = %pl;
  }
  else {
    $fo = $f2o;
    %h = %pm;
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
    if $line ~~ / <dirs> | <bfils> | <pfils> / {
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
      
      if not %pd{$dir}:exists {
	%pd{$dir} = 1;
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
for %pd.sort(*.key)>>.keys -> ($dir) {
  $fpo.say($dir);
}

for @fo {
  say "See output file '$_'";
}
