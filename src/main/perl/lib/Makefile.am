SUBDIRS = .

perlrun = @PERL@
perl5libdir = @perl5libdir@
ax_perl5_extra_includes_opt = @ax_perl5_extra_includes_opt@

# this is where we will install these perl modules
amz_sqsdir = @perl5libdir@/Amazon/SQS
amz_sqs_modeldir =$(amz_sqsdir)/Model

logdir = @localstatedir@/log

AMAZON_SQS = \
   Amazon/SQS/Client.pm.in \
   Amazon/SQS/Config.pm.in \
   Amazon/SQS/Exception.pm.in \
   Amazon/SQS/Model.pm.in

AMAZON_SQS_MODEL = \
    Amazon/SQS/Model/AddPermissionRequest.pm.in \
    Amazon/SQS/Model/AddPermissionResponse.pm.in \
    Amazon/SQS/Model/Attribute.pm.in \
    Amazon/SQS/Model/MessageAttribute.pm.in \
    Amazon/SQS/Model/MessageAttributeValue.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityBatchRequest.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityBatchRequestEntry.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityBatchResponse.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityBatchResult.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityBatchResultEntry.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityRequest.pm.in \
    Amazon/SQS/Model/ChangeMessageVisibilityResponse.pm.in \
    Amazon/SQS/Model/CreateQueueRequest.pm.in \
    Amazon/SQS/Model/CreateQueueResponse.pm.in \
    Amazon/SQS/Model/CreateQueueResult.pm.in \
    Amazon/SQS/Model/DeleteMessageBatchRequest.pm.in \
    Amazon/SQS/Model/DeleteMessageBatchRequestEntry.pm.in \
    Amazon/SQS/Model/DeleteMessageBatchResponse.pm.in \
    Amazon/SQS/Model/DeleteMessageBatchResult.pm.in \
    Amazon/SQS/Model/DeleteMessageBatchResultEntry.pm.in \
    Amazon/SQS/Model/DeleteMessageRequest.pm.in \
    Amazon/SQS/Model/DeleteMessageResponse.pm.in \
    Amazon/SQS/Model/DeleteQueueRequest.pm.in \
    Amazon/SQS/Model/DeleteQueueResponse.pm.in \
    Amazon/SQS/Model/Error.pm.in \
    Amazon/SQS/Model/ErrorResponse.pm.in \
    Amazon/SQS/Model/GetQueueAttributesRequest.pm.in \
    Amazon/SQS/Model/GetQueueAttributesResponse.pm.in \
    Amazon/SQS/Model/GetQueueAttributesResult.pm.in \
    Amazon/SQS/Model/ListQueuesRequest.pm.in \
    Amazon/SQS/Model/ListQueuesResponse.pm.in \
    Amazon/SQS/Model/ListQueuesResult.pm.in \
    Amazon/SQS/Model/ListDeadLetterSourceQueuesRequest.pm.in \
    Amazon/SQS/Model/ListDeadLetterSourceQueuesResponse.pm.in \
    Amazon/SQS/Model/ListDeadLetterSourceQueuesResult.pm.in \
    Amazon/SQS/Model/Message.pm.in \
    Amazon/SQS/Model/ReceiveMessageRequest.pm.in \
    Amazon/SQS/Model/ReceiveMessageResponse.pm.in \
    Amazon/SQS/Model/ReceiveMessageResult.pm.in \
    Amazon/SQS/Model/RemovePermissionRequest.pm.in \
    Amazon/SQS/Model/RemovePermissionResponse.pm.in \
    Amazon/SQS/Model/ResponseMetadata.pm.in \
    Amazon/SQS/Model/SendMessageRequest.pm.in \
    Amazon/SQS/Model/SendMessageResponse.pm.in \
    Amazon/SQS/Model/SendMessageResult.pm.in \
    Amazon/SQS/Model/SetQueueAttributesRequest.pm.in \
    Amazon/SQS/Model/SetQueueAttributesResponse.pm.in

GAMAZON_SQS = $(AMAZON_SQS:.pm.in=.pm)

GAMAZON_SQS_MODEL = $(AMAZON_SQS_MODEL:.pm.in=.pm)

amz_sqs_DATA = $(GAMAZON_SQS)

amz_sqs_model_DATA = $(GAMAZON_SQS_MODEL)

GPERLMODULES = $(GAMAZON_SQS_MODEL) $(GAMAZON_SQS)

dist_noinst_DATA = $(AMAZON_SQS) $(AMAZON_SQS_MODEL)

@do_subst_command@

if USING_PERL5_EXTRA_INCLUDES
PERL5_EXTRA_INCLUDES = $(ax_perl5_extra_includes_opt)
else
endif

# Please see the notes concerning PERLINCLUDE in the ../bin/Makefile.am file
PERLINCLUDE = \
   -I $(builddir) \
   $(PERL5_EXTRA_INCLUDES) \
   -I $(perl5libdir) 

$(GPERLMODULES): % : %.in Amazon/SQS/Exception.pm 
	test -d "$$(dirname "$@")" || $(INSTALL) -d "$$(dirname "$@")"
	$(do_subst) $< > $@
	perl  $(PERLINCLUDE) -wc $@ || { rm $@ && exit 1; }

all:

CLEANFILES = $(GPERLMODULES)
