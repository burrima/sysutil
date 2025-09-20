#!/bin/bash
set -e

host=$1  # pass IP address as argument to script

scp ${host}:~/setup_dependent_client.sh .

chmod a+x setup_dependent_client.sh

./setup_dependent_client.sh ${host}

rm setup_dependent_client.sh

