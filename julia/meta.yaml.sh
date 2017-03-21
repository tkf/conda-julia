#!/bin/bash -e

RECIPE_DIR="$PWD"
cd ~/anaconda/conda-bld/julia_*/work/julia-*/

cat <<EOF
package:
  name: julia
  version: "$(bin/julia "$RECIPE_DIR/pep386.jl")"

source:
  fn: julia-linux64.tar.gz                                # [linux64]
  fn: julia-linux32.tar.gz                                # [linux32]
  url: https://status.julialang.org/download/linux-x86_64 # [linux64]
  url: https://status.julialang.org/download/linux-i686   # [linux32]

build:
  binary_relocation: False

test:
  files:
    - run_test.jl
  commands:
    - which julia
    - julia --version
    - julia --check-bounds=yes run_test.jl

about:
  home: http://julialang.org
  license_file: LICENSE.md
EOF
