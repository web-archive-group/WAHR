# This creates unique one entity per page, i.e. turning:
# http://www.geocities.com/EnchantedForest/Grove/1234/index.html
# http://www.geocities.com/EnchantedForest/Grove/1234/pets/cats.html
# http://www.geocities.com/EnchantedForest/Grove/1234/pets/dogs.html
# http://www.geocities.com/EnchantedForest/Grove/1234/pets/rabbits.html
#
# into
# http://www.geocities.com/EnchantedForest/Grove/1234/
#

sed 's/[()]*//g; s/^[^,]*,//; s/\([0-9]\{4\}\)[^,]*/\1/g' INPUT > OUTPUT-CLEANED.txt

# this command extracts only INTERNAL links - i.e. GeoCities pre-1999
# structure to other Geocities pre-1999 pages. Neighbourhoods make
# this manageable.

grep -P '(.*/[0-9]{4}){2}' OUTPUT-CLEANED.TXT > OUTPUT2-ENTITIES.TXT
