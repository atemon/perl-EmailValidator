use EmailValidator;
use Test::Simple tests => 5;
use strict;

my $v = new EmailValidator();
ok(defined($v));
ok($v->is_valid('something@gmail.com'));
ok(!$v->is_valid('something@12#gmail.com'));
ok(!$v->is_valid('something@12@gmail.com'));
ok(!$v->is_valid(undef));