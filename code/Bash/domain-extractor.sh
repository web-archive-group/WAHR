#!/bin/bash
# this script takes a text file of domains (cdx-failure.txt)
# and compresses them down to domain. So a URL like 
# http://15andfairness.org/latest/federal-election-alert-lets-ramp-up-the-fight-for-decent-work/
# becomes just http://15andfairness.org.


while read p; do
	echo $p | awk -F/ '{print $3}'
done < cdx-failure.txt > domains-failed.txt