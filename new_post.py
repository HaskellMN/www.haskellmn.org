#!/usr/bin/env python
import os
import sys
from datetime import datetime

if sys.version_info.major < 3:
    input = raw_input


space = " "
letters = "abcdefghijklmnopqrstuvwxyz"
space_or_letters = space + letters

date = datetime.now().strftime('%Y-%m-%d')
extension = '.md'
directory = 'posts'


title = input("What is the title of the post? ")
description = input("What is the description of the post? ")


title_filtered = ''.join([
    x
    for x in title.lower()
    if x in space_or_letters
])

filename = '-'.join(
    [date] + title_filtered.split()
)

full_filename = os.path.join(
    directory,
    filename + extension
)

post = """---
title: {title}
description: {description}
---

Lorem Ipsum
""".format(
    title=title,
    description=description
)


with open(full_filename, 'w') as f:
    print("Writing to {0}".format(full_filename))
    f.write(post)
