unit module NW-Props;

sub get-nw-props(:$nw-showdate-std-format!,
                 :$mtg-date-std-format!,
                ) is export {

my $ltr = qq:to/HERE/;
FOR IMMEDIATE RELEASE:

DESIRED NWF DAILY NEWS\\
SUNDAY LIFESTYLE PUBLICATION DATE: {$nw-showdate-std-format}

Linux User Group Meeting

Niceville, Florida

The Northwest Florida Linux User Group (NWFLUG) will hold its next
monthly meeting on Monday, {$mtg-date-std-format}, from 5:30 PM until no
later than 7:30 PM, in the front room of the Props Ale House in
Niceville, Florida.  Directions and details of the (always free)
planned program can be found on the group's website at
<https://nwflug.org>.  All interested persons are invited to join us
(and bring your laptops!).  Persons planning to attend are encouraged
to notify us via email to <tom.browder@gmail.com>.

For more information, contact Tom Browder.

Contact:\\
Tom Browder\\
tom.browder@gmail.com\\
113 Canterbury Circle\\
Niceville, FL  32578\\
Ph: 850-830-8078 (M)\\
###
HERE

return $ltr;

}
