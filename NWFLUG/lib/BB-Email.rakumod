unit module BB-Email;

sub get-bb-email(:$bb-pub-date-std-format!,
                 :$mtg-month-name!,
                 :$mtg-year!,
                ) is export {

my $ltr = qq:to/HERE/;
TO: Bay Beacon

CC: NWFLUG

SUBJ: Bimonthly Meeting of the Northwest Florida Linux User Group (NWFLUG)

Dear Sir or Madam:

Attached is a press release announcing the next bimonthly meeting
($mtg-month-name) of the Northwest Florida Linux User Group (NWFLUG)
to which all interested persons are invited.

I would appreciate it if appropriate details could be entered into the
"{$mtg-year} Calendar" column for the Bay Beacon issue for
{$bb-pub-date-std-format}.

Best regards,

-Tom

Thomas M. Browder, Jr.\\
113 Canterbury Circle\\
Niceville, FL  32578\\
850-830-8078 (M)
HERE

return $ltr;

}
