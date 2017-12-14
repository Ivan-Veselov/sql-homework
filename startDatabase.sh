#!/bin/bash

port=5432

if [ "$1" != "" ]; then
    port=$1
fi

sudo docker build -t olympic_db .
sudo docker run -p $port:5432 -it olympic_db

