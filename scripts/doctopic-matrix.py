#!/usr/bin/env python
# Takes a MALLET topic composition document and produces a document-topic
# matrix in CSV format.
#
# Borrows heavily from https://de.dariah.eu/tatom/topic_model_mallet.html

import sys
from six.moves import zip_longest
import csv
import itertools
import numpy
import operator

def grouper(n, iterable, fillvalue=None):
    args = [iter(iterable)] * n
    return zip_longest(*args, fillvalue=fillvalue)

def write_matrix(infile, outfile):
    docnames = []
    doctopic_triples = []
    max_topic = 0

    with open(infile, 'r') as f:
        f.readline()    # skip header line
        for line in f:
            docnum, docname = line.split('\t')[:2]
            # values = list of alternating topic numbers and proportions
            values = line.rstrip().split('\t')[2:]
            docnames.append(docname)
            for topic, proportion in grouper(2, values):
                doctopic_triples.append((docname, int(topic), float(proportion)))
                max_topic = max(max_topic, int(topic))

    # sort triples by docname and topic
    doctopic_triples = sorted(doctopic_triples, key=operator.itemgetter(0,1))
    # sort the document names rather than relying on MALLET's ordering
    docnames = sorted(docnames)
    
    num_docs = len(docnames)
    num_topics = max_topic + 1
    doctopic = numpy.zeros((num_docs, num_topics))
   
    # fill doctopic matrix -- loop by doctopic_triples sharing docname
    for i, (docname, triples) in enumerate(itertools.groupby(doctopic_triples, key=operator.itemgetter(0))):
        for t in triples:
            doctopic[i, t[1]] = t[2]
    
    with open(outfile, 'w') as csvfile:
        dtcsv = csv.writer(csvfile)
        dtcsv.writerow(["docname"] + ["topic_" + str(t) for t in range(0, num_topics)])  # header row
        for i in range(0, num_docs - 1):
            row = [docnames[i]] + doctopic[i, :].tolist()
            dtcsv.writerow(row)

if __name__ == '__main__':
    if len(sys.argv) == 3:
        infile = sys.argv[1]
        outfile= sys.argv[2]
        write_matrix(infile, outfile)
    else:
        print "Takes a MALLET topic composition document and produces a " \
              "document-topic matrix in CSV format."
        print "Usage: %s <doc-topics.txt> <output.csv>" % sys.argv[0]