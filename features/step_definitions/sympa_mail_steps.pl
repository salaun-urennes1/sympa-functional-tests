 #!perl

use strict;
use warnings;

use Template;
use Test::More;
use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";
my $sender_prefix = 'testuser+';
my $sympa_default_domain = 'lists.example.com';
my $mail_spool_dir = '/opt/sympa-dev/mail_spool';

sub extract_mail_body {
     my $mail_content = shift;
     
     $mail_content =~ s/^.*\n\n//ms;
     
     return $mail_content;
}

Given qr/sender is defined for mail template "(\S+)" to list "(\S+)"/, sub {
     ## Sender email is constructed with PID and time
     S->{'sender_email'} = $sender_prefix.$1.'-'.$2.'-'.$$.'-'.time.'@'.$sympa_default_domain;
};

When qr/sender sends mail template "(\S+)" to list "(\S+)"/, sub {
     open MAIL, '|/usr/sbin/sendmail -t' or die $!;

     my $tt = Template->new(INCLUDE_PATH => ['data/mail_templates']);
     $tt->process($1.'.eml.tt2', {sender_email => S->{'sender_email'}, recipient_email => $2}, \*MAIL) || die $tt->error;
     close MAIL;
     
     do { fail("Failed send mail template $1 to list $2"); return } unless ($? == 0);
};

Then "mail spool should contain sender mail", sub {
     ok(-f $mail_spool_dir.'/'.S->{'sender_email'}.'.eml', "Mail for ".S->{'sender_email'}."in mail spool");
};

Then qr/mail body in spool should be the same as mail template "(\S+)"/, sub {
     my $mail_in_spool = $mail_spool_dir.'/'.S->{'sender_email'}.'.eml';
     open MAIL, $mail_in_spool;
     my $mail_in_spool_content;
     foreach (<MAIL>) {
          $mail_in_spool_content .= $_;
     }
     close MAIL;
     print extract_mail_body($mail_in_spool_content);
};
 