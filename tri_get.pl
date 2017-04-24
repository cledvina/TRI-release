#!/usr/bin/env perl
use LWP::Simple;
use LWP::Simple qw($ua get);
$ua->agent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:29.0) Gecko/20100101 Firefox/29.0');
$ua->timeout(5);
my $path = shift or die "Usage > tri_get.pl pathfile (html|csv)\n";
my $ext = shift;
if ($ext !~ /^(html|csv)$/) {
	print "Please enter extension (html or csv)\n";
	exit;
}
open LINKS, $path or die "Can't find $path file!\n";
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
	$fn = "$data/${fn}_$year.$ext";
	if (-e $fn) {
		print "$fn already exists-- moving on...\n";
		next;
	}
	print "$i. Getting $url > $fn\n\n";
	getstore($url,$fn);
}
