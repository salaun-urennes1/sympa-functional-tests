 #!perl

use strict;
use warnings;

use Template;
use Test::More;
use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";

sub sendmail {
     my %args = @_;
     
     
}

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
     open CONFIG, "$sympa_root_dir/list_data/$1/config" ||
          do { fail("Failed to open config file for list $1"); return };
     my $config_content;
     while (<CONFIG>) {
          $config_content .= $_;
     }
     close CONFIG;
     ok($config_content =~ /$2/m, "List $1 config contains $2" );
};

Then qr/list "(\S+)" homepage title should contain "([^"]+)"/, sub {
     my $mech = WWW::Mechanize->new( ssl_opts => { verify_hostname => 0, SSL_verify_mode => IO::Socket::SSL::SSL_VERIFY_NONE } ) ;
     $mech->get( $sympa_web_url.'/info/'.$1);

     ok( $mech->title =~ /$2/);    
};


 
 