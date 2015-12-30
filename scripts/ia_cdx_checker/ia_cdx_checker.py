#!/usr/bin/env python
"""
$ python ia_cdx_checker.py elxn42-tweets-urls-fixed-uniq-no-count.txt | cat > elx42_urls_in_ia.txt
"""

from __future__ import print_function

import sys
import json
import fileinput
import io
from urllib2 import Request, urlopen, URLError, HTTPError

for line in fileinput.input():
    elx42_url = line.rstrip('\n')
    try:
        url = 'http://web.archive.org/cdx/search/cdx?url=' + elx42_url + '&output=json&limit=-2'
        request = Request(url, headers={'User-Agent': "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)"})
        jsonData = urlopen(request)
        data = json.load(jsonData)
        first_date = data[1][1]
        second_date = data[2][1]
        if first_date.startswith('201508'):
            print(elx42_url)
        if first_date.startswith('201509'):
            print(elx42_url)
        if first_date.startswith('201510'):
            print(elx42_url)
        if first_date.startswith('201511'):
            print(elx42_url)
        if first_date.startswith('201512'):
            print(elx42_url)
        if second_date.startswith('201508'):
            print(elx42_url)
        if second_date.startswith('201509'):
            print(elx42_url)
        if second_date.startswith('201510'):
            print(elx42_url)
        if second_date.startswith('201511'):
            print(elx42_url)
        if second_date.startswith('201512'):
            print(elx42_url)
    except HTTPError as e:
        status_code = e.code
    except IndexError as d:
        index_error = d
    except ValueError as f:
        value_error = f
