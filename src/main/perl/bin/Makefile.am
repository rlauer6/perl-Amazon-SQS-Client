SUBDIRS = .

perlrun = @PERL@

perl5libdir = @perl5libdir@
ax_perl5_extra_includes_opt = @ax_perl5_extra_includes_opt@

aws_sqsdir = @datadir@/amazon-web-services/sqs
examplesdir = $(aws_sqsdir)/examples

libexec_SCRIPTS = \
    QueueDaemon.pl

PERLSCRIPTS = \
    AddPermissionSample.pl.in \
    ChangeMessageVisibilitySample.pl.in \
    CreateQueueSample.pl.in \
    DeleteMessageSample.pl.in \
    DeleteQueueSample.pl.in \
    GetQueueAttributesSample.pl.in \
    ListQueuesSample.pl.in \
    QueueDaemon.pl.in \
    ReceiveMessageSample.pl.in \
    RemovePermissionSample.pl.in \
    SendMessageSample.pl.in \
    SetQueueAttributesSample.pl.in

GPERLSCRIPTS = $(PERLSCRIPTS:.pl.in=.pl)

examples_DATA = $(GPERLSCRIPTS)
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

all:

CLEANFILES = $(GPERLSCRIPTS)
