#!/usr/bin/env perl

use v5.12;
use strict;
use warnings;

use File::Basename;
use Tk;
use Data::Dumper;
use POSIX;

my $p = basename $0;
if (!@ARGV) {
  print <<"HERE";
Usage: $p keylen [-debug]

where 'keylen' is the desired length of an N-bit
  key to test.

HERE

  exit;
}
my $debug  = 0;
my $keylen = undef;
foreach my $arg (@ARGV) {
  if ($arg =~ m{\A [-]?d(?:ebug)? \z}xi) {
    $debug = 1;
  }
  elsif (!defined $keylen) {
    $keylen = $arg;
  }
  else {
    die "FATAL:  Unknow option '$arg'.\n";
  }
}

# place limits on key length
my $max_keylen =  8; #  256
#my $max_keylen =  9; #  512
#my $max_keylen = 10; # 1024
#my $max_keylen = 11; # 2048

die "Key length must be an integer.\n"
  if !isdigit($keylen);
die "Key length must be a positve integer > 0 and <= $max_keylen.\n"
  if ($keylen < 1 || $keylen > $max_keylen);

# generate the key array
my @key_array = generate_key_array($keylen);
my %key_array;
# create a hash for lookup when testing for the correct key
@key_array{@key_array} = ();
my $nkeys = scalar @key_array;
my $nhalf = int($nkeys / 2);

# generate the secret key (and the actual random index number)
my ($secret_key, $sidx) = generate_secret_key(\@key_array);

# some global variables
my $solved  = 0;
my $ntries  = 0;
my %choices = ();
my %cb      = ();
my $ntb;

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
$f1->Button(
	    -text => "Number possible keys: $nkeys\nAverage tries to solve: $nhalf",
	   )->pack(-side => 'top');

$ntb = $f1->Button(
		   -text => "Keys tried: $ntries",
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

# present results
say "Results:";

#### subroutines ####
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
    $ntb->configure(-text => "Keys tried: $ntries");
    $solved = 1;
  }
  else {
    ++$ntries;
    # turn off the button
    $scb->configure(-selectcolor => 'gray');
    $scb->configure(-disabledforeground => 'yellow');
    $scb->configure(-state => 'disabled');
    $ntb->configure(-text => "Keys tried: $ntries");
  }

} # handle_key

sub generate_secret_key {
  my $aref  = shift @_;
  my $nkeys = scalar @{$aref};

  # get a random integer     [0..$nkeys-1]
  #   mathematically same as [0..$nkeys)
  use Math::Random::MT;
  # we want a new seed every time
  my $rng = Math::Random::MT->new();    # random seed by based on gettimeofday
  # the seed actually used above:
  my $seed = $rng->get_seed();
  my $secret_key_idx = int($rng->rand($nkeys)); # [0..$nkeys)
  return ($aref->[$secret_key_idx], $secret_key_idx);

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
