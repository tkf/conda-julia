#!/bin/bash

if [ "$JULIA_VERSION" = "<UNDEFINED>" -o "$JULIA_VERSION" = "" ]
then
    JULIA_VERSION=0.5
fi
JULIA_PKG_NAME=Nettle
DEST="$PREFIX/share/julia/site/v$JULIA_VERSION/$JULIA_PKG_NAME"

mkdir -p "$DEST/deps"
cp --archive --no-target-directory "$PWD" "$DEST"
cp --verbose "$RECIPE_DIR/deps.jl" "$DEST/deps/"
