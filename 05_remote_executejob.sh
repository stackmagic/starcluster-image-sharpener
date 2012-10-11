#!/bin/sh

# Copyright (c) 2012 Patrick Huber <stackmagic@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# RUN ON CLUSTER MASTER

# this is the actual job that needs all the processing power. try running this
# on a normal machine and see how long it takes. plus, compare its results to
# a normal sharpening

set -e

if [ -z "${1}" ]; then
	echo "No filename given"
	exit 1
fi

IN="${HOME}/pending/${1}"
OUT="${HOME}/done/$(basename ${IN} .JPG)_sharpened.JPG"

A=" -gaussian-blur 1x1 -sharpen 10x1 "
convert ${A} ${A} ${A} ${A} ${A} ${A} ${A} ${A} ${A} ${A} -quality 100 ${IN} ${OUT}
rm ${IN}

