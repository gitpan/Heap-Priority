######################### We start with some black magic to print on failure.

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Heap::Priority;
$loaded = 1;
ok(1);

######################### End of black magic.

use Test;
use strict;
my ($h, $sv, @av);
$|++;

BEGIN { plan tests => 11 }
use Heap::Priority;
ok(1);

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
