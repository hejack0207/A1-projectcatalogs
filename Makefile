SHELL:=/usr/bin/zsh

all: readme.rst

clean:
	@rm readme.rst

readme.rst: out.jsn
	jsonnet -m ./ -S out.jsn

.PHONY: all
