unit module NW-Email;

sub get-nw-email(:$mtg-month-name!,
                 :$nw-show-date-std-format!,
                ) is export {

my $ltr = qq:to/HERE/;
TO: NWF Daily News

ATTN: Ms. Brenda Shoffner

CC: NWFLUG

SUBJ: {$mtg-month-name} Meeting of the Northwest Florida Linux User Group (NWFLUG)

Dear Ms. Shoffner:

Attached is a press release announcing the next meeting of the
Northwest Florida Linux User Group (NWFLUG) to which all interested
persons are invited.

I would appreciate it if appropriate details could be entered into
the Sunday Lifestyle section for
{$nw-show-date-std-format}.

Best regards,

-Tom

Thomas M. Browder, Jr.\\
113 Canterbury Circle\\
Niceville, FL  32578\\
850-830-8078 (M)
HERE

return $ltr;

}