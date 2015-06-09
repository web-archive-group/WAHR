# testing w/ memory=60g
# num-threads 16 based on number of nodes?

./bin/mallet import-dir --input /cliphomes/i2millig/cpp.text-greenparty/datescrapes/ --output /cliphomes/i2millig/mallet-data/greenparty.mallet --keep-sequence --remove-stopwords
./bin/mallet train-topics  --input /cliphomes/i2millig/mallet-data/greenparty.mallet  --num-topics 20 --optimize-interval 20 --num-threads 16 --output-state /cliphomes/i2millig/mallet-data/greenparty-topic-state.gz  --output-topic-keys /cliphomes/i2millig/mallet-data/mallet-data/greenparty_keys.txt --output-doc-topics /cliphomes/i2millig/mallet-data/mallet-data/greenparty_composition.txt
