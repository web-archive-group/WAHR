#!/usr/bin/env python

import csv
import sys
 
if len(sys.argv) &lt;= 2:
    print &quot;Usage: %s &lt;id-map-file.tsv&gt; &lt;graph-file.tsv&gt;&quot; % sys.argv[0]
    print &quot;   OR&quot;
    print &quot;       %s &lt;id-map-file.tsv&gt; &lt;graph-file.tsv&gt; -o &lt;output-file.tsv&gt;&quot; % sys.argv[0]
    sys.exit(1)
 
with open(sys.argv[1], 'rb') as keyfile, open(sys.argv[2], 'rb') as graphfile:
    keyfile = csv.reader(keyfile, delimiter='\t')
    graphfile = csv.reader(graphfile, delimiter='\t')
 
    if (len(sys.argv) == 5) and (sys.argv[3] == '-o'):
        tsvout = open(sys.argv[4], 'wb')
    else:
        tsvout = sys.stdout
    tsvout = csv.writer(tsvout, delimiter='\t')
 
    # Read values of id-map-file.tsv into dictionary 'map'.
    # Assumes sane data.
    map = dict()
    for row in keyfile:
        map[row[0]] = row[1]
 
    # Rewrite contents of graphfile using dictionary values.
    for row in graphfile:
        adj_list = row[1].translate(None, '{}()')
        adj_list = adj_list.split(',')
        for node in adj_list:
            tsvout.writerow([map[row[0]], map[node]])
