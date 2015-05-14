# Code Repository

## Unify.py

```
Usage: unify.py [id-map-file.tsv] [graph-file.tsv]
   OR
       unify.py [id-map-file.tsv] [graph-file.tsv] -o [output-file.tsv]
```

This was authored by Jeremy Wiebe and discussed [on Ian's blog here](http://ianmilligan.ca/2015/03/13/adapting-the-web-archive-analysis-workshop-to-longitudinal-gephi-unify-py/). It's a simple Python script for turning [Web Archive Analysis Workshop data](https://webarchive.jira.com/wiki/display/Iresearch/Web+Archive+Analysis+Workshop) into Gephi format.

There's more information on playing with the workshop [here](http://ianmilligan.ca/2014/12/10/playing-with-the-web-archive-analysis-workshop-a-few-tips-for-fellow-tinkerers/).

## Plain-Textify.m
```
htmlTreeToPlainText[origin,target];
```

This is a Mathematica routine, [derived from an old StackOverflow question](http://stackoverflow.com/questions/8138534/finding-and-converting-html-files-and-moving-them-en-masse), that is useful when dealing with large dumps of mirrored HTML files, etc.

Use cases and specific implementation is [available here](http://ianmilligan.ca/2015/04/14/using-mathematica-to-generate-plain-text-files-of-mirrored-web-site-archives/).

## Other Things
If you want to get Gephi working on OS X, and it's breaking, maybey ou need to change some of your settings? See [Getting Gephi Running on OS X Mavericks](http://ianmilligan.ca/2014/07/15/getting-gephi-running-on-os-x-mavericks/).
