#!@perlrun@

################################################################################ 
#  Copyright 2008 Amazon Technologies, Inc.
#  Licensed under the Apache License, Version 2.0 (the "License"); 
#  
#  You may not use this file except in compliance with the License. 
#  You may obtain a copy of the License at: http://aws.amazon.com/apache2.0
#  This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
#  CONDITIONS OF ANY KIND, either express or implied. See the License for the 
#  specific language governing permissions and limitations under the License.
################################################################################ 
#    __  _    _  ___ 
#   (  )( \/\/ )/ __)
#   /__\ \    / \__ \
#  (_)(_) \/\/  (___/
# 
#  Amazon SQS Perl Library
#  API Version: 2009-02-01
#  Generated: Thu Apr 09 01:13:11 PDT 2009 
# 

#
# Send Message  Sample
#

use strict;
use Carp qw( carp croak );
use Data::Dumper;
use URI::Escape;
  
#***********************************************************************
# Access Key ID and Secret Acess Key ID, obtained from:
# http://aws.amazon.com
#**********************************************************************/

require Amazon::SQS::Config;

my $config = new Amazon::SQS::Config( '@aws_sqsdir@/aws-sqs.ini' );
$config->define("message=s");

$config->getopt;

my $message = $config->message;

printf("message: %s\n", $message );

my $AWS_ACCESS_KEY_ID     = $config->aws_access_key_id;
my $AWS_SECRET_ACCESS_KEY = $config->aws_secret_access_key;

#***********************************************************************
# Instantiate Http Client Implementation of SQS 
#**********************************************************************/
use Amazon::SQS::Client;

my $service = Amazon::SQS::Client->new($AWS_ACCESS_KEY_ID, $AWS_SECRET_ACCESS_KEY);
 
#************************************************************************
# Uncomment to try out Mock Service that simulates Amazon::SQS
# responses without calling Amazon::SQS service.
#
# Responses are loaded from local XML files. You can tweak XML files to
# experiment with various outputs during development
#
# XML files available under Amazon/SQS/Mock tree
#
#**********************************************************************/
# use Amazon::SQS::Mock;  
# my $service = Amazon::SQS::Mock->new;

#************************************************************************
# Setup request parameters and uncomment invoke to try out 
# sample for Send Message Action
#**********************************************************************/
use Amazon::SQS::Model::SendMessageRequest;
use Amazon::SQS::Model::Attribute;

$message = "message=this is a test" unless $message;
$message = uri_escape( $message );

my $request = new Amazon::SQS::Model::SendMessageRequest( 
							 {
							  QueueUrl => $config->aws_queue_url, 
							  MessageBody => $message
							 }
							);

invokeSendMessage($service, $request);

                                                            
# 
# Send Message Action Sample
#
sub invokeSendMessage {
  my ($service, $request) = @_;  
  eval {
    my $response = $service->sendMessage($request);
              
    print ("Service Response\n");
    print ("=============================================================================\n");

    print("        SendMessageResponse\n");
    if ($response->isSetSendMessageResult()) { 
      print("            SendMessageResult\n");
      my $sendMessageResult = $response->getSendMessageResult();
      if ($sendMessageResult->isSetMessageId()) {
	print("                MessageId\n");
	print("                    " . $sendMessageResult->getMessageId() . "\n");
      }
      if ($sendMessageResult->isSetMD5OfMessageBody()) {
	print("                MD5OfMessageBody\n");
	print("                    " . $sendMessageResult->getMD5OfMessageBody() . "\n");
      }
    } 
    if ($response->isSetResponseMetadata()) { 
      print("            ResponseMetadata\n");
      my $responseMetadata = $response->getResponseMetadata();
      if ($responseMetadata->isSetRequestId()) {
	print("                RequestId\n");
	print("                    " . $responseMetadata->getRequestId() . "\n");
      }
    } 

           
  };
  my $ex = $@;
  if ($ex) {
    require Amazon::SQS::Exception;
    if (ref $ex eq "Amazon::SQS::Exception") {
      print("Caught Exception: " . $ex->getMessage() . "\n");
      print("Response Status Code: " . $ex->getStatusCode() . "\n");
      print("Error Code: " . $ex->getErrorCode() . "\n");
      print("Error Type: " . $ex->getErrorType() . "\n");
      print("Request ID: " . $ex->getRequestId() . "\n");
      print("XML: " . $ex->getXML() . "\n");
    } else {
      croak $@;
    }
  }
}
