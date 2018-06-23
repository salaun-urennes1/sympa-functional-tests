#!/usr/bin/perl

# O.Salaün, May 2018
# Script to collect mails sent by the functional testing scripts

my $spool = '/opt/sympa-dev/mail_spool';

my $mail_content;
my $recipient;
while (<STDIN>) {
    $mail_content .= $_;
    ## Extract first Delivered-To header to determine recipient address 
    if (/^Delivered-To: (.+)$/) {
        $recipient ||= $1;
    }
    
}

unless (-d '/opt/sympa-dev/mail_spool') {
    mkdir '/opt/sympa-dev/mail_spool';
}

open MAIL, ">$spool/$recipient.eml";
print MAIL $mail_content;
close MAIL;
