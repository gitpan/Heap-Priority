######################### We start with some black magic to print on failure.

use Test;

BEGIN { $| = 1; plan tests => 113; }
END {print "not ok 1\n" unless $loaded;}
use Heap::Priority;
$loaded = 1;
ok(1);

######################### End of black magic.

use strict;
my ($h, $sv, @av);

$h = new Heap::Priority;
$h->highest_first;
$h->lifo;

my ($a,$b);
for $a (0..9) {
    for $b (0..9) {
	$h->add(10*$a+$b,$a);
    }
}
ok($h->next_item == 99);
ok($h->next_level == 9);

$h->lifo;
$h->highest_first;
ok($h->next_item == 99);
ok($h->next_level == 9);

$h->lowest_first;
ok($h->next_item == 9);
ok($h->next_level == 0);

$h->fifo;
ok($h->next_item == 0);
ok($h->next_level == 0);

$h->highest_first;
ok($h->next_item == 90);
ok($h->next_level == 9);

$h->highest_first;
$h->lifo;
for $a (1..23) {
    $h->pop;
}
ok($h->next_item == 76);
ok($h->next_level == 7);

$h->lifo;
$h->highest_first;
ok($h->next_item == 76);
ok($h->next_level == 7);

$h->lowest_first;
ok($h->next_item == 9);
ok($h->next_level == 0);

$h->fifo;
ok($h->next_item == 0);
ok($h->next_level == 0);

$h->highest_first;
ok($h->next_item == 70);
ok($h->next_level == 7);

$h->lilo;
$h->lowest_first;

for $a (1..14) {
    $h->pop;
}
$h->highest_first;
$h->lifo;

ok($h->next_item == 76);
ok($h->next_level == 7);

$h->lowest_first;
ok($h->next_item == 19);
ok($h->next_level == 1);

$h->fifo;
ok($h->next_item == 14);
ok($h->next_level == 1);

$h->highest_first;
ok($h->next_item == 70);
ok($h->next_level == 7);

$h->lilo;
$h->lowest_first;

ok($h->count == 63);

$h->delete_item(22,2);
$h->delete_item(30);

ok($h->count == 61);

for $a (1..4) {
    $h->delete_priority_level(int($h->pop%10));
}

ok($h->count==20);

my @a=(18,19,20,21,23,24,25,26,27,28,29,31,32,33,34,35,36,37,38,39); 
my @b=$h->get_list;
for $a (0..19) {
    ok($b[$a] == $a[$a]);
}

$h->highest_first;
@a=(31,32,33,34,35,36,37,38,39,20,21,23,24,25,26,27,28,29,18,19); 
@b=$h->get_list;
for $a (0..19) {
    ok($b[$a] == $a[$a]);
}

$h->filo;
@a=(39,38,37,36,35,34,33,32,31,29,28,27,26,25,24,23,21,20,19,18);
@b=$h->get_list;
for $a (0..19) {
    ok($b[$a] == $a[$a]);
}

$h->lowest_first;
@a=(19,18,29,28,27,26,25,24,23,21,20,39,38,37,36,35,34,33,32,31);
@b=$h->get_list;
for $a (0..19) {
    ok($b[$a] == $a[$a]);
}


ok($h->err_str !~ /./);
