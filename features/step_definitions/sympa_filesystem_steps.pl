 #!perl

use strict;
use warnings;

use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
use Test::More;
use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";

Then qr/list "(\S+)" should( not)? have a config file/, sub {
     if ($2) {
          ok(not -f "$sympa_root_dir/list_data/$1/config", "List $1 does not exist" );
     }else {
          ok(-f "$sympa_root_dir/list_data/$1/config", "List $1 exists" );
     }
};

Given qr/list "(\S+)" has a config file/, sub {
     ok(-f $sympa_root_dir."/list_data/$1/config", "List $1 exists" );
};

Then qr/list "(\S+)" config file should contain "([^"]+)"/, sub {
     my ($listname, $content) = ($1, $2); 
     open CONFIG, "$sympa_root_dir/list_data/$1/config" ||
          do { fail("Failed to open config file for list $1"); return };
     my $config_content;
     while (<CONFIG>) {
          $config_content .= $_;
     }
     close CONFIG;
     ok($config_content =~ /$2/m, "List $listname config contains $content" );
};

Then qr/command should fail/, sub {
      do { fail("Command succeeded with status ".S->{'last_cmd_status'}); return } if (S->{'last_cmd_status'} == 0);
};

Given qr/family "(\S+)" is defined/, sub {
      -d "/opt/sympa-dev/data/$1" ||
         do { fail("No directory for family $1"); return };
 };

Given qr/family "(\S+)" is installed/, sub {
      dircopy("/opt/sympa-dev/data/$1", $sympa_root_dir."/etc/families/$1");
 };

Given qr/I remove list "(\S+)" existing directory/, sub {
     my $list_dir = $sympa_root_dir.'/list_data/'.$1;
     if (-d $list_dir)  {
        `rm -Rf $list_dir`;
        do { fail("Failed to remove dir $list_dir"); return } unless ($? == 0);
     }
     
};

 
 
