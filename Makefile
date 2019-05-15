SHELL:=/usr/bin/zsh
OUTPUTS=README.rst project-catalog.rst project-tags.rst README.md README.html repos.md
all: $(OUTPUTS)

clean:
	@rm $(OUTPUTS)

#README.md: README.rst
	#pandoc -f rst -t markdown_github -o $@ $<

README.md: templates/README.md.j2 prjs.json
	yasha -v prjs.json $< -o $@
	#yasha -v prjs.json $< -o /tmp/README.md
	#pandoc -f markdown -t markdown_strict /tmp/README.md | sponge $@

repos.md: templates/repos.md.j2 prjs.json
	yasha -v prjs.json $< -o $@

templates/README.md: templates/README.md.j2 prjs.json
	yasha -v prjs.json $< -o $@

README.html: README.md
	pandoc -f markdown -t html -o $@ $<

prjs.json: templates/prjs.jsn templates/repos.json templates/tag-category.json
	jsonnet $< -o $@

prjs-catalog.json: templates/prjs-catalog.jsn
	jsonnet $< -o $@

project-catalog.rst: templates/project-catalog.rst.j2 prjs-catalog.json
	yasha -v prjs-catalog.json $< -o $@

project-tags.rst: templates/project-tags.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

README.rst: templates/README.rst.j2 prjs.json
	yasha -v prjs.json $< -o $@

#README.rst: templates/README.md
	#pandoc -f markdown -t rst --toc -o $@ $<

.PHONY: all
