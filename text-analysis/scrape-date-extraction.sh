# this first command takes all hadoop output and combines them. Avoids
# argument list being too long.

printf '%s\0' part* | xargs -0 cat > output.txt

# this following command lets you see the unique scrapes that are
# within the collection

command | cut -c1-6 merged.txt | sort | uniq

# this following command sorts the merged data by date-scrape.

sort -n merged.txt > sorted-merged.txt

# if you want to verify, you can run this command to see a scrolling
# output of the dates in the collection by order. Should not be
# necessary.

awk '{print $1}' sorted-merged.txt

# this command extracts all crawls of a certain date and puts them out
# to a text file. 
# Presumable, could just take the original output.txt and feed it
# output of the sort/uniq command?

sed -n -e '/^200610/p' sorted-merged.txt > 200610.txt