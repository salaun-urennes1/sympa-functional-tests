 #!perl

use strict;
use warnings;

use Template;
use Test::More;
use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";
my $sender_prefix = 'testuser+';
my $sympa_default_domain = '@lists.example.com';

Given qr/sender is defined for mail template "(\S+)" to list "(\S+)"/, sub {
     ## Sender email is constructed with PID and time
     S->{'sender_email'} = $sender_prefix.$1.'-'.$2.'-'.$$.'-'.time.$sympa_default_domain;
};

When qr/sender sends mail template "(\S+)" to list "(\S+)"/, sub {
     open MAIL, '|/usr/sbin/sendmail -t' or die $!;

     my $tt = Template->new(INCLUDE_PATH => ['data/mail_templates']);
     $tt->process($1.'.eml.tt2', {sender_email => S->{'sender_email'}, recipient_email => $2}, \*MAIL) || die $tt->error;
     close MAIL;
     
     do { fail("Failed send mail template $1 to list $2"); return } unless ($? == 0);
};


 
 