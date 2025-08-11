#!/usr/bin/env bash

# This file was automatically generated with PreTeXt 2.26.0.
# If you modify this file, PreTeXt will no longer automatically update it.

wget https://github.com/jgm/pandoc/releases/download/3.6.4/pandoc-3.6.4-1-amd64.deb -O pandoc.deb

# wait for 60 second and then double check that no other script is using apt-get:
sleep 60
while fuser /var/lib/dpkg/lock >/dev/null 2>&1; do
    echo "Waiting for apt-get to be free..."
    sleep 15
done
# Install pandoc
sudo apt-get install -y --no-install-recommends ./pandoc.deb 

rm pandoc.deb
