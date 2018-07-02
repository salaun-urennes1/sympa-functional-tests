 #!perl

use strict;
use warnings;

use Template;
use Test::More;
use Test::BDD::Cucumber::StepFile;
use MIME::Parser;

my $sympa_root_dir = "/usr/local/sympa";
my $sender_prefix = 'testuser+';
my $sympa_default_domain = 'lists.example.com';
my $mail_spool_dir = '/opt/sympa-dev/mail_spool';
my $parser = MIME::Parser->new;
$parser->output_to_core(1);
$parser->tmp_dir('/tmp');

sub extract_mail_body {
     my $mail_content = shift;
     
     $mail_content =~ s/^.*\n\n//ms;
     
     return $mail_content;
}

Given qr/outgoing mail is based on template "(\S+)" for list "(\S+)"/, sub {
     ## Sender email is constructed with PID and time
     S->{'sender_email'} = $sender_prefix.$1.'-'.$2.'-'.$$.'-'.time.'@'.$sympa_default_domain;
     
     ## Parse mail template
     my $tt = Template->new(INCLUDE_PATH => ['data/mail_templates']);
     $tt->process($1.'.eml.tt2', {sender_email => S->{'sender_email'}, recipient_email => $2}, \S->{'outgoing_mail'}) || die $tt->error;
     
     S->{'parsed_outgoing_mail'} = $parser->parse_data(S->{'outgoing_mail'});
};

When "I send outgoing mail", sub {
     open MAIL, '|/usr/sbin/sendmail -t' or die $!;
     print MAIL S->{'outgoing_mail'};
     close MAIL;
     
     do { fail("Failed send outgioing mail"); return } unless ($? == 0);
};

Then "sender should receive incoming mail", sub {
     my $mail_in_spool = $mail_spool_dir.'/'.S->{'sender_email'}.'.eml';
     if (-f $mail_in_spool) {
        open MAIL, $mail_in_spool or die;
        while (<MAIL>) {
            S->{'incoming_mail'} .= $_;
        }
        close MAIL;
        S->{'parsed_incoming_mail'} = $parser->parse_data(S->{'incoming_mail'});

     }else {
          fail("Incoming mail ".$mail_in_spool." not found in mail_spool/");
     }
};

Then "incoming mail body should match outgoing mail", sub {
     ok(S->{'parsed_outgoing_mail'}->body_as_string eq S->{'parsed_incoming_mail'}->body_as_string, "Mail bodies match");
};

Then qr/incoming mail "(\S+)" header should include "(.+)"/, sub {
     printf "Subject : %s\n", S->{'parsed_incoming_mail'}->head->get($1);
     ok(S->{'parsed_incoming_mail'}->head->get($1) =~ /$2/, "Mail header $1 includes '$2'");
};


 