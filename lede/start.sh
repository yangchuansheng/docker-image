#!/bin/bash

while :; do sleep 1; done & kill -STOP $! && wait $!
