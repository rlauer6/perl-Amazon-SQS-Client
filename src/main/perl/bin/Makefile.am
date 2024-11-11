SUBDIRS = .

perlrun = @PERL@

perl5libdir = @perl5libdir@
ax_perl5_extra_includes_opt = @ax_perl5_extra_includes_opt@

bin_SCRIPTS = \
    QueueDaemon.pl \
    create-queue.pl

PERLSCRIPTS = \
    QueueDaemon.pl.in \
    create-queue.pl.in

GPERLSCRIPTS = $(PERLSCRIPTS:.pl.in=.pl)

dist_noinst_DATA = $(PERLSCRIPTS)

@do_subst_command@

if USING_PERL5_EXTRA_INCLUDES
PERL5_EXTRA_INCLUDES = $(ax_perl5_extra_includes_opt)
else
endif

PERLINCLUDE = \
    -I $(builddir) \
    -I ../$(builddir)/lib \
    $(PERL5_EXTRA_INCLUDES) \
    -I $(perl5libdir)

$(GPERLSCRIPTS): % : %.in
	test -d "$$(dirname "$@")" || $(INSTALL) -d "$$(dirname "$@")"
	$(do_subst) $< > $@
	perl -wc $(PERLINCLUDE)  $@ || { rm $@ && exit 1; }
	chmod +x $@

all:

CLEANFILES = $(GPERLSCRIPTS)
