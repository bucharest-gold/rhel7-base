#!/bin/bash -e
# This script is used to build, test and squash the OpenShift Docker images.

echo "-> Building bucharestgold/rhel7-base ..."
docker build --build-arg USER=${USER} --build-arg PASS=${PASS} -t bucharestgold/rhel7-base .
# docker-squash -f 2 registry.access.redhat.com/rhel7 bucharestgold/rhel7-base:latest -t bucharestgold/rhel7-base:latest
docker-squash -f 3 -t bucharestgold/rhel7-base:squashed bucharestgold/rhel7-base:latest
./test.sh