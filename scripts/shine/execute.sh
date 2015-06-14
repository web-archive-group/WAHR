#!/bin/bash
# run in same directory as solr-execute-on.sh and shine-execute-on.sh
# give them executable, i.e. chmod +x solr-execute-on.sh
# basically, launches postgres in one; solr in another; and shine in the last one

open -a Terminal.app server.sh
open -a Terminal.app solr-execute-on.sh
open -a Terminal.app shine-execute-on.sh
