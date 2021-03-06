 #!perl

 use strict;
 use warnings;
  
 use Test::More;
 use Test::BDD::Cucumber::StepFile;

my $sympa_root_dir = "/usr/local/sympa";
my $sympa_default_domain = 'lists.example.com';
my $last_cmd_status;

Given qr/family "(\S+)" is defined/, sub {
      ok(-d $sympa_root_dir."/etc/families/$1", "Directory for family $1" );
      ok(-f $sympa_root_dir."/etc/families/$1/config.tt2", "Config.tt2 for family $1" );
 };
 
When qr/I instantiate family "(\S+)*" with "(\S+)"/, sub {
      print "$sympa_root_dir/bin/sympa.pl --instantiate_family $1 --close_unknown --input_file $sympa_root_dir/etc/families/$1/$2\n";
      `$sympa_root_dir/bin/sympa.pl --instantiate_family $1 --close_unknown --input_file $sympa_root_dir/etc/families/$1/$2`;
      S->{'last_cmd_status'} = $?;
 };

When qr/I modify list in family "(\S+)*" with "(\S+)"/, sub {
      `$sympa_root_dir/bin/sympa.pl --modify_list $1 --input_file $sympa_root_dir/etc/families/$1/$2`;
      printf "$sympa_root_dir/bin/sympa.pl --modify_list $1 --input_file $sympa_root_dir/etc/families/$1/$2\n";
      S->{'last_cmd_status'} = $?;
 };

When qr/I add list to family "(\S+)*" with "(\S+)"/, sub {
      printf "$sympa_root_dir/bin/sympa.pl --add_list $1 --input_file $sympa_root_dir/etc/families/$1/$2\n";
      `$sympa_root_dir/bin/sympa.pl --add_list $1 --input_file $sympa_root_dir/etc/families/$1/$2`;
      S->{'last_cmd_status'} = $?;
 };

When qr/I close list "(\S+)*"/, sub {
      `$sympa_root_dir/bin/sympa.pl --close_list $1`;
      S->{'last_cmd_status'} = $?;
};

When qr/I close family "(\S+)*"/, sub {
      printf "$sympa_root_dir/bin/sympa.pl --close_family $1 --robot $sympa_default_domain\n";
      `$sympa_root_dir/bin/sympa.pl --close_family $1 --close_unknown --robot $sympa_default_domain`;
      S->{'last_cmd_status'} = $?;
};

Given qr/sender email is imported in list "(\S+)*"/, sub {
     open CMD, "|$sympa_root_dir/bin/sympa.pl --import $1\@$sympa_default_domain" or die;
     printf CMD S->{'sender_email'}."\n";
     close CMD;
     S->{'last_cmd_status'} = $?;
};
