printf '%s\0' part* | xargs -0 cat > output.txt
command | cut -c1-6 output.txt | sort | uniq > scrape-dates.txt
while read p; do
	sed -n -e '/^'$p'/p' output.txt > $p.txt
done < scrape-dates.txt
