
PROJ := aov-html2epub
PREFIX := /usr/local
pfix := $(DESTDIR)$(PREFIX)

libdir := $(pfix)/lib/$(PROJ)
mandir := $(pfix)/share/man/man1
files := $(wildcard scripts/*.awk)
targets := $(subst scripts, $(libdir), $(files))


install: $(pfix)/bin/$(PROJ) $(targets) $(mandir)/$(PROJ).1

uninstall:
	rm -f $(pfix)/bin/$(PROJ)
	rm -f $(libdir)/*
	rm -f $(mandir)/$(PROJ).1.gz
	rmdir $(libdir)

$(pfix)/bin/$(PROJ): $(PROJ)
	install -D $< $@
	sed -i -e 's;.HOME/bin/epub3;$(libdir);' $@

$(libdir)/%.awk: scripts/%.awk
	install -D -m 0644 $< $@

$(mandir)/%.1: %.1
	install -D -m 0644 $< $@
	gzip -9 $@

.PHONY: uninstall

