#!/bin/sh
# Try to run lotus farcaster executing at the defined FREQUENCY. If farcaster take more time, the script will wait 10s before the next execution

sed -i "s#http://127.0.0.1:2345/rpc/v0#$MINER_URL#" /usr/local/bin/lotus-exporter-farcaster.py
sed -i "s#MINER_TOKEN = \"\"#MINER_TOKEN = \"$MINER_TOKEN\"#" /usr/local/bin/lotus-exporter-farcaster.py
sed -i "s#http://127.0.0.1:1234/rpc/v0#$DAEMON_URL#" /usr/local/bin/lotus-exporter-farcaster.py

while true; do
    BEG=$(date +%s)
    echo $(date +"%a %d %H:%M:%S" --date="@$BEG") Start exporting
    if python3 /usr/local/bin/lotus-exporter-farcaster.py > /data/farcaster.prom.$$
    then
        mv /data/farcaster.prom.$$ /data/farcaster.prom
    else
        rm /data/farcaster.prom.$$
    fi
    END=$(date +%s)
    DURATION=$(expr $END - $BEG)
    if [ "$DURATION" -ge 0"$FREQUENCY"  ]
    then
        SLEEP=10
    else
        SLEEP=$(expr 0$FREQUENCY - $DURATION)
    fi
    echo $(date +"%a %d %H:%M:%S" --date="@$END") Sleeping : $SLEEP
    sleep $SLEEP
done