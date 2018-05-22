#!/bin/bash

DOCS_FOLDER=$(pwd)
PORT=8080

usage="$(basename "$0") [-h] [-f folder] [-p port] build and start docs.ovh.com in a docker container

where:
    -h  show this help
    -f  set the docs repo path to build (default: current directory)
    -p  set the exposed docker port (default: 8080)
"

while getopts ':hp:f:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    p) PORT=$OPTARG
       ;;
    f) DOCS_FOLDER=$OPTARG
       ;;
    :) echo "Option -$OPTARG requires an argument." >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

if ! command -v docker
then
    echo "Please install docker first !"
    exit 1
fi

trap "echo 'stoping container...' && docker stop ovh-docs-dev-env" 2

if test $(docker images -f "reference=ovh-docs-dev-env" -q | wc -l) -eq 0; then docker build -t ovh-docs-dev-env .; fi
docker run --rm -v $DOCS_FOLDER/pages:/src/docs/pages -d --name ovh-docs-dev-env -p $PORT:8080 ovh-docs-dev-env
docker logs -f ovh-docs-dev-env

