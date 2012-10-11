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

# submits the images in the pending folder to the job queue. this can and will
# submit images multiple times, but that doesn't hurt us since a failing job is
# very quick. this could definitely be optimized.

# i did it this way since submitting the job for each image individually right
# after uploading from my local machine didn't seem to work properly

# actually i just wrote this script from memory because i had some shell
# oneliner running at the time so this might be broken

set -e

while ((1)); do
	for file in $(find /home/sgeadmin/pending -type f -name "*.JPG"); do
		qsub -V /home/sgeadmin/05_remote_executejob.sh ${file}
	done

	echo ">>> waiting"
	sleep 60
done
