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
# Delete Message  Sample
#

use strict;
use Carp qw( carp croak );
  
 #***********************************************************************
 # Access Key ID and Secret Acess Key ID, obtained from:
 # http://aws.amazon.com
 #**********************************************************************/
 
require Amazon::SQS::Config;

my $config = new Amazon::SQS::Config( '@aws_sqsdir@/aws-sqs.ini' );

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
 # sample for Delete Message Action
 #**********************************************************************/

use Amazon::SQS::Model::DeleteMessageRequest;
my $url = "https://queue.amazonaws.com/106518701080/treasurersbriefcase-new-account";


my $handle = " 0NNAq8PwvXt27y0okHZ5TMoXZOTzfdnW2FEiWqY9S/YPJtw4wGMlGj3u21+gHlTL10Qq6+gDIYmIYn5J/TlKZWtHUAD6VhIIPDAxzFuD5pRlkTQ1c5exI2x5hrxIDYvAnmrFVgU3x2jj7UhMB0eCbqw4w1rp6X28xmEb4jEwsQyu5UsxZ0upFeUN4OmcV79+DbobLMg65xwerch7YbciexU6gpVG/hG+QTIB0xvJO+vTb9o60ZBmcH2P5cnHQ86mcBxAUu0GsR3ejIxCDgX/yyleuD6y5PWm";


my $request = new Amazon::SQS::Model::DeleteMessageRequest( { QueueUrl => $url,
							      ReceiptHandle => $handle
							    }
							  );


 # @TODO: set request. Action can be passed as Amazon::SQS::Model::DeleteMessageRequest
 # object or hash of parameters
invokeDeleteMessage($service, $request);

                                        
    # 
    # Delete Message Action Sample
    #
  sub invokeDeleteMessage {
      my ($service, $request) = @_;  
      eval {
              my $response = $service->deleteMessage($request);
              
                print ("Service Response\n");
                print ("=============================================================================\n");

                print("        DeleteMessageResponse\n");
                if ($response->isSetResponseMetadata()) { 
                    print("            ResponseMetadata\n");
                    my $responseMetadata = $response->getResponseMetadata();
                    if ($responseMetadata->isSetRequestId()) 
                    {
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

                            
