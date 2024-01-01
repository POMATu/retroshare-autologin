#!/usr/bin/perl

use strict;
use warnings;

my $delay = 1;
my $max = 100;


my $i = 0;

while ($i < $max) {
	$i++;
	my $windows = `wmctrl -l`;
	my @lines = split /\n/, $windows;
	
	# Iterate through each line using foreach loop
	foreach my $line (@lines) {
	    # Do something with each line, for example, print it
	     if ($line =~ /RetroShare$/) {
	     	print "Found probably login screen\n";
	        if ($line =~ /0x([0-9a-fA-F]+)/) {
	    		my $wmhex = $1;
	    		print "Hex Value: $wmhex\n";
	    		my $wmdec = hex($wmhex);
	    		print "Dec Value: $wmdec\n";

	    		system("xdotool key --window $wmdec Return");
			} else {
	    		print "No hex value found in the line.\n";
			}
	    } elsif ($line =~ /retroshare$/) {
	    	print "Found splash screen, exiting\n";
	    	exit;
	    }
	}
	sleep($delay);
}