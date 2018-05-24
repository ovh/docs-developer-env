#!/bin/bash
if [ -z "$1" ]
    then
        echo "Usage : ./generate-doc.sh launch|init [path/to/ovh-docs]"
        echo "Caution : you need Python in version 3"
    exit 1
fi

export SRC=./src
export WORKDIR=./src/docs

if [ $1 = "launch" ]; then
    # Check if workdir exist first
    CMDLS=$(ls $WORKDIR; echo $?)

    # Launch server command
    if [ $CMDLS -eq "1" ]; then
        echo "Use init command first"
    else
        cd $WORKDIR
        echo "Launch entrypoint"
        ../entrypoint.sh
    fi
else
    if [ -z "$2" ]; then
        echo "Need path to ovh-docs"
        exit 1
    fi
    echo "Clone docs rendering repo"
    git clone https://github.com/ovh/docs-rendering.git $WORKDIR
    echo "Repo cloned"

    cd $WORKDIR

    export DOCS=$2
    echo "Create pages and output folders"
    mkdir output
    ln -s $DOCS/pages pages


    echo "Install requirements"
    pip install -r requirements.txt

    echo "Change mode to execute"
    chmod +x ../entrypoint.sh

    echo "Launch entrypoint"
    ../entrypoint.sh
fi