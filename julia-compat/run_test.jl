using Compat

# Make sure Compat installed by conda is used.
using Base.Test
@test startswith(Base.find_in_path("Compat"), ENV["PREFIX"])

# Pkg.init()
# Pkg.test("Compat", coverage=true)
