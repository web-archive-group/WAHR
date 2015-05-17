# sort of a hackish way to combine hadoop part output and count number 
# of unique scrapes that it's finding in each one.

printf '%s\0' part* | xargs -0 cat > output.txt
command | cut -c1-6 merged.txt | sort | uniq

# will generate list of scrapes.