#!/bin/bash

# TODO: input file.md as an argument

usage() {
    cat <<EOM
    Builds the CV from markdown to PDF and static HTML
	Requires some tools to be installed, see prerequisites.sh
	-h: shows this help
	-s: silent mode, does not show the result in browser
	-m: source markdown file
	-c: css style file
	-p: output PDF file
	-o: output HTML file
	Usage: $0
EOM
    exit 0
}

init() {
	silent=0
	while getopts "hsm:c:p:o:" flag; do
		case "${flag}" in
			h)
				usage
				;;
			s)
				silent=1
				;;
			m)
				md_file=$OPTARG
				;;
			c)
				css_file=$OPTARG
				;;
			p)
				pdf_file=$OPTARG
				;;
			o)
				html_file=$OPTARG
				;;
		esac
	done
	browser=$(xdg-settings get default-web-browser | cut -d "." -f1)

  [[ -z $md_file ]] || [[ -z $css_file ]] || [[ -z $pdf_file ]] || \
  [[ -z $html_file ]] && usage
}

generate() {
  abs_css="$(pwd)/$css_file"
	pandoc --standalone --from markdown --to html -c $abs_css -o $html_file $md_file
	if [[ -f $html_file ]]; then
		wkhtmltopdf -L 20mm -R 20mm $html_file $pdf_file
	fi
}

review() {
	if [ $silent -eq 0 ] && [ -f $pdf_file ] && [ -f $html_file ]; then
		$browser $pdf_file
		$browser $html_file
	fi
}

# Main program

[ $# -eq 0 ] && usage
init $@
generate
review
