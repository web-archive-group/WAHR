Here are the commands to run to generate domain analytics, and then extract some plain text.

```
:cp /Users/ianmilligan1/dropbox/warcbase/target/warcbase-0.1.0-SNAPSHOT-fatjar.jar
```

```
import org.warcbase.spark.matchbox._ 
import org.warcbase.spark.rdd.RecordRDD._ 
```

```
var arcdir="/Users/ianmilligan1/dropbox/warcs-workshop";
```

```
val r = 
RecordLoader.loadArc(arcdir, 
sc) 
.keepValidPages() 
.map(r => ExtractTopLevelDomain(r.getUrl)) 
.countItems() 
.take(10) 
```

Then select the "pie chart" icon to make sure it's working~

```
val r = 
RecordLoader.loadArc(arcdir,
sc) 
.keepMimeTypes(Set("text/html")) 
.discardDate(null) 
.map(r => { 
val t = ExtractRawText(r.getBodyContent) 
val len = 1000 
(r.getCrawldate, r.getUrl, if ( t.length > len ) t.substring(0, 
len) else t)}) 
.collect()
``` 
