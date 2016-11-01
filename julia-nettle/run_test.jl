using Nettle

# Make sure Nettle installed by conda is used.
using Base.Test
@test startswith(Base.find_in_path("Nettle"), ENV["PREFIX"])

# Pkg.init()
# Pkg.test("Nettle", coverage=true)
