# This is a great script that takes a list of URLs - one per line
# and runs them through the Wayback CDX Server Api found at 
# https://github.com/internetarchive/wayback/tree/master/wayback-cdx-server
#
# It is taken from Ryan Baumann's awesome post "Archiving the AWOL Index,"
# 18 August 2015, https://ryanfb.github.io/etc/2015/08/18/archiving_the_awol_index.html
# (CC-BY 4.0)

while read url; do \
  if [ -n "$(curl -s "http://web.archive.org/cdx/search/cdx?url=${url}")" ]; \
    then echo "$url" >> cdx-elxn42-success.txt; \
    else echo "$url" >> cdx-elxn42-failure.txt; \
  fi; \
done < elxn42-tweets-urls-fixed-uniq-no-count.txt
