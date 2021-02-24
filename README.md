# munin-twitter
A munin script that logs some twitter stats

twitter_stats_ - Munin plugin to monitor basic stats of a twitter
account. Tweets, following, followers and likes.

Requires perl, NET::Twitter and a Twitter OATH account

Create symbolic link to /etc/munin/plugins/twitter_stats_USERNAME
from /usr/share/munin/plugins/twitter_stats_

Change USERNAME to the twitter name, minus the @ - then set the OATH
info below.
See https://dev.twitter.com/oauth for more info about getting a key.

This script logs into the twitter API via OAuth and grabs some basic
stats. It could be expanded for more complicated data

