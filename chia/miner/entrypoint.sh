#! /bin/bash

sed -i "/apiKey/c apiKey: $(APIKEY)" config.yaml
sed -i "/minerName/c minerName: $HOSTNAME" config.yaml

./hpool-miner-chia
