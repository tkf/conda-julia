if VERSION < v"0.4-"
    using Compat
end

# Make sure Dates installed by conda is used.
using Base.Test
@test startswith(Base.find_in_path("Dates"), ENV["PREFIX"])

# Make sure Dates is importable without any help from Pkg.
import Dates

Pkg.init()
Pkg.test("Dates", coverage=true)
