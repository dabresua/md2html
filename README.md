# Markdown to HTML

Utils to convert markdown to HTML and PDF

## Introduction

This project provides scripts to generate static HTML and PDF files from markdown.

After generating, the scripts visualize both files in the default browser.

## How to use it

First, install required tools:

```bash
./scripts/pre-requisites.sh
```

Then, generate HTML and PDF from markdown and style file.

```bash
./scripts/generate.sh -m <markdown_file.md> -c <style.css> -p <file.pdf> -h <file.html>
```

## Silent mode

To avoid visualizing the results on browser, user can enable the silent mode.

```bash
./scripts/pre-requisites.sh -s
./scripts/generate.sh -s -m <markdown_file.md> -c <style.css> -p <file.pdf> -h <file.html>
```