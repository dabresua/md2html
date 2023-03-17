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
  echo "Installing the following packages: $packages"
	sudo apt install -y $packages
  echo "Packages installed"
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

[[ $silent -eq 0 ]] && browser
requisites
