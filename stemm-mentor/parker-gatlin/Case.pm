package Case;

use Moose;
use namespace::autoclean;

# this class will be used to hold a user's case entry in the user data
# and results file

# see 'User.pm' for the data file format

has 'id' => (
    is  => 'rw',
    isa => 'Int',
);

has 'date' => (
    # format: yyyy-dd-mm-hh:mm:ss.ss
    is  => 'rw',
    isa => 'Str',
);

has 'keylen' => (
    is  => 'rw',
    isa => 'Int',
);

has 'maxkeys' => (
    is  => 'rw',
    isa => 'Int',
);

has 'numtries' => (
    is  => 'rw',
    isa => 'Int',
);

has 'keyindex' => (
    is  => 'rw',
    isa => 'Int',
);

has 'random_seed' => (
    is  => 'rw',
    isa => 'Int',
);

sub write {
  my $self = shift @_;
  my $fp   = shift @_;
  say $fp '  case: ' . $self->id();
  say $fp '    date: ' . $self->date();
  say $fp '    keylen: ' . $self->numtries();
  say $fp '    maxkeys: ' . $self->maxkeys();
  say $fp '    random_seed: ' . $self->random_seed();
  say $fp '    keyindex: ' . $self->keyindex();
  say $fp '    numtries: ' . $self->numtries();

  # don't forget to end it
  say $fp '  endcase:';

}

__PACKAGE__->meta->make_immutable;
