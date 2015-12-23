#!/bin/bash
# this script takes a text file of domains (cdx-failure.txt)
# and compresses them down to domain. So a URL like 
# http://15andfairness.org/latest/federal-election-alert-lets-ramp-up-the-fight-for-decent-work/
# becomes just http://15andfairness.org.
# if using Twitter corpus, use non-unique URLs!

while read p; do
	echo $p | awk -F/ '{print $3}'
done < elxn42-tweets-urls-fixed.txt > domains-all.txt

# we may subsequently want to normalize domains by removing
# sub-domains, so that m.youtube.com and youtube.com are
# the same (or m.globeandmail.com and globeandmail.com

while read l; do
	(sed 's/.*\.\(.*\..*\)/\1/' <<< ${l%/*})
done < domains-all.txt > normalized-domains-all.txt

# we may then want to have sorted, frequency lists. A la:

sort normalized-domains-all.txt | uniq -c | sort -nr > normalized-domains-all-sorted.txt
