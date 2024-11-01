#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Data::Dumper;
use English qw(-no_match_vars);

use Log::Log4perl qw(:easy);

use Log::Log4perl::Level;

Log::Log4perl->easy_init($INFO);

########################################################################
subtest 'decode message' => sub {
########################################################################
  use_ok('Amazon::SQS::QueueHandler');

  my $handler = eval { return Amazon::SQS::QueueHandler->new( logger => Log::Log4perl->get_logger ); };

  ok( $handler, 'created handler' )
    or do {
    diag( Dumper( [ err => $EVAL_ERROR ] ) );
    BAIL_OUT('could not create handler');
    };

  isa_ok( $handler, 'Amazon::SQS::QueueHandler' );

  require Amazon::SQS::Model::Message;

  my $message = Amazon::SQS::Model::Message->new;
  $message->setMessageId('1234');

  my $text = 'foo=bar&foo=buz';

  $message->setBody($text);

  $message->setReceiptHandle('abc');

  $handler->decode_message($message);

  is( $handler->get_message, $text, 'plain text message' );

  $handler->set_message_type('application/x-www-form-encoded');
  $handler->decode_message($message);

  isa_ok( $handler->get_message, 'HASH', 'x-www-form-encoded message' );

  my $json = '[ { "foo" : "bar"}, { "foo" : "buz" } ]';
  $message->setBody($json);

  $handler->set_message_type('application/json');

  $handler->decode_message($message);
  isa_ok( $handler->get_message, 'ARRAY', 'JSON message' );

  is_deeply( $handler->get_message, JSON->new->decode($json), 'is deeply' );

  $handler->decode_message($message);
  isa_ok( $handler->get_message, 'ARRAY', 'JSON message' );

  is_deeply( $handler->get_message, JSON->new->decode($json), 'is deeply' );
};

done_testing;

1;
