#!/usr/bin/env bash

docker build . -t kitura-threading-sample &&\
docker run -it --rm kitura-threading-sample
