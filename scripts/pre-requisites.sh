#!/bin/bash

usage() {
    cat <<EOM
    Check and install pre-requisites for building the CV from markdown
	Install the following packages: $packages
	Usage: $0 [args]
	-h: shows this help
	-s: silent mode, does not show the result in browser
EOM
    exit 0
}

check_os() {
	if [[ -z $(dpkg -l) ]]; then
		echo "Not supported OS"
		exit 1
	fi
}

browser() {
	br=$(xdg-settings get default-web-browser | cut -d "." -f1)
	if [[ -z $br ]]; then
		echo "Must install some browser"
		exit 1
	else
		echo "Your default browser is $br"
	fi
}

requisites() {
	sudo apt install -y $packages
}

# Main program

packages="pandoc wkhtmltopdf"
silent=0

while getopts "hs" flag; do
    case "${flag}" in
        h)
			usage
			;;
		s)
			silent=1
			;;
    esac
done

check_os
[[ $silent -eq 0 ]] && browser
requisites