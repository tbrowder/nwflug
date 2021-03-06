unit module NW-Cross;

sub get-nw-cross(:$nw-pub-date-std-format!,
                 :$mtg-date-std-format!,
                ) is export {

my $ltr = qq:to/HERE/;
**FOR IMMEDIATE RELEASE:**

**DESIRED NWF DAILY NEWS**\\
**SUNDAY LIFESTYLE PUBLICATION DATE: {$nw-pub-date-std-format}**

**Bimonthly Linux User Group Meeting**

*Niceville, Florida*

The Northwest Florida Linux User Group (NWFLUG) will hold its next
bimonthly meeting on Monday, {$mtg-date-std-format}, from 5:30 PM
until no later than 7:30 PM, in Room 400 of the Crosspoint United
Methodist Church in Niceville, Florida.

The featured presentation will be: ***ENTER DATA HERE***

Directions and details of the free, planned program can be found on
the group's website at <https://nwflug.org>.  All are invited to join
us at any meeting (and bring your laptops!).  Those planning to attend
are encouraged to notify us via email to <tom.browder@gmail.com>.

For more information, contact Tom Browder.

Contact:\\
Tom Browder\\
<tom.browder@gmail.com>\\
113 Canterbury Circle\\
Niceville, FL  32578\\
Ph: 850-830-8078 (M)

###
HERE

return $ltr;

}
