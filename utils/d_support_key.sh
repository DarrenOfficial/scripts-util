#!/bin/bash
# Thanks Phill!

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
ENDCOLOR="\e[0m"

help() {
     echo "";
     echo "Usage: d_support_key.sh [add|remove|check]";
     echo "";
     exit 0;
}

case "$1" in
        --help|help|-h)
                help
                ;;
esac

SUPPORT_KEY=''
TMP_DOWNLOAD_LOCATION=/tmp
OPTION=$1;

if [ "$OPTION" == 'add' ]; then
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	touch ~/.ssh/authorized_keys
	IS_KEY_INSTALLED=$(cat ~/.ssh/authorized_keys | grep -w me@darrennathanael.com)
	if [ "${IS_KEY_INSTALLED}" == "" ]; then
		echo -e "\nDownloading Darren support SSH key."
		wget https://lore.dpaste.org/security/id_ed25519.pub -O ${TMP_DOWNLOAD_LOCATION}/__tmp___vf__support___key >/dev/null 2>&1
		echo -e "Downloading Darren support SSH key check."
		wget https://lore.dpaste.org/security/d_support.checksum -O ${TMP_DOWNLOAD_LOCATION}/__tmp___vf_support__key___check >/dev/null 2>&1
		CHECKSUM=$(cat ${TMP_DOWNLOAD_LOCATION}/__tmp___vf_support__key___check | awk '{ print $1 }')
		KEYSUM=$(sha1sum ${TMP_DOWNLOAD_LOCATION}/__tmp___vf__support___key | awk '{ print $1 }')
		if [ "${CHECKSUM}" == "${KEYSUM}" ]; then
			SUPPORT_KEY=$(cat ${TMP_DOWNLOAD_LOCATION}/__tmp___vf__support___key)
			echo "${SUPPORT_KEY}" >> ~/.ssh/authorized_keys
			rm -f ${TMP_DOWNLOAD_LOCATION}/__tmp___vf__support___key
			rm -f ${TMP_DOWNLOAD_LOCATION}/__tmp___vf_support__key___check
			echo -e "\n${GREEN}Darren support SSH key installed successfully.${ENDCOLOR}\n"
		else
			echo -e "\n${RED}Support key check failed. Contact support.${ENDCOLOR}\n"
		fi
	else
		echo -e "\n${YELLOW}Darren support SSH key is already installed!${ENDCOLOR}\n"
	fi
	chmod 600 ~/.ssh/authorized_keys

	elif [ "$OPTION" == 'remove' ]; then
		IS_KEY_INSTALLED=$(cat ~/.ssh/authorized_keys | grep -w me@darrennathanael.com)
		if [ "${IS_KEY_INSTALLED}" == "" ]; then
			echo -e "\n${RED}Darren support SSH key not found!${ENDCOLOR}\n"
		else
			sed -i '/me@darrennathanael.com/ d' ~/.ssh/authorized_keys
			echo -e "\n${GREEN}Darren support SSH key removed successfully.${ENDCOLOR}\n"
		fi
	elif [ "$OPTION" == 'check' ]; then
    		IS_KEY_INSTALLED=$(cat ~/.ssh/authorized_keys | grep -w me@darrennathanael.com)
    		if [ "${IS_KEY_INSTALLED}" == "" ]; then
    			echo -e "\n${YELLOW}Darren support SSH key NOT installed.${ENDCOLOR}\n"
    		else
    			echo -e "\n${YELLOW}Darren support SSH key IS installed.${ENDCOLOR}\n"
    		fi
	else
		help
fi