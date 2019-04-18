SHELL:=/usr/bin/zsh

all: README.rst project-catalog.rst project-tags.rst

clean:
	@rm README.rst

README.md: out.jsn
	jsonnet -m ./ -S out.jsn

prjs.json: prjs.jsn
	jsonnet $< -o $@

project-catalog.rst: project-catalog.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

project-tags.rst: project-tags.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

README.rst: README.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

.PHONY: all
