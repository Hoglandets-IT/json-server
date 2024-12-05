#!/bin/bash
# This file is used to start the application from the docker container
echo "$JSON_DATA" > test.json \
  && node -- ./lib/cli/bin.js --host 0.0.0.0 test.json
