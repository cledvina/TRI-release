#!/usr/bin/env perl
use LWP::Simple;
open LINKS, 'paths.txt' or die "Can't find paths.txt file!\n";
my $ext = 'html';
my $data = '../data';
my $i = 0;
while (<LINKS>) {
	chomp;
	$i++;
	my ($url, $fn) = split /\t/;
	my $chem = $_;
	my $year = $_;
	$chem =~ s/.+&chemical=(\w+).*/$1/;
	$year =~ s/.+&YEAR=(\d+).*/$1/;
	$fn =~ s/\W/_/g;
	$fn = "${fn}_$year.$ext";
	print "$i. Getting $url >  '$fn'\n\n";
	getstore($url,"$data/$fn");
	sleep 1;
}
