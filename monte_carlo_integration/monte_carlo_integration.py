#!/usr/bin/env python2

# monte carlo integration, only for y >= 0

import math
import random

a = 0
b = math.pi
dots = 50e6

def fcn(x):
	""" change return value
	"""
	return math.sin(x)

def main():
	step = float(b - a) / ((b - a) * 10000)
	n = []
	inside = out = 0

	for x in my_range(a, b, step):
		n.append(fcn(x))

	ymax = max(n) 
	ymin = 0

	for i in range(int(dots)):
		ry = random.uniform(ymin, ymax)
		rx = random.uniform(a, b)
		y = fcn(rx)
		if (ry < y):
			inside += 1
		else:
			out += 1

	print "  dots:", dots
	print "inside:", inside
	print "   out:" , out
	res = float((b - a) * (ymax - ymin) * inside) / (inside + out)
	print "   res:", res

def my_range(start, end, step):
	while start <= end:
		yield start
		start += step

if __name__ == "__main__":
	main()
