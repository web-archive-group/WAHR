# Walkthrough

This is a walkthrough for installing Spark on a Ubuntu_14.04_Trusty x86_64 (QCOW2) image provided for Compute Canada. Presumably Amazon EC2 would provide a similar sort of experience.

It is a bit bare boned as it assumes some knowledge of a command line environment.

1. SSH to the server (remember key, as well as default username `ubuntu`)

2. Install dependencies
- `sudo apt-get update`
- `sudo apt-get install git`
- `sudo apt-get install maven`
- `sudo apt-get install scala`
- `export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64`
- `sudo apt-get install openjdk-7-jdk`

3. Set up the server properly
- type `echo $HOSTNAME`
- try `ping $HOSTNAME`: if it responds with something like `ping: unknown host milligan-wahr-05` you need to add an entry to your `/etc/hosts` file
- `sudo vim /etc/hosts`
- replace the `localhost` entry with your hostname - in my case, the first line now reads: `127.0.0.1 milligan-wahr-05`
` now try to `ping $HOSTNAME`: if you begin to see packet transmission/receipt information, you're golden.

4. Install Spark
- download spark 1.5.1 from [here](http://spark.apache.org/downloads.html). I used [this version for direct download](http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz).
	- for the lazier among us: `http://d3kbcqa49mib13.cloudfront.net/spark-1.5.1-bin-hadoop2.6.tgz`
	- `tar -xvf spark-1.5.1-bin-hadoop2.6.tgz`
	- remove the tar file: `rm spark-1.5.1-bin-hadoop2.6.tgz`

5. Install Warcbase
- bring yourself back to your home directory: `cd --`
- download warcbase: `git clone https://github.com/lintool/warcbase.git`
- change to the warcbase directory: `cd warcbase`
- build warcbase: `mvn clean package appassembler:assemble -DskipTests`

6. Test
- verify that the shell works by navigating to your spark-shell directory and running: `./bin/spark-shell`
- if you don't get a bunch of errors, try: `./bin/spark-shell --jars /home/ubuntu/warcbase/target/warcbase-0.1.0-SNAPSHOT-fatjar.jar` to initalize warcbase
- Try this following script. In order to paste code, type `paste` and then Ctrl+D when you finish it up.

```
val r = RecordLoader.loadArc("/home/ubuntu/warcbase/src/test/resources/arc/example.arc.gz", sc)
  .keepValidPages()
  .map(r => ExtractTopLevelDomain(r.getUrl))
  .countItems()
  .take(10)
```
 
If you receive the following output:

```
r: Array[(String, Int)] = Array((www.archive.org,132), (deadlists.com,2), (www.hideout.com.br,1))
```

Then you're golden! Fist pump.
