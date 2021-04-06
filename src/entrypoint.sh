#!/usr/bin/env bash
PY=${PY:-python}
PELICAN=${PELICAN:-pelican}

BASEDIR=$(pwd)
SRC_DIR=$BASEDIR/pages
OUTPUT_DIR=$BASEDIR/output
CFG_FILE=$BASEDIR/pelicanconf.py

cd "$BASEDIR" || exit;
$PELICAN --debug --autoreload -r "$SRC_DIR" -o "$OUTPUT_DIR" -s "$CFG_FILE" &
cd "$OUTPUT_DIR" || exit;
$PY -m pelican.server 8080
