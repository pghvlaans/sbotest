#!/usr/bin/perl
# vim: ts=4:noet

# Use this script with a space-separated queue of scripts to find out
# how many package installations and removals would happen if they were
# evaluated by sbotest in that order.
#
# The "ADDED TOO EARLY" message indicates that a script was added to the
# queue after one or more of its reverse dependencies.
#
# For best results, ensure that the sbotools repository has been fetched
# from the same place that sbotest would use in your testing setup.

use 5.016;
use strict;

use SBO::Lib qw/ :config :const get_build_queue in get_all_available slurp @concluded /;

unless (@ARGV) {
	say "Usage - ./queue_test.pl file";
	exit 1;
}

my $file = shift;
unless (-s $file) {
	say "Queue file not found; exiting.";
	exit 1;
}

my $file_text = slurp $file;
my @test_queue = split " ", $file_text;

my (@installed, @installed_outgoing);

my $install_count = 0;
my $removal_count = 0;
my $package_count = 0;

my %already_queued;
my $bad_queue = 0;

get_all_available();

for my $sbo (@test_queue) {
	splice @concluded;
	$bad_queue++ if $already_queued{$sbo};
	$package_count++;
	print "\n$sbo: $package_count\n";
	print "ADDED TOO EARLY\n" if $already_queued{$sbo};
	my %warnings;
	my (@to_install, @to_remove);
	my $queue = get_build_queue([$sbo], \%warnings);
	pop @$queue;
	$already_queued{$_} = 1 for @$queue;
	@installed_outgoing = @installed;
	@installed = @$queue;
	if (@installed or @installed_outgoing) {
		if (not @installed) {
			@to_remove = @installed_outgoing;
		} elsif (not @installed_outgoing) {
			@to_install = @installed;
		} else {
			@to_install = grep { not in $_, @installed_outgoing } @installed;
			@to_remove = grep { not in $_, @installed } @installed_outgoing;
		}
		$install_count += @to_install;
		$removal_count += @to_remove;
		print "\nInstalled: $install_count\nRemoved: $removal_count\n";
	} else {
		print "\nInstalled: $install_count\nRemoved: $removal_count\n";
	}
}
print "\n$bad_queue added too early.\n";
$removal_count += @installed;
print "\nFinal Counts:\n\nInstalled: $install_count\nRemoved: $removal_count\n";
