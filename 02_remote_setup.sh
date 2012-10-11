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

# setup the cluster nodes and master

set -e

# install imagemagick on all nodes
for HOST in "$(/opt/sge6/bin/linux-x64/qhost | grep linux | cut -d' ' -f1)"; do
	echo "Installing ImageMagick on ${HOST}"
	ssh ${HOST} "apt-get install imagemagick -y"
done

# create the inbox and outbox on the master (the home directory is shared
# among all all cluster nodes)
echo "creating work dirs"
cd "/home/sgeadmin"

if [ ! -d "pending" ]; then
	mkdir "pending";
	chown sgeadmin:sgeadmin "pending"
fi
if [ ! -d "done" ]; then
	mkdir "done"
	chown sgeadmin:sgeadmin "done"
fi

