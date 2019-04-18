SHELL:=/usr/bin/zsh
OUTPUTS=README.rst project-catalog.rst project-tags.rst README.md #README.html
all: $(OUTPUTS)

clean:
	@rm $(OUTPUTS)

#README.md: templates/out.jsn
	#jsonnet -m ./ -S out.jsn

#README.md: README.rst
	#pandoc -f rst -t markdown_github -o $@ $<

README.md: templates/README.md.j2 prjs.json
	yasha -v prjs.json $< -o $@
	#yasha -v prjs.json $< -o /tmp/README.md
	#pandoc -f markdown -t markdown_strict /tmp/README.md | sponge $@

#README.html: README.rst
	#pandoc -f rst -t html -o $@ $<

prjs.json: templates/prjs.jsn
	jsonnet $< -o $@

project-catalog.rst: templates/project-catalog.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

project-tags.rst: templates/project-tags.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

README.rst: templates/README.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

.PHONY: all
