SHELL:=/usr/bin/zsh

all: README.rst

clean:
	@rm README.rst

README.md: out.jsn
	jsonnet -m ./ -S out.jsn

prjs.json: prjs.jsn
	jsonnet prjs.jsn -o $@

README.rst: readme.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

.PHONY: all
