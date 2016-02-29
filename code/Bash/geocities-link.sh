sed 's/[()]*//g; s/^[^,]*,//; s/\([0-9]\{4\}\)[^,]*/\1/g' INPUT > OUTPUT-CLEANED.txt

grep -P '(.*/[0-9]{4}){2}' OUTPUT-CLEANED.TXT > OUTPUT2-ENTITIES.TXT
