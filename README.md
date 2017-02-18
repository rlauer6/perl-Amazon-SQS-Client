# OVERVIEW

This is the README.md file for the `perl-Amazon-SQS-Client` project.

This project contains Perl modules and example Perl scripts that
interface with Amazon Web Service's Simple Queue Service.  The Amazon
SQS is designed to be a component in distributed cloud based
applications.  It implements a simple message queueing system which
allows you to send and receive messages that your programs might use
for interprocess communications.

See `INSTALL` for information on how to build and install this
project.  If you are attempting to create a CPAN distribution or just
want to install things the `Perlish` way, build the project in the
recommended way and install the project using the Perl standard
incantations.

```
$ ./configure --with-sysconfdir=/etc/
$ make
$ sudo make install
```
...then

```
$ cd /usr/share/perl-Amazon-SQS-Client/perl-dist
$ sudo perl Makefile.PL
$ make test
$ sudo make install
```

If you are interested in creating an RPM, see the information below on
**RPM BUILDING**.

See `TESTING` for information on how to test the build.

See `BUGS` for information on how to report problems with this
project.

See `/usr/share/amazon-web-services/sqs/ReadMe.html` for the
information about how to use these modules.

# HISTORY

This is a fork of the `Amazon::SQS::Client` package distributed by
Amazon a few years ago (2009).  Perl is no longer a first-class
citizen in the halls of the AWS SDK development wing, so it is
up to the Perl community to hack-patch these modules or write new ones
(like the CPAN module `PAWS`) to fill the void.

I like the fact that this set of modules is a relatively light weight
and requires only a few extra Perl modules rather than a heavy weight
solution like `PAWS` that requires `Moose` and it's assorted friends.
These modules are pretty low-level and a little verbose to use though.
Here's an example that retrieves a list of SQS queues:

```
my $sqs = Amazon::SQS::Client->new($ENV{AWS_ACCESS_KEY_ID}, $ENV{AWS_SECRET_ACCESS_KEY},
                                   {ServiceURL => 'https://s3.us-east-1.amazonaws.com'});

my $request = Amazon::SQS::Model::ListQueuesRequest->new();
my $response = $sqs->listQueues($request);
my $queues_result = $response->getListQueuesResult();
my $queues = $queues_result->getQueueUrl();
```

As they say, there's no free lunch, so if you don't mind the verbosity
and light-weight is your goal...keep reading.

# HACKS TO ORIGINAL PROJECT

1. This project can create an RPM - I've include a working `.spec`
file.
2. An example queue daemon - this project includes a so-called
"queue worker" in the form of an example daemon for handling SQS
messages (`QueueDaemon.pl`).
3. Long polling - support for API version 2012-11-05 `WaitTimeSeconds`
parameter to the `ReceiveMessage` API call.
4. Support for temporary security tokens.
5. Support for Signature Version 4 (via AWS::Signature4)

# TODO

Add support of batch operations.

# MORE DETAILS

## REQUIRED PERL MODULES

* AppConfig
* AWS::Signature4
* Crypt::SSLeay
* Data::Dumper
* Digest::SHA
* LWP::Protocol::https
* LWP::UserAgent
* Time::HiRes
* Proc::PID::File
* Proc::Daemon
* Scalar::Util
* URI::Escape
* XML::Simple

You can try this, but your RPM repos might not have all of those
symbols.  If you're stuck, use `cpanm` (`App::cpanminus`).

```
$ for a in $(cat required-modules); do sudo yum install -y 'perl'($a')'; done
```

## QUICK INSTALL

```
$ ./configure --prefix=/usr --sysconfdir=/etc
$ make
$ sudo make install
```

## RPM BUILDING

Assuming you know how to build RPMs and have the requisite rpm build
tools installed...

```
$ ./configure --prefix=/usr
$ make && make dist
$ rpmbuild -tb perl-Amazon-SQS-Client-1.1.1.tar.gz
```

## EXAMPLES

The original Amazon SQS library was distributed as a .zip file with
example scripts (formerly) found in the
`amazon-queue/src/Amazon/SQS/Samples` directory.  The example files
were skeletons that you were expected to flesh out by adding your AWS
credentials and instantiate the correct parameters to send to the
module being tested.

The examples in this project have been modified from their original
version so that they will read a configuration file (.ini style) named
`aws-sqs.ini` located in the `/usr/share/amazon-web-services/sqs'
directory.

After installation of the package read the `perldocs` which describe the
format of this file and what you are expected to do to configure the
examples.

```
 $ perldoc Amazon::SQS::Config
```

# WHERE TO GO FROM HERE

Try any of the examples in the
`/usr/share/amazon-web-services/sqs/examples` directory.

# `QueueDaemon.pl`

This is a reference implementation of what you might call a **queue
worker**.  The idea is for you to examine the code and modify it
according to your needs.  It does not actually do anything useful
other than read messages from queues.  You're supposed to write a
handler that interprets the message and does whatever voodoo you do in
your application.

# AUTHOR

The original Perl modules were (apparently) written/generated by
someone whose email address is:

`<Elena@AWS>`

The additional hack-patching can be attributed to Rob Lauer
<rlauer6@comcast.net>.

You'll find some extra goodies that may or may not be of any value:

*  `Amazon::SQS::Config` - configuration file access
*  `QueDaemon.pl` - a reference implementation of a daemon for handling simple messages placed on SQS queues
*  `aws-sqsd` - System V init script starting a queue handling daemon

Enjoy!
