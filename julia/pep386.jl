# Print Julia's version number in PEP 386 format:
#   N.N[.N]+[{a|b|c|rc}N[.N]+][.postN][.devN]
#
# See:
# * https://www.python.org/dev/peps/pep-0386/
# * http://conda.pydata.org/docs/spec.html#package-metadata

pre = ""
dev = ""
if !isempty(VERSION.prerelease)
    if VERSION.prerelease[2] == "alpha"
        pre = "a$(VERSION.prerelease[3])"
    elseif VERSION.prerelease[2] == "beta"
        pre = "b$(VERSION.prerelease[3])"
    else
        pre = "a0"
    end
end
if !isempty(VERSION.build)
    if pre == ""
        pre = "a0"
    end
    dev = ".dev$(VERSION.build[1])"
end

print("$(VERSION.major).$(VERSION.minor).$(VERSION.patch)$(pre)$(dev)")
