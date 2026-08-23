
PROJ := aov-html2epub
PREFIX = /usr/local
pfix := $(DESTDIR)$(PREFIX)

libdir := $(pfix)/libexec/$(PROJ)
mandir := $(pfix)/share/man/man1
targets := $(subst scripts/, $(libdir)/, $(wildcard scripts/*.awk))

all:
	@echo "There is no compilation, only 'make install', or a hand install in ~/bin."

install: $(pfix)/bin/$(PROJ) $(targets) $(mandir)/$(PROJ).1.gz

uninstall:
	rm -f $(pfix)/bin/$(PROJ)
	rm -f $(mandir)/$(PROJ).1.gz
	rm -f $(libdir)/*
	rmdir $(libdir)

$(pfix)/bin/$(PROJ): $(PROJ)
	install -D $<	$@
	sed -i -e 's;.HOME/bin/epub3;$(PREFIX)/libexec/$(PROJ);' $@

$(libdir)/%.awk: scripts/%.awk
	install -D -m 0644 $<	$@

$(mandir)/%.1.gz: %.1
	@cp $< scripts
	gzip -9 scripts/$<
	install -D -m 0644 scripts/$<.gz	$@
	rm scripts/$<.gz

.PHONY: all uninstall

