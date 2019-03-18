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
#		    - Added chef_url environment
#    v1.2 2019-02-26, Marcelo Franca:
#		    - Added --no-check-certificate option
#   v1.3 2019-03-13, Marcelo Franca:
#		    - Organizing statements of install into functions
# Licence: GPL.
#
installchef() {
	dpkg -i $LOCAL_FILE > /dev/null 2>&1
	if [[ $? == 0 ]]; then
		echo "Installation has been completed!"
		rm -f $LOCAL_FILE
		touch /.chefsrv
		/bin/bash
	else
		echo "The installation failure"
		exit 2
	fi
}
if [[ -f /.chefsrv ]]; then
	echo "Chef Server has been configured"
	/bin/bash
else
	echo -e "The Chef Server has not yet been installed.\n\n"
	echo -e "Starting the Installation...\n\n"
	sleep 5;
	installchef;
fi
