######################### We start with some black magic to print on failure.

use Test;

BEGIN { $| = 1; plan tests => 10; }
END {print "not ok 1\n" unless $loaded;}
use Heap::Priority;
$loaded = 1;
ok(1);

######################### End of black magic.

use strict;
my ($h, $sv, @av);

# Test heap creation
$h = new Heap::Priority;
ok(defined($h));

# Test lack of errors
$sv = $h->err_str;
ok($sv !~ /./);

# Empty heap has 0 elements
$sv = $h->count;
ok($sv == 0);

$sv = $h->pop;
ok(!defined($sv));

$sv = $h->count;
ok($sv == 0);

$h->add(123);
$sv = $h->count;
ok($sv == 1);

$sv = $h->pop;
ok($sv == 123);

$sv = $h->count;
ok($sv == 0);

# Test lack of errors
$sv = $h->err_str;
ok($sv !~ /./);
