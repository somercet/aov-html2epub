
PROJ := aov-html2epub
PREFIX := /usr/local
pfix := $(DESTDIR)$(PREFIX)

libdir := $(pfix)/lib/aov-html2epub
files := $(wildcard scripts/*.awk)
targets := $(subst scripts, $(libdir), $(files))


install: $(pfix)/bin/$(PROJ) $(targets)

uninstall:
	rm -f $(pfix)/bin/$(PROJ)
	rm -f $(libdir)/*
	rmdir $(libdir)

$(libdir)/%.awk: scripts/%.awk
	install -D -m 0644 $< $@

$(pfix)/bin/$(PROJ): $(PROJ)
	install -D $< $@
	sed -i -e 's;.HOME/bin/epub3;$(libdir);' $@

.PHONY: uninstall

