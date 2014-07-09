use EmailValidator;
use Test::Simple tests => 8;
use strict;

my $v = new EmailValidator();
ok(defined($v));
ok($v->is_valid('something@gmail.com'));
ok(!$v->is_valid('something12345678901234567890123456789012345678901234567890123456789012@gmail.com'));
ok(!$v->is_valid('something12@gmail12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890.com'));
ok(!$v->is_valid('something12345678901234567890123456789012345678901234567890@12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890gmail.com'));
ok(!$v->is_valid('something@12#gmail.com'));
ok(!$v->is_valid('something@12@gmail.com'));
ok(!$v->is_valid(undef));