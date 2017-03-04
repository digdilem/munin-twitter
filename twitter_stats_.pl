#!/usr/bin/perl -w
# -*- perl -*-

=head1 NAME

twitter_stats_ - Munin plugin to monitor basic stats of a twitter account. Tweets, following, followers and likes.

=head1 APPLICABLE SYSTEMS

Requires perl, NET::Twitter and a Twitter OATH account

=head1 CONFIGURATION

Create symbolic link to /etc/munin/plugins/twitter_stats_USERNAME
from /usr/share/munin/plugins/twitter_stats_

Change USERNAME to the twitter name, minus the @ - then set the OATH info below.
See https://dev.twitter.com/oauth for more info about getting a key.

Once done, restart munin-node

=head1 INTERPRETATION

This script logs into the twitter API via OAuth and grabs some basic stats. It could be expanded for more complicated data.

=head1 BUGS

None that I'm aware of.

=head1 MAGIC MARKERS

  #%# family=auto
  #%# capabilities=autoconf

=head1 VERSION

  $Id$

=head1 AUTHOR

Copyright 2017 Simon Avery (digdilem (AT) gmail.com)

=head1 LICENSE

GPLv3

=cut

# Set your Twitter OAuth info here
my $consumer_key    = "###############";
my $consumer_secret = "###############";
my $token    = "###############";
my $token_secret   = "###############";

# End user configuration

use Munin::Plugin;
use Net::Twitter;
no warnings;

my $username=$0;
$username =~ s/(.*)twitter_stats_//; # Get username from self filename

if ( defined($ARGV[0])) {
    if ($ARGV[0] eq 'autoconf') {
	print "yes\n";
	exit 0;
    }
}

    if ( $ARGV[0] eq "config" ) {
	print "graph_title Twitter user stats for $username\n";
	print "graph_args --base 1000 -l 0\n";
	print "graph_vlabel Points\n";
	print "graph_scale no\n";
	print "graph_category socialmedia\n";
	print "tweets.label tweets\n";
	print "tweets.draw LINE\n";
	print "tweets.info Tweets made.\n";
	print "following.label following\n";
	print "following.draw LINE\n";
	print "following.info following made.\n";
	print "likes.label likes\n";
	print "likes.draw LINE\n";
	print "likes.info likes made.\n";
	print "followers.label followers\n";
	print "followers.draw LINE\n";
	print "followers.info followers made.\n";
	exit 0;
}

# Connect to twitter API
my $nt = Net::Twitter->new(
	traits   => [qw/API::RESTv1_1/],
	consumer_key        => $consumer_key,
	consumer_secret     => $consumer_secret,
	access_token        => $token,
	access_token_secret => $token_secret,
	ssl => 1,
	useragent => 'munin_twitterstats',
	);

my $stats = $nt->show_user({ screen_name => $username });

print "followers.value $stats->{'followers_count'}\n";
print "tweets.value $stats->{'statuses_count'}\n";
print "likes.value $stats->{'favourites_count'}\n";
print "following.value $stats->{'friends_count'}\n";

