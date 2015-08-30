# Print Julia's version number in PEP 386 format:
#   N.N[.N]+[{a|b|c|rc}N[.N]+][.postN][.devN]
#
# Since it's hard to translate Julia's prerelease versioning scheme
# (dev => pre), I map all prerelease versions to "aN" (Nth alpha).
# Reading base/version_git.sh, it seems they put number of commits
# from the last tag to VERSION.build[1] so I'm using it as a
# prerelease number.  As VERSION.build[1] is just monotonically
# increasing in time, prerelease label doesn't mean much for conda.
#
# TODO: Maybe it's better to map "dev" to "a" and "pre" to "b" (or
# "rc")?  Note that mapping "dev" to "dev" does not work since
# in PEP 386, 1.0rc0 < 1.0.dev0.
#
# See:
# * https://www.python.org/dev/peps/pep-0386/
# * http://conda.pydata.org/docs/spec.html#package-metadata

pre = ""
if !isempty(VERSION.build)
    pre = "a$(VERSION.build[1])"
end

print("$(VERSION.major).$(VERSION.minor).$(VERSION.patch)$(pre)")
