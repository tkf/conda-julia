using Base.Test

vers = "v$(VERSION.major).$(VERSION.minor)"
condasite = abspath(ENV["PREFIX"], "share", "julia", "site")
@test JULIA_HOME == abspath(ENV["PREFIX"], "bin")
@test Pkg.dir() == abspath(condasite, vers)
