#! /bin/bash

sed -e -i "s/^apiKey/apiKey: $(APIKEY)/g" config.yaml
sed -e -i "s/^minerName/minerName: $HOSTNAME/g" config.yaml

./hpool-miner-chia
