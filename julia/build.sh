#!/bin/bash

# Copy everything but LICENSE.md
cp --archive --target-directory=$PREFIX ${PWD}/*/

# Wrap original bin/julia to set $JULIA_PKGDIR
mv --verbose "$PREFIX/bin/julia" "$PREFIX/bin/julia_"
cp --verbose "$RECIPE_DIR/julia-wrapper.sh" "$PREFIX/bin/julia"

# Print version number in PEP 386 format.
bin/julia "$RECIPE_DIR/pep386.jl" > __conda_version__.txt

# Workaround conda-build's bug
if [[ "$PWD" != */work ]]
then
    cp --target-directory=.. __conda_*__.txt LICENSE.md
fi
