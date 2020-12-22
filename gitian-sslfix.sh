#!/bin/bash

#### Information ####
#
# A simple Bash shell script to fix Gitian (Ubuntu) SSL issues for Monero
# package repo website https://distro.ibiblio.org/
#
# For clarity: this SSL issue is caused by distro.ibiblio.org's webserver
# SSL certificate chain. Put simply: this issue can only truly be fixed by
# the webadmin of distro.ibiblio.org.  This script just acts as a patch
# fixing their issue for us locally by adding their SSL issuer's signed
# certificate into the locally trusted certificates on Ubuntu.
#
# The original Github issue (the reason why I wrote this script) is here:
#
# https://github.com/monero-project/monero/issues/7147
#
#### Authorship ####
#
# Written by root: https://github.com/setuidroot
#
# Repo for this script: https://github.com/setuidroot/gitian-sslfix
#
#### Begin Script ####

# Root check

if [[ $EUID -ne 0 ]]; then
   printf "This script needs root in order to write to the /usr/local/share/ca-certificates directory. \n\n"
	if id -nG "$USER" | grep -qw "sudo"; then
	  printf "Running sudo now (will ask for your password.) \n\n"
	  exec sudo "$0"
	else
	  printf "This user is not a member of the sudo group. Rerun this script as root (or by using sudo.) \n"
	  exit
	fi
else
   printf "Downloading distro.ibiblio.org SSL certificate... \n\n"

# Download distro.ibiblio.org's SSL cert, write it to /usr/local/share/ca-certificates directory
   wget "https://gist.githubusercontent.com/setuidroot/9ab7d6fe563b8d71932863371e195c24/raw/7cc94915fa0947ef4a070220ad6a3de0f07df2ed/distro_ibiblio_org.crt" -O /usr/local/share/ca-certificates/distro_ibiblio_org.crt
   echo -e "\n"
fi

# Check to make sure the SSL cert downloaded successfully and if it did,
# then run update-ca-certificates so Ubuntu adds it to trusted cert list.

if [[ -e /usr/local/share/ca-certificates/distro_ibiblio_org.crt ]]; then
   printf "distro.ibiblio.org SSL certificate downloaded, now updating certificates... \n\n"
   update-ca-certificates
   printf "\ndistro.ibiblio.org's SSL certificate successfully added to trusted list. \nDownloads from https://distro.ibiblio.org should work perfectly now. \n"
else
   printf "Certificate failed to download!  Try rerunning this script. \n"
   exit
fi
