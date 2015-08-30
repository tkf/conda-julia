#!/bin/bash

if [ $JULIA_VERSION = "<UNDEFINED>" ]
then
    JULIA_VERSION=0.4
fi
JULIA_PKG_NAME=Dates
DEST="$PREFIX/share/julia/site/v$JULIA_VERSION/$JULIA_PKG_NAME"

mkdir -p "$DEST"
cp --archive --no-target-directory "$PWD" "$DEST"
