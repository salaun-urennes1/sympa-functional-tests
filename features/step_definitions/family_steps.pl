 #!perl

 use strict;
 use warnings;

 use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
  
 use Test::More;
 use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";

 Given qr/family "(\S+)" is installed/, sub {
      -d "/opt/sympa-dev/data/$1" ||
         do { fail("No directory for family $1"); return };
      dircopy("/opt/sympa-dev/data/$1", $sympa_root_dir."/etc/families/$1");
 };

 Given qr/family "(\S+)" is defined/, sub {
      ok(-d $sympa_root_dir."/etc/families/$1", "Directory for family $1" );
      ok(-f $sympa_root_dir."/etc/families/$1/config.tt2", "Config.tt2 for family $1" );
 };
 
 When qr/I instantiate family "(\S+)*" with "(\S+)*"/, sub {
      `$sympa_root_dir/bin/sympa.pl --instantiate_family $1 --input_file $sympa_root_dir/etc/families/$1/$2` ||
         do { fail("Failed to instantiate family $1 with $2"); return };
 };
