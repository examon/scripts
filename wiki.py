#!/usr/bin/env python3

"""
From: https://www.reddit.com/r/programming/comments/31fuae/i_made_a_command_line_tool_to_pull_summaries_from/

Usage:

$ python3 wiki.py number theory
Number theory (or arithmetic) is a branch of pure mathematics devoted primarily
to the study of the integers, sometimes called "The Queen of Mathematics"
because of its foundational place in the discipline.
yolo
"""

import json
import urllib.request
import urllib.parse
import sys

if len(sys.argv) == 1:
    print('Usage: {} <subject>'.format(sys.argv[0]))
    sys.exit(1)

query = urllib.parse.quote(' '.join(sys.argv[1:]))
url = 'http://en.wikipedia.org/w/api.php?continue=&action=query&titles={}&prop=extracts&exintro=&explaintext=&format=json&redirects'.format(query)

with urllib.request.urlopen(url) as f:
    data = json.loads(f.read().decode('utf-8'))

for page in data['query']['pages'].values():
    try:
        print(page['extract'])
    except KeyError:
        print('No article found.')
