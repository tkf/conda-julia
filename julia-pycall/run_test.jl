if VERSION < v"0.4-"
    using Compat
end

# Make sure PyCall installed by conda is used.
using Base.Test
@test startswith(Base.find_in_path("PyCall"), ENV["PREFIX"])

# Make sure PyCall is importable without any help from Pkg.
import PyCall

# Pkg.init()
# Pkg.test("PyCall", coverage=true)
