#!/usr/bin/perl

# O.Salaün, may 2018, have a try with WWW::Mechanize

use Test::More;
use IO::Socket::SSL qw();
use Test::WWW::Mechanize;
use WWW::Mechanize;

plan tests => 2;
 
my $w = Test::WWW::Mechanize->new;
 
my $url = 'https://lists.example.com/sympa';
 
#subtest home => sub {
#    $w->get_ok($url);
#    $w->title_is('Mon service de listes');
#};
 
#my $mech = WWW::Mechanize->new( autocheck => 0, ssl_opts => { verify_hostname => 0, SSL_verify_mode => IO::Socket::SSL::SSL_VERIFY_NONE } ) ;
my $mech = WWW::Mechanize->new( ssl_opts => { verify_hostname => 0, SSL_verify_mode => IO::Socket::SSL::SSL_VERIFY_NONE } ) ;
$mech->get( $url);
printf "Status: %s\n", $mech->status;
#printf "Content: %s\n", $mech->content();
printf "Title: %s\n", $mech->title();
ok( $mech->success );
ok( $mech->title eq 'Mon service de listes - home');
