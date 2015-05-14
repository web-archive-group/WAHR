# Web Archive Analysis Local Walkthrough for Historians

[adapted from this blog post](http://ianmilligan.ca/2014/12/10/playing-with-the-web-archive-analysis-workshop-a-few-tips-for-fellow-tinkerers/)

Yesterday, I spent part of the day tinkering with the [Web Archive Analysis Workshop](https://webarchive.jira.com/wiki/display/Iresearch/Web+Archive+Analysis+Workshop), put together by the Internet Archive's [Vinay Goel](https://github.com/vinaygoel). It's a great workshop that really lets us play and extract tons of useful data from WARC files. In this post, I won't rehash the commands, but want to show a few things that I needed to do to get it up and running, and then show some of the potential. This is mostly just a research notebook for anybody else who stumbles down the path after me. 

## Getting it Started

The instructions for installation are pretty straightforward. I think I just ran `brew install hadoop` to get it all working. On my version of OS X, I received an error message when running several of the scripts: 
```c
ERROR 2998: Unhandled internal error. org/python/core/PyObject`
```

I was missing a standalone Jython jar in my pig installation. To fix this, I downloaded [Jython from here](http://www.jython.org/), generated a standalone jar and copied it to my pig install like so: 

```
java -jar jython-installer-2.5.3.jar -s -d /tmp/jython-install -t standalone -j $JAVA_HOME cp /tmp/jython-install/jython.jar /usr/local/Cellar/pig/0.13.0/lib
```

It let me get it all working. For convenience, so I could run this again quickly after rebooting things, I created a script with these commands which I'd run in the directory with my content (in my case, /users/ianmilligan1/internet-research/).
```
export PROJECT_DIR=`pwd`/archive-analysis/
export DATA_DIR=`pwd`/sample-dataset/
cd $PROJECT_DIR
export PIG_HOME=/usr/local/Cellar/pig/0.13.0
```

## Running the Code and Analyzing Results with Bash and Excel: A Few Tips

It all should run quite well. The script is pretty straightforward. 

Output, like other Pig programs that I've run in the past, is generated into the ~/internet-research/sample-dataset/derived-data directory into subfolders as partial files: i.e. part-00000 or part-00000.gz. Most of the output is not too large, even when running on a larger corpus, so I often ran the following commands in each directory to combine them all into big files for analysis (depending on the size of your data/your set up, you might want to tackle the parts individually):
```
gunzip part* cat part* > all-data.txt
```

Much of the results appears in this format. For example, this is from the derived metadata WAT files:

```
ca,aai)/	2011-07-14T06:13:13.000Z	AAI, Applied AI Systems, mobile robots, mobile robotics, education robot, artificial intelligence, robot simulation software, robotic research, intelligent autonomous mobile robots, Evolutinary Robotics Symposium, ER, AI, ALife, LABO robot, GAIA robot, Khepera, Shrimp, TAO, wheelchair robot, transportation robot, legged robot, wheeled robot, WEBOTS, simulation software, e-puck, educational and research robot Applied AI Systms, Inc. :: R&D company for intelligent autonomous mobile robots and application development. Manufacturer of robots for academics, government, and research institutions AAI Canada, Inc. - Intelligent Robots - e-puck AAI Canada, Inc. - Intelligent Robots - e-puck
ca,amk)/	2011-07-14T08:07:36.000Z	A.M. Kuchling, AMK Andrew M. Kuchling's personal site, featuring Python code and information, weblog, book diary, and other information. Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling Andrew M. Kuchling</pre>
```

It's a tab-separated file, with the first column containing top-level domain information, the second a timestamp, and the third in this case the metatext for each website. 

To get just the Canadian files, this worked:

```
sed '/ca,/!d' all-titles.txt > ca-titles.txt
```

You can then load it into bash. In other cases, Excel is your friend. Link results come in a format like this: 

[![Screen Shot 2014-12-10 at 10.08.59 AM](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-10-08-59-am.png?w=213)](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-10-08-59-am.png)

Again, tab-separated values - first field the source domain, the second field the target domain, and then the number of links. I found in Excel if you did this you could delete fields that were INBOUND links (i.e. YouTube.com tends to link to YouTube.com, which you might want to control for). Basically, taking a chart like:

```
source      target    value
a           a         10
a           b         10
b           b         15
```

If you just want to keep the a -> b value, you can create a fourth column called 'delete check.' This formula:

```
=IF(AND(A2=B2),"DELETE ME","")
```

Entered into the entire column (highlight Column D, enter the formula and save it using Control + Return) will do a check like so. 

[![Screen Shot 2014-12-10 at 1.39.50 PM](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-1-39-50-pm.png?w=300)](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-1-39-50-pm.png)

You can then click on the 'Data' tab, 'Filter,' and then use the drop-down menu under 'delete check' to hide all those that need to be deleted. 

[![As soon as you uncheck 'DELETE ME' you've got rid of internal links.](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-1-40-28-pm.png?w=224)](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-1-40-28-pm.png)

We can extract the TLD using the following Excel formula, from say the 'target' directory:
```
=TRIM(RIGHT(SUBSTITUTE(B4, ".", REPT(" ", 100)), 100))
```

And then count that column of TLDs by selecting the 'pivot table' option and setting it up like so:

[![Screen Shot 2014-12-10 at 1.43.46 PM](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-1-43-46-pm.png?w=129)](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-1-43-46-pm.png)

You can then see the results as below:

[![Generated using an Excel pivot table ](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-11-06-45-am.png?w=300)](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-11-06-45-am.png) 

## Results
The results have been pretty interesting. We can see what percentage of outbound links end up to various TLDs, as seen above, and also generate network graphs from any WARC files as I showed [in my last post](http://ianmilligan.ca/2014/12/09/exploding-arc-files-with-warcbase/). 

We can take the meta-text or the title-text and throw it in to your own instance of [Voyant Tools](http://docs.voyant-tools.org/resources/run-your-own/) (the data's a bit big for the online version), where you can begin to get a sense of what a web archive contains:

[![Screen Shot 2014-12-10 at 11.31.32 AM](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-11-31-32-am.png?w=300)](https://ianmilli.files.wordpress.com/2014/12/screen-shot-2014-12-10-at-11-31-32-am.png)
