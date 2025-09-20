#!/bin/bash
#
# This script is used to sync my personal BTAF setup from one host to any other
# host. With increasing number of hosts, it became too hard to maintain each one
# individually. We don't have any AD accounts on these simple testing hosts and
# thus I was looking for a simple solution.
#
# On any new host, just do:
#   scp 10.54.115.127:~/sync-from-remote.sh .
#   ./sync-from-remote.sh
#
# To update at any time after initial installation, only the 2nd step is
# required.
#
# The folder .ssh/ is copied first so that password-less copy works as quick as
# possible. On a new host, password usually is only required 1-2 times to be
# typed.
#
# To update, the script sync-from-remote.sh can be called again without
# interaction (even triggered by a cron job). To make this work, the host must
# be in .ssh/known_hosts on itself (with its IP address), as this file is
# synchronized to the target host (=overwritten on target).
#
set -e

host=$1  # pass IP or hostname as argument to script

folders="\
    .ssh \
    .vim \
    sysutil \
    .nvm \
    .config/github-copilot \
    "

files="\
    sync-from-remote.sh \
    .bashrc \
    .bash_aliases \
    .bash_credentials \
    .gitconfig \
    .viminfo \
    .vimrc \
    "

for path in $folders; do
    echo "$path"
    tmpname="${path}-tmp"
    scp -rq ${host}:"~/${path}" "$tmpname"
    rm -rf "${path}"
    mv "$tmpname" "$path"
done

for path in $files; do
    echo "$path"
    tmpname="${path}-tmp"
    scp -q ${host}:"~/${path}" "$tmpname"
    rm -f "${path}"
    mv "$tmpname" "$path"
done
