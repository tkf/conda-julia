using Base.Test

vers = "v$(VERSION.major).$(VERSION.minor)"
condasite = abspath(ENV["PREFIX"], "share", "julia", "site")
@test JULIA_HOME == abspath(ENV["PREFIX"], "bin")
@test Pkg.dir() == abspath(condasite, vers)
@test Base.LOAD_CACHE_PATH[1] == abspath(condasite, "lib", vers)
