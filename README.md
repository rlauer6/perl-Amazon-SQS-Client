# README

This is the README file for the `perl-Amazon-SQS-Client` project.

![Build Badge](https://github.com/rlauer6/perl-Amazon-SQS-Client/actions/workflows/build.yml/badge.svg)

This project contains Perl modules, an example Perl script and a
daemon for processing messages from Amazon Web Service's Simple Queue
Service.  Amazon SQS is designed to be a component in distributed
cloud based applications.  It implements a simple message queueing
system which allows you to send and receive messages that your
programs might use for interprocess communications.

* See [`INSTALL`](INSTALL.md) for generic information on how to build
and install autoconfiscated projects.
* See [Requirements](#requirements) for a list of requirements.
* See [Building the Software](#building-the-software) for installing _this_ project.
* See [Building a CPAN Distribution](#building-a-cpan-distribution)
  for creating a CPAN tarball.

# OVERVIEW

This is a fork of the `Amazon::SQS::Client` package distributed by
Amazon over a decade ago (2009).  Perl is no longer a first-class
citizen in the halls of the AWS SDK development wing, so it is
up to the Perl community to hack-patch these modules or write new ones
(like the CPAN module `PAWS` or `Amazon::SQS::Simple`).

So why reboot this module? I like the fact that this set of modules is
relatively light weight and requires only a few extra Perl modules
rather than a heavy weight solution like `PAWS` that requires `Moose`
and it's assorted friends. Along with creating a build system that
will create a tar ball, RPM or CPAN distributions I've also added a
bonus script [QueueDaemon.pl](src/main/perl/bin/QueuDaemon.pl.in) that
implements a daemon that will read and process SQS messages.

> Incidentally it should be possible with a little work to refactor
this module out of the `QueueDaemon.pl` script and replace it with one
of the other SQS Perl implementations.

The classes that were implemented by AWS are pretty basic and
a little verbose to use sometimes.  Here's an example that retrieves a
list of SQS queues:

```
my $sqs = Amazon::SQS::Client->new($ENV{AWS_ACCESS_KEY_ID}, $ENV{AWS_SECRET_ACCESS_KEY},
                                   { ServiceURL => 'https://queue.amazonaws.com' });

my $request = Amazon::SQS::Model::ListQueuesRequest->new();

my $response = $sqs->listQueues($request);

my $queues_result = $response->getListQueuesResult();

my $queues = $queues_result->getQueueUrl();
```

As they say, there's no free lunch, so if you don't mind the verbosity
and light-weight is your goal...keep reading.

## Differences From the Original Project

1. This project can create a tar ball, an RPM or a CPAN distribution
2. This project includes a so-called "queue daemon" in the form of a Perl script for handling SQS
messages [`QueueDaemon.pl`](src/main/perl/bin/QueueDaemon.pl.in)
3. Long polling - support for API version 2012-11-05 `WaitTimeSeconds`
parameter to the `ReceiveMessage` API call for implementing _long polling_
4. Support for temporary security tokens.
5. Support for Signature Version 4 (via `AWS::Signature4`)
6. Use `Amazon::Credentials` for transaparent supplying of credentials
7. Refactored examples

## Examples

The original Amazon SQS library was distributed as a .zip file with
example scripts.  The example files were skeletons that you were
expected to flesh out by adding your AWS credentials and instantiate
the correct parameters to send to the module being tested.

The examples in this project have been modified from their original as
follows:

* can read a configuration file (.ini style) of the same type as
  supported by the `QueueDaemon.pl` script
* accepts a list of argument on the command line
* provides some help for each example

If you installed this package from a CPAN distribution you'll find the
example script and example modules here:

```
perl -MFile::ShareDir=dist_dir -e 'print dist_dir("Amazon-SQS-Client");'
```

so...

```
cd $(perl -MFile::ShareDir=dist_dir -e 'print dist_dir("Amazon-SQS-Client");')
perl examples/examples.pl -h CreateQueue
```

## `create-queue.pl`

Use this script to create a new queue and optionally an associated
dead letter queue. There are also some commands you can use to
examine, send and receive messages. `perldoc create-queue.pl` for
complete documentation.

* create a queue with an associated DLQ
  ```
  create-queue.pl -q fuManQueue create
  ```
* show queue attributes
  ```
  create-queue.pl -q fuManQueue attribute
  ```
* list queues
  ```
  create-queue.pl list
  ```
* send a message
  ```
  create-queue.pl -q fuManQueue send-message 'Hello World!'
  ```
* delete the queues
  ```
  create-queue.pl -q fuManQueue delete
  ```
* receive a message
  ```
  create-queue.pl -q fuManQueue receive-message
  ```

# Requirements

* `make`
* `automake`
* `autoconf`
* [`make-cpan-dist`](https://github.com/rlauer6/make-cpan-dist.git)
* [`Module::ScanDeps::Static`](https://metacpan.org/pod/Module::ScanDeps::Static)

## Perl Module Requirements

* AWS::Signature4
* Carp
* CGI::Simple
* Class::Accessor::Fast
* Config::IniFiles
* Digest::SHA 6.02
* English
* JSON
* List::Util
* Log::Log4perl
* LWP::UserAgent
* Readonly
* Scalar::Util
* Test::More
* Time::HiRes
* URI
* URI::Escape
* XML::Simple

...and possibly others.

# Building the Software

```
./bootstrap
./configure --prefix=/usr/local
make
sudo make install
```

# Building a CPAN Distribution

In order to build the CPAN distribution you need to install all of the
these dependencies previously mentioned.

First build the project in the normal manner.

```
./bootstrap
./configure --prefix=/usr/local
make
```

Now you can build the distribution:

```
cd cpan
make cpan
```

## RPM Building

Assuming you know how to build RPMs and have the requisite rpm build
tools installed...

```
./configure --prefix=/usr
make && make dist
rpmbuild -tb perl-Amazon-SQS-Client-2.0.1.tar.gz
```


# `QueueDaemon.pl`

This is a fairly robust implementation of a daemon that will read and
process messages from an SQS queue. You create a class that contains a
`handler()` method that will receive messages from the daemon.  You
can learn more about the `QueueDaemon.pl` script and how to write your
own handlers by reading the docs.

* `perldoc QueueHandler.pl`
* `perldoc Amazon::SQS::QueueHandler`

The `QueueDaemon.pl` script uses and `.ini` style configuration
file. You can reead about the format and contents of the configuration file
in the `Amazon::SQS::Config` documentation.

```
perldoc Amazon::SQS::Config
```

# Author

The original Perl modules were (apparently) written/generated by
someone whose email address is:

`<Elena@AWS>`

The additional modules, scripts and refactoring can be attributed to
Rob Lauer <bigfoot@cpan.org>.
