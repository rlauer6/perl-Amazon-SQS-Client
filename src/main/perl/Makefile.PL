use ExtUtils::MakeMaker;

WriteMakefile(
	      NAME => 'Amazon::SQS',
	      AUTHOR => 'bigfoot',
	      VERSION_FROM => 'lib/Amazon/SQS/Client.pm',
	      PREREQ_PM => {
			    "AppConfig"       => "0",
			    "AWS::Signature4" => "0",
			    "Carp"            => "0",
			    "Cwd"             => "0",
			    "Data::Dumper"    => "0",
			    "Digest::SHA"     => "0",
			    "File::Basename"  => "0",
			    "Getopt::Long"    => "0",
			    "LWP::UserAgent"  => "0",
			    "Proc::Daemon"    => "0",
			    "Proc::PID::File" => "0",
			    "Scalar::Util"    => "0",
			    "Time::HiRes"     => "0",
			    "URI"             => "0",
			    "URI::Escape"     => "0",
			    "XML::Simple"     => "0"
			   }
	     );
			    
