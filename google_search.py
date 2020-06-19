#!/usr/bin/python
from subprocess import Popen, PIPE, STDOUT, call
from urllib import quote

BASE_URL = 'https://www.google.com/search?q='

dmenu = Popen('true | dmenu -p "Google:"', shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
stdout = dmenu.stdout.read()
query = quote(stdout.strip())

call(['xdg-open', BASE_URL+query])

