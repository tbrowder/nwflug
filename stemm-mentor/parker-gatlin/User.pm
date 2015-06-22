package User;

use v5.14;

use Moose;
use namespace::autoclean;

# this class will be used to hold a user entry in the user data and
# results file

use Case;

=pod

# data format

user: <id> # unique-integer
 name: <optional>
 next_casenumber: int
  case: <id> # unique-integer-for-user
    date: yyyy-dd-mm-hh:mm:ss.ss
    keylen: integer
    maxkeys: integer
    random_seed: integer
    keyindex: integer
    numtries: integer
 endcase:
enduser:

=cut

has 'id' => (
    is  => 'rw',
    isa => 'Int',
);

has '_next_casenum' => (
    is  => 'rw', # this needs to be private
    isa => 'Int',
    default => 0,
);

has 'name' => (
    is  => 'rw',
    isa => 'Str',
    default => '',
);

has 'cases' => (
    is  => 'rw',
    isa => 'HashRef',
    default => sub { {} },
);

sub get_next_casenum {
  my $self = shift @_;
  my $cn = $self->_next_casenum;
  $self->_next_casenum($cn+1);
  return $cn;
}

sub write {
  my $self = shift @_;
  my $fp   = shift @_;
  say $fp 'user: ' . $self->id();
  say $fp '  name: ' . $self->name();
  say $fp '  next_casenumber: ' . $self->_next_casenum();

  my %h = %{$self->cases()};
  my @k = (sort { $a <=> $b } keys %h);

  return if (!@k);

  foreach my $k (@k) {
    my $c = $h{$k};
    $c->write($fp);
  }

  # don't forget to end it
  say $fp "enduser:";

}

__PACKAGE__->meta->make_immutable;


