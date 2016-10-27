cat "$RECIPE_DIR/LICENSE_footer.md" >> LICENSE.md

# Detect number of CPUs.
# See: https://github.com/ContinuumIO/anaconda-recipes/blob/master/pyqt/build.sh
if [ `uname` == Darwin ]; then
    MAKE_JOBS=$(sysctl -n hw.ncpu)
fi

if [ `uname` == Linux ]; then
    MAKE_JOBS=$CPU_COUNT
fi

# Detect machine architecture.
# See: https://github.com/ContinuumIO/anaconda-recipes/blob/master/mkl/build.sh
if [ `uname -m` == x86_64 ]; then
    INTEL_ARCH=intel64
else
    INTEL_ARCH=ia32
fi

source ${MKLROOT:-/opt/intel/mkl}/bin/mklvars.sh $INTEL_ARCH

cp --verbose "$RECIPE_DIR/Make.user" .
echo "prefix=$PREFIX" >> Make.user
make -j $MAKE_JOBS
make install

"$RECIPE_DIR/fix_rpath.py" --prepend '$ORIGIN' $PREFIX/lib/julia/lib*
"$RECIPE_DIR/fix_rpath.py" $PREFIX/bin/julia*

cp -t $PREFIX/lib/julia \
   $MKLROOT/../compiler/lib/intel64/libiomp5.so \
   $MKLROOT/lib/$INTEL_ARCH/lib*.so


# Wrap original bin/julia to set $JULIA_PKGDIR
mv --verbose "$PREFIX/bin/julia" "$PREFIX/bin/julia_"
cp --verbose "$RECIPE_DIR/julia-wrapper.sh" "$PREFIX/bin/julia"
