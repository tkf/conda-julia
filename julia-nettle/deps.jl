# This works only with conda-based installation.

# Pre-hooks

# Macro to load a library
macro checked_lib(libname, path)
    ((VERSION >= v"0.4.0-dev+3844" ? Base.Libdl.dlopen_e : Base.dlopen_e)(path) == C_NULL) && error("Unable to load \n\n$libname ($path)\n\nPlease re-run Pkg.build(package), and restart Julia.")
    quote const $(esc(libname)) = $path end
end

# Load dependencies
eval(quote
     @checked_lib nettle $(abspath(JULIA_HOME, "..", "lib", "libnettle.so"))
     end)
