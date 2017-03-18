#!/bin/bash

if [ $# -lt 1 ];then
echo "Example Usage $0  host1,host2"
exit 0
fi

echo -n "Enter command"
read cmd

for i in `echo $* | tr -s ',' '  '` 
do
echo "Output From host $i"
ssh  root@$i "$cmd"
done
