#!/bin/bash

for((i=1;i<=100000;i++)); do ore --rpc ${RPC_URL} --keypair ~/.config/solana/id.json --priority-fee 1 mine --threads 10; done