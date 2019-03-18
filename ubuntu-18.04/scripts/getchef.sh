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
sha256="a95d248052c456fc5320eefbfe501c7e1282c029569fad5967f10f400e5a86d9"
chef_url="https://packages.chef.io/files/stable/chef-server/12.19.26/ubuntu/18.04/chef-server-core_12.19.26-1_amd64.deb"

if [[ $sha256 == $(wget -nv --no-check-certificate	 $chef_url -O $LOCAL_FILE && \
	sha256sum $LOCAL_FILE | awk '{print $1}') ]]; then


else
	echo "Download failure. The sha256 code do not been match!!";
	echo "sha256 code required: $sha256";
	echo "sha256 code received: $(sha256sum $LOCAL_FILE | awk '{print $1}')";
	echo "Please. Try again";

fi
