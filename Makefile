all: build-python-julia

build-julia-compat: build-julia build-julia-0.3.11
build-julia-dates: build-julia build-julia-0.3.11
build-julia-pycall: build-julia-compat build-julia-dates
build-python-julia: build-julia-pycall

build-%:
	${MAKE} -C $*
