SHELL:=/usr/bin/zsh

all: readme.rst

clean:
	@rm readme.rst

readme.rst: out.jsn
	jsonnet -m ./ -S out.jsn

prjs.json: prjs.jsn
	jsonnet prjs.jsn -o $@

README.rst: README.rst.j2 prjs.json
	yasha -v prjs.json $^ -o $@

.PHONY: all
