package User;

use Moose;

# this class will be used to hold a user entry in the user data and
# results file

use Case;

=pod

# data format

user: <id> # unique-integer
 name: <optional>
  case: <id> # unique-integer-for-user
    date: yyyy-dd-mm-hh:mm:ss.ss
    keylen: integer
    maxkeys: integer
    numtries: integer
    keyindex: integer
    random_seed: integer
 endcase:
enduser:

=cut

has 'id' => (
    is  => 'rw',
    isa => 'Int',
);

has 'name' => (
    is  => 'rw',
    isa => 'Str',
);

has 'case' => (
    is  => 'rw',
    isa => 'HashRef',
);

no Moose;
__PACKAGE__->meta->make_immutable;


