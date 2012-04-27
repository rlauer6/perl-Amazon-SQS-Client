SUBDIRS = . 

perlrun = @PERL@
bashrun = @BASHRUN@

BASHSCRIPTS = \
    aws-sqsd.in

GBASHSCRIPTS = $(BASHSCRIPTS:.in=)

libexec_SCRIPTS = $(GBASHSCRIPTS)

initddir = /etc/rc.d/init.d

initd_SCRIPTS = $(GBASHSCRIPTS)

dist_noinst_DATA = $(BASHSCRIPTS)

@do_subst_command@

$(GBASHSCRIPTS): % : %.in
	$(do_subst) $< > $@

CLEANFILES = $(GBASHSCRIPTS)
