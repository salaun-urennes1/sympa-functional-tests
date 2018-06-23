 #!perl

use strict;
use warnings;

use File::Copy::Recursive qw(fcopy rcopy dircopy fmove rmove dirmove);
use IO::Socket::SSL qw();
use WWW::Mechanize; 
use Test::More;
use Test::BDD::Cucumber::StepFile;

my $sympa_web_url = 'https://lists.example.com/sympa';

Then qr/list "(\S+)" homepage title should contain "([^"]+)"/, sub {
     my $mech = WWW::Mechanize->new( ssl_opts => { verify_hostname => 0, SSL_verify_mode => IO::Socket::SSL::SSL_VERIFY_NONE } ) ;
     $mech->get( $sympa_web_url.'/info/'.$1);

     ok( $mech->title =~ /$2/);    
};


 
 