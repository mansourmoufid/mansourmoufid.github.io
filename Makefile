ORIGIN:= https://mansourmoufid.github.io
EMAIL:= mansourmoufid@gmail.com

ENV:= ORIGIN="$(ORIGIN)" EMAIL="$(EMAIL)"

.PHONY: all
all: src
	find src -name '*.*' -not -path '*.html*' | while read f; do ( \
		x="$${f#src/}"; \
		echo "src/$$x > ./$$x"; \
		mkdir -p ./$$(dirname $$x); \
		cp -f src/$$x ./$$x; \
	); done
	$(MAKE) html
	$(MAKE) meta
	$(MAKE) sitemap
	find . -type f | xargs xattr -r -c
	find . -type f | xargs chmod 644
	find . -type d | xargs chmod 755

.PHONY: html
html: generate.py
	find src -name '*.html' -o -name '*.txt' | while read f; do ( \
		x="$${f#src/}"; \
		echo "src/$$x > ./$$x"; \
		mkdir -p ./$$(dirname $$x); \
		env $(ENV) python generate.py \
				< "src/$$x" \
				| env $(ENV) python generate.py \
				> "./$$x"; \
	); done

.PHONY: meta
meta: img.py
	python img.py
	find images -name '*~' | xargs rm

.PHONY: sitemap
sitemap:
	find . -name '*.html' -not -path './src/*' \
		| sort \
		| sed -e 's,^[.],'"$(ORIGIN)"',' \
			-e 's,index.html,,' \
		| tee sitemap.txt

.PHONY: live
live: all
	python -m http.server
