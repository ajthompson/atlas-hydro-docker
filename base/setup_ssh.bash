#!/bin/bash

# Generate new ssh keys for the Docker image if necessary
cd ${BASE_DIRECTORY}/base
if [ ! -f id_rsa ] && [ ! -f id_rsa.pub ] ; then
  # the ssh keys do not exist
  ssh-keygen -q -f $(pwd)/id_rsa -N ''

  echo "SSH keys generated. Please add public key id_rsa.pub to GitHub profile"
  echo "This is required so the container can access the git repository."
  echo "Press ENTER when completed."
  read -n 1 -s
fi

exit 0
