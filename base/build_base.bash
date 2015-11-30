#!/bin/bash

# Build base/whrl Docker image

cd BASE_DIRECTORY/base
# Copy over host public key to use for passwordless ssh
cp ~/.ssh/id_rsa.pub ./host_rsa.pub
docker built -t base/whrl .
rm ./host_rsa.pub

exit 0
