#!/bin/bash

nohup epik daemon > /dev/null &

while true
  do
    echo "Waiting for initialization......"
    if [ -f "/data/node/config.toml" ];then
	echo "Initialization complete! exited!"
        exit
    fi
    sleep 2
done    