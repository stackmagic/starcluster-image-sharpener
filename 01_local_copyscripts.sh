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

# initialize everything by uploading the scripts that need to run on the
# cluster's master

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

echo ">>> copying scripts that need to be executed remotely to master node"
scp -i ${SSHKEY} *_remote_*.sh sgeadmin@${MASTER}:.

echo ">>> logging into master -- please execute /home/sgeadmin/02_remote_setup.sh now"
ssh -i ${SSHKEY} root@${MASTER}

