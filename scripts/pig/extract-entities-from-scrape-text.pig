/*
 * Copyright 2013 Internet Archive
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You
 * may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License. 
 */

/* Input: Plain text files, each containing text of scrapes on a unique date
 * Output: URL, digest, date, entities
 */

--pig -Dmapred.cache.files="/user/vinay/english.all.3class.distsim.crf.ser.gz#english.all.3class.distsim.crf.ser.gz" -Dmapred.create.symlink=yes -p I_NER_CLASSIFIER_FILE=english.all.3class.distsim.crf.ser.gz

%default I_PARSED_DATA_DIR '/user/jrwiebe/cpp.text-greenparty/*.txt';
%default O_ENTITIES_DIR '/user/jrwiebe/cpp.text-greenparty/entities.gz/';
%default I_NER_CLASSIFIER_FILE 'english.all.3class.distsim.crf.ser.gz';

SET mapred.max.map.failures.percent 10;
SET mapred.reduce.slowstart.completed.maps 0.9

REGISTER lib/wahrudfs.jar;
REGISTER lib/stanford-ner-3.4.1.jar;

DEFINE NER3CLASS wahrudfs.NER3ClassUDF('$I_NER_CLASSIFIER_FILE');

Scrapes = LOAD '$I_PARSED_DATA_DIR' AS (date:chararray, url:chararray, content:chararray);

Entities = FOREACH Scrapes GENERATE date, url, NER3CLASS(content) AS entityString;

STORE Entities into '$O_ENTITIES_DIR';  

