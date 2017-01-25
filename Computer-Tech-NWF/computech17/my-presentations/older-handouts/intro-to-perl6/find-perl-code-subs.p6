#!/usr/bin/env perl6

# collect the raw data
my $f1 = 'allpl.txt.clean';
my $f2 = 'allpm.txt.clean';
my @fi = [$f1, $f2];

# output cleaned data
my $f1o = 'allpl.subs.txt';
my $f2o = 'allpm.subs.txt';
my @fo = [$f1o, $f2o];

my (%pl, %pm);
for @fi -> $fi {
    say "Working file '$fi'...";
    # open input file
    my $fpi = open($fi);

    my ($fo, %h);
    if $fi eq $f1 {
	$fo = $f1o;
	%h = %pl;
    }
    else {
	$fo = $f2o;
	%h = %pm;
    }

    # keep track of maxlen of all sub names for neater output
    my $mlen = 0;

    FILE:
    for $fpi.lines -> $fline {
	my $pfil = $fline.words[0];
        my $mtim = $fline.words[1]; # dddddddddddddd'
	my $pdir = $fline.words[2];
	say "DEBUG: file is '$pfil'";
	#next FILE;

        my $fil = "$pdir/$pfil";
	# open the file
	for $fil.IO.lines -> $line {
	    #say "DEBUG: line '$line'";
	    next if $line !~~ /^ \s* sub \s+ (\w+) /;
	    my $sub = $0;

            say "DEBUG: a 'sub' line: '$line'";
            say "            sub name '$sub'";

	    # save max len of sub name
	    my $len = $sub.chars;
	    $mlen = $len if $len > $mlen;

	    # put $sub in hash if not exists
	    if %h{$sub}:exists {
		if $mtim > %h{$sub}<mtime> {
		    %h{$sub}<file>  = $fil;
		    %h{$sub}<mtime> = $mtim;
		}
	    }
	    else {
		# new entry
		my $len = $sub.chars;
		$mlen = $len if $len > $mlen;
		%h{$sub}<file>  = $fil;
		%h{$sub}<mtime> = $mtim;
	    }
	    #$fpo.say("$fil $dir");

	    # Print sorted list of subs and their file
	}
    }

    # open output file
    my $fpo = open($fo, :w);

    # now output file
    for %h.sort(*.key)>>.keys -> ($sub) {
        my $fil        = %h{$sub}<file>;
        my $mtime_inst = %h{$sub}<mtime>;
        #my $mtime      = DateTime.new("Instant:$mtime_inst");

        my $str = sprintf("%-*.*s $mtime_inst $fil", $mlen, $mlen, $sub);
        $fpo.say($str);
    }

}



for @fo {
    say "See output file '$_'";
}
