$Id: README,v 1.3 2015/11/21 14:38:15 rlauer Exp $

This is the README file for the `perl-Amazon-SQS-Client' project.

This project contains perl modules and example perl scripts that
interface with Amazon Web Service's Simple Queue Service.  The Amazon
SQS is designed to be a component in distributed cloud based
applications.  It implements a simple message queueing system which
allows you to send and receive messages that your programs might use
for interprocess communications.

See `INSTALL' for information on how to build and instal this project.

See `BUGS' for information on how to report problems with this
project.

See `/usr/share/amazon-web-services/sqs/ReadMe.html' for the
information about how to use these modules.


EXAMPLES
========

The original Amazon SQS library was distributed as a .zip file with
example scripts found in the `amazon-queue/src/Amazon/SQS/Samples'
directory.  The example files were skeletons that you were expected to
flesh out by adding your AWS credentials and instantiate the correct
parameters to send to the module being tested.

The examples in this project have been modified from their original
version so that they will read a configuration file (.ini style) named
`aws-sqs.ini' located in the `/usr/share/amazon-web-services/sqs'
directory.

After installation of the package read the perldocs which describe the
format of this file and what you are expected to do to configure the
examples.

 $ perldoc Amazon::SQS::Config


WHERE TO GO FROM HERE
=====================

Author(s)
=========

The original perl modules were (apparently) written by someone whose
email address is:

 <Elena@AWS>

..so clearly the credit for the concept, excecution, content, and
substance, should go to that individual.  Likewise, please heap
accolades, carps, whines, and other forms of acknowledgments toward
that person(s) direction with regard to the software itself.

If you are at all annoyed at the packaging, wish it were a proper CPAN
module or other such nonsense than direct your venom here:

 Rob Lauer - <rlauer6@comcast.net>

You'll find some extra goodies that may or may not be of any value:

  Amazon/SQS/Config.pm => configuration file access

  QueDaemon.pl         => a base class for handling simple messages 
                          placed on SQS queues

  aws-sqsd             => bash script for starting a queue handling daemon
