 #!perl

use strict;
use warnings;

use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
use IO::Socket::SSL qw();
use WWW::Mechanize; 
use Test::More;
use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";
my $sympa_web_url = 'https://lists.example.com/sympa';

Then qr/list "(\S+)" should have a config file/, sub {
     ok(-f $sympa_root_dir."/list_data/$1/config", "List $1 exists" );
};

Then qr/list "(\S+)" should have a web page/, sub {
     my $mech = WWW::Mechanize->new( ssl_opts => { verify_hostname => 0, SSL_verify_mode => IO::Socket::SSL::SSL_VERIFY_NONE } ) ;
     $mech->get( $sympa_web_url.'/info/'.$1);
     printf "Title: %s\n", $mech->title();

     ok( $mech->title =~ 'This is my list - info');    
};


 
 