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

BEGIN { plan tests => 14006 }
use Heap::Priority;
ok(1);

$h = new Heap::Priority;

my ($a,$b);
for (0..13000) {
    $a=rand(100);
    $b=rand(100);
    $h->add($a,$b);
    ok($h->err_str !~ /./);
    if (($_ % 13)==0) {
	$h->pop;
	$h->pop;
	$h->pop;
	ok($h->err_str !~ /./);	
    }
}

ok($h->count    == 10000);
ok($h->get_heap == 10000);
