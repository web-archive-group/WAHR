#!/bin/bash
# ner-on-extract.sh
# run in directory w/ date-scrape text
# to do: remove intermediate files or pipeline?
# adapted from http://williamjturkel.net/2013/06/30/named-entity-recognition-with-command-line-tools-in-linux/
# NOTE: requires locpattr, orgpattr, personpattr in same directory	
# NOTE: will need to change java memory in stanford-ner/ner.sh (default in 700mb, trying with 1gb)

for f in *.txt 
do
	/cliphomes/i2millig/stanford-ner/ner.sh $f > $f_ner.txt # creates individualized ner output files
	sed 's/\/O / /g' < $f_ner.txt > $f_ner_clean.txt # cleaner version of the file, need to get rid of the /O tags for those words that are NOT organization person location
	egrep -o -f personpattr $f_ner_clean.txt > $f_ner_pers.txt # extracting people
	cat $f_ner_pers.txt | sed 's/\/PERSON//g' | sort | uniq -c | sort -nr > $f_ner_pers_freq.txt # sorting people frequency
	egrep -o -f orgpattr $f_ner_clean.txt > $f_ner_org.txt #extracting organization
	cat $f_ner_org.txt | sed 's/\/ORGANIZATION//g' | sort | uniq -c | sort -nr > $f_ner_org_freq.txt # sorting organization frequency
	egrep -o -f locpattr $f_ner_clean.txt > $f_ner_loc.txt # extracting locations
	cat $f_ner_loc.txt | sed 's/\/LOCATION//g' | sort | uniq -c | sort -nr > $f_ner_loc_freq.txt # sorting location frequency
done
