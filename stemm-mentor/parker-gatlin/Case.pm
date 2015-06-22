package Case;

use Moose

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

no Moose;
__PACKAGE__->meta->make_immutable;
