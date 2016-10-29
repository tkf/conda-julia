using Base.Test

vers = "v$(VERSION.major).$(VERSION.minor)"
prefix = realpath(ENV["PREFIX"])
condasite = abspath(prefix, "share", "julia", "site")
@test JULIA_HOME == abspath(prefix, "bin")
@test Pkg.dir() == abspath(condasite, vers)
