#!/bin/bash

# Copy everything but LICENSE.md
cp --archive --target-directory=$PREFIX ${PWD}/*/

# Wrap original bin/julia to set $JULIA_PKGDIR
mv --verbose "$PREFIX/bin/julia" "$PREFIX/bin/julia_"
cp --verbose "$RECIPE_DIR/julia-wrapper.sh" "$PREFIX/bin/julia"
