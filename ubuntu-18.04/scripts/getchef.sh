#!/bin/bash
#
# getchef.sh - Get download of Chef Server
#
# Author     : Marcelo França <marcelo.frneves@gmail.com>
#
#  -------------------------------------------------------------
#   That's program get download of Chef Server via URL then
#   check if sha256 signature match, else send error message
#   in console (STDOUT).
#
#  -------------------------------------------------------------
# Changelog:
#
#    v1.0 2019-03-18, Marcelo Franca:
#       - Arranging shell script "docker-entrypoint.sh" to other script
#         named "getchef.sh". This script can only download chef
#    v1.1 2019-06-03, Marcelo Franca:
#	- Chef Version update.
sha256="bbf6127e03d10154e28b1270869731b38bd5a0981c9f9cb96f973c290d14c4df"
chef_url="https://packages.chef.io/files/stable/chef-server/12.19.31/ubuntu/18.04/chef-server-core_12.19.31-1_amd64.deb"

if [[ $sha256 == $(wget --no-check-certificate $chef_url -O $LOCAL_FILE && \
	sha256sum $LOCAL_FILE | awk '{print $1}') ]]; then
    echo "Download completed"
    exit 0;

else
	echo "Download failure. The sha256 code do not been match!!";
	echo "sha256 code required: $sha256";
	echo "sha256 code received: $(sha256sum $LOCAL_FILE | awk '{print $1}')";
	echo "Please. Try again";

fi
