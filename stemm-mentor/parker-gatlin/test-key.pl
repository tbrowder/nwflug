#!/usr/bin/env perl

use v5.12;
use strict;
use warnings;

use File::Basename;
use Tk;
use Data::Dumper;
use POSIX;
use File::Copy;

use lib '.';
use User;

# place limits on key length
my $max_keylen =  8; #  256
#my $max_keylen =  9; #  512
#my $max_keylen = 10; # 1024
#my $max_keylen = 11; # 2048
# limit on ID
my $max_int = POSIX::INT_MAX;
my $max_int_minus_1 = $max_int - 1;

my $p = basename $0;
if (!@ARGV) {
  print <<"HERE";
Usage: $p <keylen> id=<ID> | analyze [debug]

where

  <keylen>   - integer: desired length of an N-bit key to test

  id=X       - X is a unique integer ID assigned by the tester

  analyze    - process existing data for study

Limits:

  Maximum key length: $max_keylen

  Mimimum ID: 0

  Maximum ID: $max_int_minus_1

HERE

  exit;
}

my $debug   = 0;
my $keylen  = undef;
my $id      = undef;
my $analyze = 0;
foreach my $arg (@ARGV) {
  my $val = undef;
  my $idx = index $arg, '=';
  if ($idx >= 0) {
    $val = substr $arg, $idx+1;
    $arg = substr $arg, 0, $idx;
  }
  if ($arg eq 'id' && defined $val) {
    $id = $val;
  }
  elsif ($arg =~ m{\A [-]?d(?:ebug)? \z}xi) {
    $debug = 1;
  }
  elsif (!defined $keylen) {
    $keylen = $arg;
  }
  else {
    die "FATAL:  Unknown option '$arg'.\n";
  }
}

die "FATAL:  You must select 'analyze' OR '<keylen>' and 'id=X'.\n"
  if (!$analyze && !defined $keylen && !defined $id);

if (!$analyze) {
  my $err = 0;

  if (!defined $keylen) {
    ++$err;
    say "ERROR:  You have not entered a value for <keylen>.";
  }
  else {
    if (!isdigit($keylen)) {
      ++$err;
      say "ERROR: Key length must be an integer.";
    }
    elsif ($keylen < 1 || $keylen > $max_keylen) {
      ++$err;
      say "ERROR: Key length must be a positve integer > 0 and <= $max_keylen.";
    }
  }

  if (!defined $id) {
    ++$err;
    say "ERROR:  You have not entered a value for 'id=X'.";
  }
  else {
    if (!isdigit($id)) {
      ++$err;
      say "ERROR:  ID must be an integer.";
    }
    elsif ($id < 0 || $id > $max_int_minus_1) {
      ++$err;
      say "ERROR:  ID must be an integer >= 0 and < $max_int_minus_1.";
    }
  }

  if ($err) {
    my $s = $err > 1 ? 's' : '';
    die "FATAL error$s.\n";
  }
}

# global variables ========================
my $datafile = 'test-key-data.txt';
my $datadir  = './test-key-data-dir';
my %users = ();

# read any data
read_data_file(\%users);

#print Dumper(\%users); die "debug exit";

my $curr_user = 0;
if (exists $users{$id}) {
  $curr_user = $users{$id};
}
else {
  $curr_user = User->new(id => $id);
  $users{$id} = $curr_user;
}
my $curr_casenum = $curr_user->get_next_casenum();
my $curr_case = Case->new(id => $curr_casenum);
$curr_case->date(get_timestamp());
$curr_user->cases->{$curr_casenum} = $curr_case;

# generate the key array
my @key_array = generate_key_array($keylen);
my %key_array;
# create a hash for lookup when testing for the correct key
@key_array{@key_array} = ();
my $nkeys = scalar @key_array;
my $nhalf = int($nkeys / 2);

# generate the secret key (and the actual random index number)
my ($secret_key, $sidx, $seed) = generate_secret_key(\@key_array);

my $solved  = 0;
my $ntries  = 0;
my %cb      = ();
my ($ntb, $ntb2);
my $basecolor = '#d9d9d9'; # the default button background color

# use GUI =====================

# the GUI
# prep for display
my $mw = MainWindow->new;
$mw->title("Secret Key");

# at least two frames
my $f1 = $mw->Frame();
my $f2 = $mw->Frame();

# key info
my $text_1 =<< "HERE";
Given key length N, there are 2^N possible N-bit keys.

Select keys until you guess the secret key.

Unsuccessful attempts prior to finding the key will turn yellow.

If the selected key is the secret one, it will turn green and no more tries are logged.  Further selections will turn red.
HERE

my $tb = $f1->Text(
		   -width => 40,
		   -wrap => 'word',
		   -relief => 'flat',
		   -height => 15,
		  )->pack(-side => 'top');
$tb->insert('end', $text_1);
$tb->configure(-state => 'disabled');

#
$f1->Button(
	    -text => "Number possible keys: $nkeys\nAverage tries to solve: $nhalf",
	    -relief => 'flat',
	   )->pack(-side => 'top');

$ntb = $f1->Button(
		   -text => "Random number generator seed:\n$seed",
		   -relief => 'flat',
		  )->pack(-side => 'top');

$ntb2 = $f1->Button(
		   -text => "Keys tried: $ntries\nKey index: ?",
		   -relief => 'flat',
		  )->pack(-side => 'top');

# reset button
$f1->Button(
	    -text => 'Reset',
	    -command => \&reset_case,
	   )->pack(-side => 'top');

# results and exit
$f1->Button(
	    -text => 'Done',
	    -command => sub { $mw->destroy },
	   )->pack(-side => 'bottom');
$f1->pack(-side => 'left');


# create check buttons with all possible keys, use colums with
# max of 24 rows (a grid)
my $nrows = $nkeys > 24 ? 24 : $nkeys;
my $xkeys = $nkeys % $nrows;
my $ncols = $nkeys <= $nrows ? 1 :
  $xkeys ? int(($nkeys - $xkeys)/$nrows) + 1 : int($nkeys/$nrows);

my $row   = 0;
my $col   = 0;
my $count = 0;
foreach my $k (@key_array) {
  my $cb = $f2->Checkbutton(
			    -text => $k,
			    -indicatoron => 0,
			    -command => [ \&handle_key,
					  $k,
					  $count,
					],
			   )->grid(-row => $row, -column => $col);
  # save the button in the hash
  $cb{$count} = $cb;

  # increment and test
  ++$count;
  ++$row;
  if ($row > $nrows - 1) {
    # time to increment
    $row = 0;
    ++$col;
  }
  say "DEBUG: row = $row; col = $col"
    if $debug;
}
$f2->pack(-side => 'right');

# the event loop
MainLoop();

# after bailing out, write data to file
write_data_file(\%users);

# present results
say "Normal end.";

#### subroutines ################################################
sub reset_case {
  # save data state
  $curr_case->date(get_timestamp());
  $curr_case->keylen($keylen);
  $curr_case->maxkeys($nkeys);
  $curr_case->random_seed($seed);
  $curr_case->keyindex($sidx);
  $curr_case->numtries($ntries);
  # save the data
  write_data_file(\%users);

  # update case number and get a new case
  $curr_casenum = $curr_user->get_next_casenum();
  $curr_case = Case->new(id => $curr_casenum);
  $curr_case->date(get_timestamp());
  $curr_user->cases->{$curr_casenum} = $curr_case;

  # reset other variables
  $ntries = 0;
  $solved = 0;

  # reset problem with new secret key
  ($secret_key, $sidx, $seed) = generate_secret_key(\@key_array);

  $ntb->configure(
		  -text => "Random number generator seed:\n$seed",
		   -background => $basecolor,
		 );

  # reset the key array display
  $ntb2->configure(
		   -text => "Keys tried: $ntries\nKey index: ?",
		   -background => $basecolor,
		 );
  while (my ($k, $cb) = each %cb) {
    $cb->configure(
		   -state => 'active',
		  );
    $cb->deselect();
  }


} # reset_case

sub read_data_file {
  my $href = shift @_; # hash of users and their cases, if any

  if (! -d $datadir) {
    mkdir $datadir;
  }

  my $fname = "${datadir}/${datafile}";
  if (! -f $fname) {
    return;
  }
  else {
    open my $fp, '<', $fname
      or die "$fname: $!";
    parse_data_file($fp, $href);
    close $fp;
  }

} # read_data_file

sub write_data_file {
  my $href = shift @_;

  if (! -d $datadir) {
    mkdir $datadir;
  }
  my $fname = "${datadir}/${datafile}";
  my $ts = get_timestamp();

  my $fname_bak = "${fname}.${ts}";
  if (-e $fname_bak) {
    die "FATAL:  Unexpected duplicate backup file name '$fname_bak'.";
  }

  my %h = %{$href};
  my @k = (sort { $a <=> $b } keys %h);

  # return if nothing exists to write
  return if !@k;

  open my $fp, '>', $fname_bak
      or die "$fname_bak: $!";
  # dump contents of hashref
  # ...
  foreach my $k (@k) {
    my $u = $h{$k};
    $u->write($fp);
  }
  close $fp;

  # copy the file to the unadorned name (overwrite existing)
  copy($fname_bak, $fname);

} # write_data_file

sub handle_key {
  my $sel_key = shift @_;
  my $count   = shift @_;

  my $scb = $cb{$count};

  if ($solved) {
    # do nothing
    # turn button red
    $scb->configure(-selectcolor => 'gray');
    $scb->configure(-disabledforeground => 'red');
    $scb->configure(-state => 'disabled');
  }
  elsif ($sel_key eq $secret_key) {
    ++$ntries;
    # turn button green
    $scb->flash();
    $scb->configure(-selectcolor => 'gray');
    $scb->configure(-disabledforeground => 'green');
    $scb->configure(-state => 'disabled');

    # status window
    $ntb2->configure(
		     -text => "Keys tried: $ntries\nKey index: $sidx",
		     -background => 'green',
		   );
    $solved = 1;

    # save data state
    $curr_case->date(get_timestamp());
    $curr_case->keylen($keylen);
    $curr_case->maxkeys($nkeys);
    $curr_case->random_seed($seed);
    $curr_case->keyindex($sidx);
    $curr_case->numtries($ntries);
    # save the data
    write_data_file(\%users);

  }
  else {
    ++$ntries;
    # turn off the button
    $scb->configure(-selectcolor => 'gray');
    $scb->configure(-disabledforeground => 'yellow');
    $scb->configure(-state => 'disabled');

    # status window
    $ntb2->configure(-text => "Keys tried: $ntries\nKey index: ?");
  }

} # handle_key

sub generate_secret_key {
  my $aref  = shift @_;

  my $nkeys = scalar @{$aref};

  # get a random integer     [0..$nkeys-1]
  #   mathematically same as [0..$nkeys)
  use Math::Random::MT;
  # we want a new seed every time for a new session
  my $rng = Math::Random::MT->new(); # random seed by based on gettimeofday
  # the seed actually used above:
  my $seed = $rng->get_seed();
  my $secret_key_idx = int($rng->rand($nkeys)); # [0..$nkeys)
  return ($aref->[$secret_key_idx], $secret_key_idx, $seed);

=pod

  # if a fixed seed is desired
  my $rng = Math::Random::MT->new($seed); # seeded by unsigned 32-bit integer

=cut


} # generate_secret_key

sub generate_key_array {
  my $keylen = shift @_;

  my $n = 2 ** $keylen;
  my @key_array = ();
  foreach my $i (0..$n-1) {
    my $k = sprintf "%.*b", $keylen, $i;
    push @key_array, $k;
  }

  return @key_array;

} # generate_key_array

sub get_timestamp {
  # get a time string (NO spaces) to add onto a saved file
  my ($sec,$min,$hour,$mday,$mon,$year) = localtime(time);
  return sprintf("%04d-%02d-%02d.%02dh%02dm%02ds", $year+1900, $mon + 1, $mday, $hour, $min, $sec);
} # get_timestamp

sub parse_data_file {
  my $fp   = shift @_;
  my $href = shift @_;

  my $curr_user = 0;
  my $curr_case = 0;

  while (defined(my $line = <$fp>)) {
    chomp $line;
    my $idx = index $line, ':';
    if ($idx >= 0) {
      my $k = substr $line, 0, $idx;
      # needs trimming
      $k =~ s{\A \s*}{}x;
      $k =~ s{\s* \z}{}x;

      my $val = substr $line, $idx+1;
      # needs trimming
      $val =~ s{\A \s*}{}x;
      $val =~ s{\s* \z}{}x;
      # User attributes
      if ($k eq 'user') {
	$curr_user = User->new(id => $val);
	$href->{$val} = $curr_user;
      }
      elsif ($k eq 'name') {
	$curr_user->name($val);
      }
      elsif ($k eq 'next_casenumber') {
	$curr_user->_next_casenum($val);
      }
      elsif ($k eq 'case') {
	$curr_case = Case->new(id => $val);
	$curr_user->cases->{$val} = $curr_case;
      }
      # Case attributes
      elsif ($k eq 'date') {
	$curr_case->date($val);
      }
      elsif ($k eq 'keylen') {
	$curr_case->keylen($val);
      }
      elsif ($k eq 'maxkeys') {
	$curr_case->maxkeys($val);
      }
      elsif ($k eq 'random_seed') {
	$curr_case->random_seed($val);
      }
      elsif ($k eq 'keyindex') {
	$curr_case->keyindex($val);
      }
      elsif ($k eq 'numtries') {
	$curr_case->numtries($val);
      }
      elsif ($k eq 'enduser') {
	die "FATAL: \$curr_user = 0"
	  if !$curr_user;
      }
      elsif ($k eq 'endcase') {
	die "FATAL: \$curr_case = 0"
	  if !$curr_case;
      }
    }
    if ($debug) {
      print STDERR "DEBUG: line = '$line'\n";
    }
  }
} # parse_data_file

__END__
#=========================
# code for testing without a GUI
#print Dumper(\@key_array);
#print Dumper(\%key_array);

say "All $nkeys possible keys:";
foreach my $k (@key_array) {
  say "  $k";
}
say "\nSecret key:";
say "  $secret_key";
say "Secret key index: $sidx";
# end testing without a GUI
#=========================
