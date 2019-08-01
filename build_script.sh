#!/bin/bash

declare -a VERS=("2.8.3" "2.7.0" "2.6.0" "2.5.0" "2.4.0" "2.3.0" "2.2.0")

for i in ${VERS[@]}; do
  docker build -t johnsondnz/ansible:${i} --build-arg ANSIBLE_VERSION=${i} .
  docker push johnsondnz/ansible:${i}
done
