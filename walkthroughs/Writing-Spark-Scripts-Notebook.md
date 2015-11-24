# Tips for Writing Spark Notebook Scripts
Very rough draft, probably full of inaccuracies.

## Step One: Exploring one Script

Let's take a script, in this case, the plain text extractor.

We have lots of these scripts hanging around. 

```
var warc="/path/to/arc/"

val r = 
RecordLoader.loadWarc(warc,
sc) 
.keepMimeTypes(Set("text/html")) 
.discardDate(null) 
.map(r => {    // so this is changing the value of R to
val t = ExtractRawText(r.getBodyContent) 
val len = 100
(r.getCrawldate, r.getMimeType, r.getUrl, if ( t.length > len ) t.substring(0, 
len) else t)}) 
.collect() 
```

What does this do? Let's go through it row by row.

We:
- specify the path to our WARC file in `var warc`: this could be a single file, or it could also be a directory of WARCs. Both will work.
- we then begin to load entries from the WARC file into our variable, named `r`. 
- `RecordLoader.loadWarc` calls on the `loadWarc` function from the `RecordLoader` file. You can see what they're [doing here](https://github.com/lintool/warcbase/blob/5bf5d4edbcefc39690cad8636e4a2df0ae568728/src/main/scala/org/warcbase/spark/matchbox/RecordLoader.scala). 
- We then go through a series of commands from our [Matchbox](https://github.com/lintool/warcbase/tree/5bf5d4edbcefc39690cad8636e4a2df0ae568728/src/main/scala/org/warcbase/spark/matchbox) (Spark causes fire, get it?)
    + `keepMimeTypes`, which lets you keep only a given type - in this case, HTML files. There are other similar commands that you could use, such as `keepDate`, `keepUrls`, `keepDomains`, etc. [You can find them here](https://github.com/lintool/warcbase/blob/0483269d7e3598f4407f6bd36657a62fdfd9a647/src/main/scala/org/warcbase/spark/rdd/RecordRDD.scala).
    + `discardDate(null)` doesn't discard any dates.
- And then the `map` function begins to run functions on each and every one of the resulting file types
    + `val t = ExtractRawText(r.getBodyContent)` extracts the raw text. 
    + `val len = 100` will specify how many characters you want to see of each record.
- And the penultimate command `(r.getCrawldate, r.getMimeType, r.getUrl, if ( t.length > len ) t.substring(0, len) else t)})` selects what we want to see: in this case, we want the crawl date, the Mime Type, the URL, and 100 characters of each record.
- Finally, `collect` brings it all together to execute and display in our notebook.

Try changing some of these around! Try changing the `len` value, for example.

## Step Two: Altering these Scripts

Let's say we wanted plain text, but we also wanted to detect language. It's as simple as adding it into the pipeline. 

Consider:

```
val r = 
RecordLoader.loadWarc(warc,
sc) 
.keepMimeTypes(Set("text/html")) 
.discardDate(null) 
.map(r => { 
val t = ExtractRawText(r.getBodyContent) 
val language = DetectLanguage(t)
val len = 100
(r.getCrawldate, r.getMimeType, language, r.getUrl, if ( t.length > len ) t.substring(0, 
len) else t)}) 
.collect() 
```

To add in language detection, all we've done is add one line and change another one. We've added:

`val language = DetectLanguage(t)`

This detects the language on each value of t. In the line above that, see that we've defined `t` as the raw text of each record!

To make it display, we've also added `language` in our penultimate line, which now reads:

`(r.getCrawldate, r.getMimeType, language, r.getUrl, if ( t.length > len ) t.substring(0, len) else t)})`

We could do other things, such as:

```
val r = 
RecordLoader.loadArc(arc,
sc) 
.keepMimeTypes(Set("text/html")) 
.discardDate(null) 
.map(r => { 
val t = ExtractRawText(r.getBodyContent)
NER3Classifier("/Users/ianmilligan1/dropbox/ner/stanford-ner-2015-04-20/classifiers/english.all.3class.distsim.crf.ser.gz")
val entities = NER3Classifier.classify(t)
val len = 100
(r.getCrawldate, r.getMimeType, entities, r.getUrl, if ( t.length > len ) t.substring(0, 
len) else t)}) 
.collect() 
```

Notice some minor differences. Instead of a WARC file, we're using an ARC so we call `loadArc` instead of `LoadWarc`. 

Instead of the language detector from above, here we're going to use a Named Entity Recognizer. We need to call `NER3Classifier`, and tell it where it can find the NER classifier ([downloaded from here](http://nlp.stanford.edu/software/CRF-NER.shtml)). We extract the entities on the same `t` variable, and add it to the final line.

These are the building blocks of basic scala scripts.

## Step Three: Further Maps

Let's say we generate all this data, but we really just want a list of all the entities – or all the crawl dates. We can use the above script and then add one final map.

```
val r = 
RecordLoader.loadArc(arc,
sc) 
.keepMimeTypes(Set("text/html")) 
.discardDate(null) 
.map(r => { 
val t = ExtractRawText(r.getBodyContent)
NER3Classifier("/Users/ianmilligan1/dropbox/ner/stanford-ner-2015-04-20/classifiers/english.all.3class.distsim.crf.ser.gz")
val entities = NER3Classifier.classify(t)
val len = 100
(r.getCrawldate, r.getMimeType, entities, r.getUrl, if ( t.length > len ) t.substring(0, 
len) else t)})
.map(ian => {
  ian._3 // would hold the NER JSON output
.collect() 
```

What we've added here is one further map - a variable called `ian` which holds the content of the original run, and then `ian._3` which is the third element of that data structure. 

In this case, a long list of NER outputs.