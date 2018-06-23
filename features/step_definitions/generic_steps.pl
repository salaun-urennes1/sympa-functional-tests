 #!perl

use strict;
use warnings;

use Test::More;
use Test::BDD::Cucumber::StepFile;

When qr/I wait (\d+) seconds/, sub {
     sleep $1;
};



 
 