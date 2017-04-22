#!/usr/bin/env perl
use LWP::Simple;
my $ext = shift;
if ($ext !~ /^(html|csv)$/) {
	print "Please enter extension (html or csv)\n";
	exit;
}
open LINKS, 'paths.txt' or die "Can't find paths.txt file!\n";
my $data = '../data';
my $i = 0;
while (<LINKS>) {
	chomp;
	$i++;
	my ($url, $fn) = split /\t/;
	$url .= '&pOUTPUT=CSV' if $ext eq 'csv';
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
