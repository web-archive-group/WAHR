#!/bin/bash
# startup scripts

cd /home/ubuntu/local-shine/webarchive-discovery/warc-solr-test-server
nohup mvn jetty:run-exploded >& log.txt &
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
export PATH=$PATH:/home/ubuntu/local-shine/activator-dist-1.3.5
cd /home/ubuntu/local-shine/shine/shine
activator stage
sudo target/universal/stage/bin/shine -Dhttp.port=80 -Dhttp.proxyHost=explorer.bl.uk -Dhttp.proxyPort=3127 -Dhttp.port-Dhttp.port -DapplyEvolutions.default=true &

