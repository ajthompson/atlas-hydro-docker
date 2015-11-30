#!/bin/bash

# Build the networking image
cd ${BASE_DIRECTORY}/networking
docker build -t networking/whrl .

exit 0
