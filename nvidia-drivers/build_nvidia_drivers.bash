#!/bin/bash

# Build nvidia driver docker image
cd ${BASE_DIRECTORY}/nvidia-drivers
docker build -t nvidia-drivers/whrl .

exit 0

