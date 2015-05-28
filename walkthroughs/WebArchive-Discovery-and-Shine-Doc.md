# Setting up UK Web Archive's Shine on OS X
**Shawn Dickinson and Ian Milligan (Web Archives for Historical Research Group)**  
**Tested by David Hussey**

Do you have a lot of WARCs that you want to discover? The [UK Web Archive's Shine browser](https://github.com/ukwa/shine) is a "Prototype SOLR-powered web archive exploration UI." It's perfect for what historians might want to do with WARCs. This is an attempt at an easy-to-understand walkthrough to harness the power of Shine for your own collections. If you have any questions, don't hestiate to contact us via Ian at [i2millig@uwaterloo.ca](i2millig@uwaterloo.ca). 

Check out Shine in action below:

![Shine in action]
(images/screenshot1.png)

## Step One: Setting up WebArchive-Discovery

Adapted from https://github.com/ukwa/webarchive-discovery/wiki. 

Dependencies:
- [Brew](http://brew.sh) (follow the link to install brew, a hpandy package manager for OS X)
- Java 1.7 or higher
- Maven (`brew install maven`)
- Git (`brew install git`)

**Clone webarchive-discovery**

In the directory where you want to install it, use:

`git clone https://github.com/ukwa/webarchive-discovery.git`

Recursively cloning makes sure it includes submodules, such as bootstrap.

**Build**

`cd webarchive-discovery/warc-solr-test-server`

`mvn jetty:run-exploded`

This will initialize the solr test server. Keep it running.

**Set up the WARC Ingestor**

You will need to download the JAR, suggested by the wiki and available [here](https://oss.sonatype.org/content/repositories/snapshots/uk/bl/wa/discovery/warc-indexer/2.0.1-SNAPSHOT/) and place it in the correct folder. We downloaded `warc-indexer-2.0.1-SNAPSHOT-jar-with-dependencies.jar`. Direct link for curl/wget is: <https://oss.sonatype.org/content/repositories/snapshots/uk/bl/wa/discovery/warc-indexer/2.0.1-SNAPSHOT/warc-indexer-2.0.1-20150116.110435-2-jar-with-dependencies.jar>

*For example data:* Run the below command, replacing SNAPSHOT with the correct snapshot id from the file that was downloaded.

```
java -jar warc-indexer-2.0.1-SNAPSHOT-jar-with-dependencies.jar  -s http://localhost:8080/discovery -t warc-indexer/src/test/resources/wikipedia-mona-lisa/flashfrozen-jwat-recompressed.warc.gz
```

*For own data:* you can point it to whatever directory your warc.gz or arc.gz files are, a la:

```
java -jar warc-indexer-2.0.1-20150116.110435-2-jar-with-dependencies.jar -s http://localhost:8080/discovery -t /Users/ianmilligan1/dropbox/sample-WARCs/*.warc.gz
```

This may throw lots of errors, as ill-formed HTML causes issues - i.e. "img" must be terminated by the matching end-tag "</img>". when using wild web data, this causes trouble. You can monitor progress in both this widow, as well as the previous one you have running the solr-test server. You'll see some interesting artefacts.

If you're ingesting a lot of ARCs/WARCs, you may want to run a quick bash script a la (you will of course need to change the directory where you have the indexer-jar):

```
#!/bin/bash
# ingest-script.sh
# run in directory with WARCs on local node, headless prevents focus stealing (will drive you crazy)

for f in *.warc.gz # if using arcs change to *.arc.gz or if both *.gz
do
	echo "Processing $f"
	java -Djava.awt.headless=true -jar /volumes/WAHR-SolrTest/webarchive-discovery/warc-indexer-2.0.1-20150116.110435-2-jar-with-dependencies.jar -s http://localhost:8080/discovery -t $f
done
```
## Step Two: Setting up shine

Dependencies:
- Typesafe Activator (`brew install typesafe-activator`)
- Postgres (`brew install postgres`)

First, clone the shine repo with the following command:

```
git clone --recursive https://github.com/ukwa/shine.git
```

**Play framework**

Note that the play framework was replaced with typesafe-activator. From here on replace any `play` commands that you might find in other documentation with `activator`.

Initialize shine by `cd shine/shine` and `activator run`

**Postgresql**

Initialize the Postgres server by running `pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start`. You can also manually stop the server at any time with `pg_ctl -D /usr/local/var/postgres stop -s -m fast`. 

If you want to monitor activity, the command `postgres -D /usr/local/var/postgres` will let you. This should run in the background (you will need to open a new terminal window as this will continue). 

When starting this for the first time, you will also have to use the following commands:

`createuser -P shine` and enter a password for the user (this creates a db user with the name "shine" and your given password). Note that if you use a special character (such as !) in your password, you will need to enclose it with double quotation marks.

`createdb -O shine shine` (this creates a db named "shine" with the user "shine" as its owner).

In `shine/shine/conf/application.conf` make the following changes. Comment out line 92 and uncomment line 93, so the host section looks like:

```
#host = "http://192.168.1.204:8983/solr/ldwa/",
#host = "http://192.168.45.220:8983/solr/ldwadev/",
#host = "http://192.168.1.151:8984/solr/jisc/",
#host = "http://192.168.1.181:8983/solr/jisc5",
host = "http://localhost:8080/discovery/",
#host = "http://chrome.bl.uk:8080/solr/"
```

On line 47, replace the default password with the password you previously created for the db user. The code block should look like:

```
#db.default.logStatements=true
db.default.driver=org.postgresql.Driver
db.default.url="jdbc:postgresql://localhost/shine"
db.default.user=shine
db.default.password=yourpassword
```

Where yourpassword is the password you generated with the `createuser` command.

Opening shine in the browser (http://localhost:9000), you should have a button to "Apply this script now!" -- click it and run the setup SQL scripts

## Step Three: Use Shine

Navigate to <http://localhost:9000/shine> to begin using. Note that simply using http://localhost:9000/ will lead to errors. 

## Notes

If the Solr index grows too large (mine is about 80GB), you may need to pass some more memory parameters to get it running on some machines. On a laptop with 16GB of memory, this command did the trick when initializing the server:

```
MAVEN_OPTS='-Xmx12g -Xms1g -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -XX:+UseConcMarkSweepGC -XX:ParallelGCThreads=4' mvn jetty:run-exploded
```

Thanks to @ruebot, @anjackson, @tokee.

## Questions?

If you run into any questions, please let us know. You can contact Ian Milligan at <i2millig@uwaterloo.ca>, or fork and submit a pull request.
