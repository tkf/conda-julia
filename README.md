# Conda recipes for JuliaLang and its packages


## Why conda?

- Easily install official nightly build without destroying current
  Julia environment (or even without system install).
- Trying cutting-edge Julia without long compilation.
- Stick with Julia version that works with your code.
- Install cross-language package like [pyjulia] (and maybe
  [PyPlot.jl], [IJulia.jl], etc. in the future) automatically through
  single package manager (= conda).
  - With those recipes, running `conda install python-julia` installs
    all its requirements: Python, Julia and Julia packages.
- Isolated environment that does not contaminate your `~/.julia/`
  directory.
  - You can still install Julia packages using `Pkg.add(pkg)`.  But it
    goes into `<CONDA ENV>/share/julia/site/vX.Y/` instead of
    `~/.julia/`.


## Recipes

- Julia binary distributions from [official download page].
  - `julia/`: nightly build
  - `julia-X.Y.Z/`: stable releases
  - `julia-X.Y.Z-mkl/`: custom Julia build with Intel MKL
  - `jl-mkl/`: "meta package" for choosing `julia-X.Y.Z-mkl`.
    Installing this package instructs conda to use Julia build with MKL.

- Julia packages:
  - `julia-compat/`
  - `julia-nettle/`
  - `nettle/`

The following packages work only with Julia <= 0.4.  I'm leaving them
for a demonstration purpose.  Note that you can still install those
packages in an isolated conda environment using Julia's package manger
(e.g., `Pkg.add("PyCall")`).

- Julia packages (for Julia <= 0.4):
  - `julia-dates/`
  - `julia-pycall/`
- [Python interface to julia][pyjulia]:
  - `python-julia/`

[official download page]: http://julialang.org/downloads/
[pyjulia]: https://github.com/JuliaLang/pyjulia
[PyPlot.jl]: https://github.com/stevengj/PyPlot.jl
[IJulia.jl]: https://github.com/JuliaLang/IJulia.jl


## How to build the packages

Install `conda-build` and run `conda build .` at each recipe directory
(e.g., `julia-0.5.0/`).  Note that Julia packages will be build
against Julia 0.5.x unless you set environment variable as
`JULIA_VERSION=0.4`.

### Julia build with Intel MKL

You need to build `jl-mkl` and `julia-X.Y.Z-mkl`:

```sh
conda build jl-mkl
conda build julia-X.Y.Z-mkl
conda install --use-local julia jl-mkl
```

### Setting up IJulia

Some Julia packages required for IJulia need external library.
Official Anaconda repository already has ZMQ but it does not have
nettle.  If you do not have root privileges it may be useful to use
conda to install ZMQ and nettle.  Here is how to build Nettle.jl
(julia-nettle) including its dependencies and then install everything
else using `Pkg.add()`.

```sh
conda build nettle
conda build julia-compat
conda build julia-nettle
conda install --use-local julia julia-nettle
conda install zeromq
```
Then, in Julia REPL:
```
julia> Pkg.init()
julia> Pkg.add("IJulia")
```


## Behind the scene

Julia environment is isolated by using `$JULIA_PKGDIR` environment
variable.  Julia executable `bin/julia` is replaced by a shell script
doing something like the following (actual script is at
`./julia/julia-wrapper.sh`):

```bash
ORIGINAL_JULIA="<CONDA ENV>/bin/julia_"
JULIA_HOME="<CONDA ENV>/bin"

if $JULIA_PKGDIR is not defined
then
    JULIA_PKGDIR=$JULIA_HOME/../share/julia/site
    export JULIA_PKGDIR
fi

exec $ORIGINAL_JULIA "$@"
```


## (Not) TODO

At the moment, I'm not planning to extend this repository to include
more packages.  Actually, just having Julia environment locked in a
conda environment is enough since `Pkg.add(pkg)` would do rest of the
work.  But probably it would be nice to have binary distribution of
the packages that require binary build.  In that case, I would start
writing "[conda-skeleton]" for Julia.

[conda-skeleton]: http://conda.pydata.org/docs/commands/build/conda-skeleton.html


## LICENSE

MIT
