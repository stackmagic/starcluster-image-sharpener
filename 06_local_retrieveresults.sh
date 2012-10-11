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

# copies the processed files from the cluster master back to the local machine

set -e

function usage {
	echo "usage: ${0} <ssh-identity-file> <cluster-master-node>"
}

if [ -z "${1}" ]; then
	usage
fi
if [ -z "${2}" ]; then
	usage
fi

SSHKEY="${1}"
MASTER="${2}"

while ((1)); do
	for file in $(ssh -i ${SSHKEY} sgeadmin@${MASTER} "find /home/sgeadmin/done -type f -name '*.JPG' -mmin +1"); do
		echo $file
		name="$(basename $file)"
		scp -i ${SSHKEY} "sgeadmin@${MASTER}:/home/sgeadmin/done/${name}" "${HOME}/jpg-dpp-export-processed/${name}"
		ssh -i ${SSHKEY} sgeadmin@${MASTER} "rm /home/sgeadmin/done/${name}"
	done

	echo ">>> waiting"
	sleep 60
done



