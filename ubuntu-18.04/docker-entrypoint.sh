#!/bin/bash
#
# docker-entrypoint.sh - Install and configure chef-server on Unix
#
# Author     : Marcelo França <marcelo.frneves@gmail.com>
#
#  -------------------------------------------------------------
#   That's program get download of chef-server via URL added by 
#   user in docker-compose, then install via dpkg if sha256
#   signature match, else send error message in console (STDOUT).
#
#  -------------------------------------------------------------
#
#
# Changelog:
#
#    v1.0 2019-02-26, Marcelo Franca:
#       - Inicial version
#    v1.1 2019-02-26, Marcelo Franca:
#		- Added chef_url environment
#    v1.2 2019-02-26, Marcelo Franca:
#		- Added --no-check-certificate option
# Licence: GPL.
#
sha256="a95d248052c456fc5320eefbfe501c7e1282c029569fad5967f10f400e5a86d9"
local_file="/tmp/chef-server.deb"
chef_url="https://packages.chef.io/files/stable/chef-server/12.19.26/ubuntu/18.04/chef-server-core_12.19.26-1_amd64.deb"

if [[ $sha256 == $(wget --no-check-certificate $chef_url -O $local_file && \
	sha256sum $local_file | awk '{print $1}') ]]; then

	dpkg -i $local_file
	if [[ $? != 0 ]]; then
		echo "Installation failure"
		exit 2
	fi
else
	echo "Download failure. The sha256 code do not been match!!";
	echo "sha256 code required: $sha256";
	echo "sha256 code received: $(sha256sum $local_file | awk '{print $1}')";
	echo "Please. Try again";

fi