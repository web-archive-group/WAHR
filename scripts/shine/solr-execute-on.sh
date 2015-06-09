#!/bin/bash

cd /Users/ianmilligan1/desktop/local-shine/webarchive-discovery/warc-solr-test-server/
MAVEN_OPTS='-Xmx12g -Xms1g -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -XX:+UseConcMarkSweepGC -XX:ParallelGCThreads=4' mvn jetty:run-exploded