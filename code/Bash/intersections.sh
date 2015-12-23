# This command takes a list of domains in file a, a list of URLs 
# in file b, and finds which one URLs within the domains appears
# in file b. For example, if you want to see how many twitter.com
# and youtube.com URLs are in a list, pass a file with those domains
# to a list of URLs.

grep -wFf Webarchives-domains.md elxn42-tweets-urls-uniq.txt > elxn42-intersections.txt

