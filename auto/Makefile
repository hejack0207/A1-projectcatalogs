SHELL:=/usr/bin/zsh

OUTPUTS=README.rst project-catalog.rst project-tags.rst README.md README.html repos.md
all: $(OUTPUTS)

clean:
	@rm $(OUTPUTS)

# markdown
README.md: templates/README.md.j2 json/prjs.json
	yasha -v json/prjs.json $< -o $@

repos.md: templates/repos.md.j2 json/prjs.json
	yasha -v json/prjs.json $< -o $@

README.html: README.md
	pandoc -f markdown -t html -o $@ $<

# restructed doc
project-catalog.rst: templates/project-catalog.rst.j2 json/prjs-catalog.json
	yasha -v json/prjs-catalog.json $< -o $@

project-tags.rst: templates/project-tags.rst.j2 json/prjs.json
	yasha -v json/prjs.json $< -o $@

README.rst: templates/README.rst.j2 json/prjs.json
	yasha -v json/prjs.json $< -o $@

# json files
json/prjs.json: data/prjs.jsn data/repos.json data/tag-category.json json
	jsonnet $< -o $@

json/prjs-catalog.json: data/prjs-catalog.jsn json
	jsonnet $< -o $@

json:
	mkdir -p json

.PHONY: all
