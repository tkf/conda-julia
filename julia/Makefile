build:
	conda build --source .
	$(MAKE) meta.yaml
	conda build .

meta.yaml: meta.yaml.sh pep386.jl
	bash $< > $@.tmp
	mv $@.tmp $@
