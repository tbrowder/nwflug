package Case;

use Moose

# this class will be used to hold a user's case entry in the user data
# and results file

=pod

# data format

  case: unique-integer-for-user
    date: yyyy-dd-mm-hh:mm:ss.ss
    keylen: integer
    maxkeys: integer
    numtries: integer
 endcase:

=cut
