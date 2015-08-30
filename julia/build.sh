#!/bin/bash

# Copy everything but LICENSE.md
cp --archive --target-directory=$PREFIX ${PWD}/*/

# Wrap original bin/julia to set $JULIA_PKGDIR
mv --verbose "$PREFIX/bin/julia" "$PREFIX/bin/julia_"
cp --verbose "$RECIPE_DIR/julia-wrapper.sh" "$PREFIX/bin/julia"

# Print version number such as "0.4.0.dev6991".  Reading
# base/version_git.sh, it seems they put number of commits from the
# last tag to build_number[1] so I'm using it as a "dev number" (see
# PEP 386).
bin/julia --eval 'print("$(VERSION.major).$(VERSION.minor).$(VERSION.patch).$(VERSION.prerelease[1])$(VERSION.build[1])")' > __conda_version__.txt

# Workaround conda-build's bug
if [[ "$PWD" != */work ]]
then
    cp --target-directory=.. __conda_*__.txt LICENSE.md
fi
