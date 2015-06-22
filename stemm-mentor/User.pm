package User;

use Moose;

# this class will be used to hold a user entry in the user data and
# results file

use Case;

=pod

# data format

user: unique-integer
 name: <optional>
  case: unique-integer-for-user
    date: yyyy-dd-mm-hh:mm:ss.ss
    keylen: integer
    maxkeys: integer
    numtries: integer
 endcase:
enduser:

=cut


