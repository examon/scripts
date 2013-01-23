#!/usr/bin/env python2
# -*- coding: utf-8 -*-

from os import popen, listdir
from time import sleep


NEW_PATH = "/home/exo/Mail/INBOX/new/"
REFRESH_TIME = 3
TRUE = 1
FALSE = 0

def main():
	last_state = 0
	while True:
		stream = popen("ls %s | wc -l" % NEW_PATH)
		inbox = int(stream.next()[:-1])
		print "inbox %d \t last_state: %d" % (inbox, last_state)
		if not inbox == last_state:
			if inbox >= 1:
				s = "s" if inbox > 1 else ""
				message = " Attention! You have %s new e-mail%s." % (inbox, s)
				popen("echo %s | festival --tts" % message)
			say_from()
			last_state = inbox
		sleep(REFRESH_TIME)

def say_from():
	cnt = len(listdir(NEW_PATH))
	for filename in listdir(NEW_PATH):
		filename = NEW_PATH + filename
		stream = popen("cat %s | egrep \"From:\" | cut -f2- -d ' ' | cut -f1 -d '<'" % filename)
		sender = stream.next()[:-1]
		if len(sender) > 0:
			if not ("a" <= sender[0]) and not (sender[0] >= "z") \
			and not ("A" <= sender[0]) and not (sender[0] >= "Z") \
			and not sender[0] == "\"":
				sender = "Unknown sender"
		else: sender = "Unknown sender"
		message = "from \"%s\"" % sender
		popen("echo \"%s\" | festival --tts" % message)
		if (cnt > 1):
			popen("echo \"and\" | festival --tts")
		cnt -= 1
	

if __name__ == "__main__":
	main()
