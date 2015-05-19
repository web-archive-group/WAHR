# This is sort of a hacky script that combines all the hadoop part outputs,
# finds a list of all the unique year/month of scrapes, and then extracts
# them into text files matching each scrape (i.e. 200510.txt for the scrape 
# of October 2005. Decent performance as a first attempt?

printf '%s\0' part* | xargs -0 cat > output.txt
command | cut -c1-6 output.txt | sort | uniq > scrape-dates.txt
while read p; do
	sed -n -e '/^'$p'/p' output.txt > $p.txt
done < scrape-dates.txt
