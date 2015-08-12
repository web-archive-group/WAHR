# fda
export LOCATION_OF_NER_CLASSIFIER_FILE_IN_HDFS=/user/i2millig
export DATA_DIR=/user/i2millig/fda.text-all
pig -Dmapred.cache.files="$LOCATION_OF_NER_CLASSIFIER_FILE_IN_HDFS/english.all.3class.distsim.crf.ser.gz#english.all.3class.distsim.crf.ser.gz" -Dmapred.create.symlink=yes -p I_NER_CLASSIFIER_FILE=english.all.3class.distsim.crf.ser.gz -p I_PARSED_DATA_DIR=$DATA_DIR/*.txt -p O_ENTITIES_DIR=$DATA_DIR/fda-entities.gz/ extract-entities-from-scrape-text.pig