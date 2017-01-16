#!/usr/bin/env bash

docker build . -t kitura-threading-sample &&\
docker run -itP --rm kitura-threading-sample
