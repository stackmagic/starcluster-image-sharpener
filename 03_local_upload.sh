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

# RUN LOCALLY

# upload the files from the local outbox into the cluster's inbox, then move
# it into our local submitted directory.
#
# this script can be stopped/fail and re-started at will, it will just pick up
# where it stopped

set -e

function usage {
	echo "usage: ${0} <ssh-identity-file> <cluster-master-node>"
	exit 1
}

if [ -z "${1}" ]; then
	usage
fi
if [ -z "${2}" ]; then
	usage
fi

SSHKEY="${1}"
MASTER="${2}"

for file in $(find ${HOME}/jpg-outbox-to-cluster/ -name '*.JPG'); do
	echo "${file}"
	name="$(basename ${file})"
	scp -i ${SSHKEY} ${file} sgeadmin@${MASTER}:./pending/${name}
	mv ${file} "${HOME}/jpg-submitted-to-cluster/${name}"
done

