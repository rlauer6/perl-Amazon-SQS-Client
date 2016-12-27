#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use Amazon::SQS::Client;
use Amazon::SQS::Model::ReceiveMessageRequest;
use Amazon::SQS::Model::ListQueuesRequest;
use Data::Dumper;
use JSON;

require_ok('Amazon::SQS::Client') or BAIL_OUT("could not require Amazon::SQS::Client");

ok($ENV{AWS_ACCESS_KEY_ID}, "access key present in environment") or BAIL_OUT("set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY");
ok($ENV{AWS_SECRET_ACCESS_KEY}, "secret access key present in environment") or BAIL_OUT("set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY");

my $AWS_REGION = 'us-east-1' || $ENV{AWS_REGION};
my $SERVICE_URL = 'https://sqs.' . $AWS_REGION . '.amazonaws.com';

# this should fail...
my $sqs = eval {
  Amazon::SQS::Client->new;
};

ok(defined $@, 'Amazon::SQS::Client::new()/missing credentials');

# this should succeed...
$sqs = Amazon::SQS::Client->new($ENV{AWS_ACCESS_KEY_ID}, $ENV{AWS_SECRET_ACCESS_KEY},
				{
				 SignatureVersion => '2',
				 ServiceURL => $SERVICE_URL
				}
			       );

isa_ok($sqs, 'Amazon::SQS::Client');

my $request = new Amazon::SQS::Model::ListQueuesRequest();
						       
isa_ok($request, 'Amazon::SQS::Model::ListQueuesRequest', 'Amazon::Model::ListQueuesRequest');

my $response = $sqs->listQueues($request);
isa_ok($response, 'Amazon::SQS::Model::ListQueuesResponse', 'Amazon::Model::ListQueuesRequest');

my $queues_result = $response->getListQueuesResult();
isa_ok($queues_result, 'Amazon::SQS::Model::ListQueuesResult', 'Amazon::Model::ListQueuesRequest');

my $queues = $queues_result->getQueueUrl();
is(ref($queues), 'ARRAY', 'Amazon::SQS::Model::ListQueuesRequest');
note("Queues\n" . join("\n", @$queues));
     
# Version 4 signing...
$sqs = Amazon::SQS::Client->new($ENV{AWS_ACCESS_KEY_ID}, $ENV{AWS_SECRET_ACCESS_KEY},
				{
				 SignatureVersion => '4',
				 ServiceURL => $SERVICE_URL
				}
			       );

my $queues_v4 = eval {
  my $request = new Amazon::SQS::Model::ListQueuesRequest();
  $sqs->listQueues($request);
};

ok(!$@, 'version 4 signing') or diag(ref($@) eq 'Amazon::SQS::Exception' ? $@->getMessage() : $@);
note("Queues:\n" . join("\n", @{$queues_v4->getListQueuesResult()->getQueueUrl()}));

done_testing();
