######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Heap::Priority;
$loaded = 1;
ok(1);

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

use Test;
use strict;
my ($h, $sv, @av);
$|++;

BEGIN { plan tests => 33 }
use Heap::Priority;
ok(1);

$h = new Heap::Priority;

# test as simple queue, make a basic heap
$h->add($_) for 'a'..'z';

$sv = $h->get_heap;
ok($sv == 26);

@av = $h->get_heap;
ok( 'abcdefghijklmnopqrstuvwxyz' eq join'',@av);

$sv = $h->get_priority_levels;
ok($sv == 1);

@av = $h->get_priority_levels;
ok( '0' eq join'',@av);

$sv = $h->pop();
ok( $sv eq 'a' );

$h->lifo();
$sv = $h->pop();
ok( $sv eq 'z' );

@av = $h->get_heap;
ok( 'yxwvutsrqponmlkjihgfedcb' eq join'',@av );

$h->fifo();

$h->delete_item('f');
@av = $h->get_heap;
ok( 'bcdeghijklmnopqrstuvwxy' eq join'',@av);

$h->add('c',1);
@av = $h->get_heap;
ok( 'cbcdeghijklmnopqrstuvwxy' eq join'',@av);
#$h->modify_priority('c',1);
$h->delete_item('c');
$h->add('c',1);

@av = $h->get_heap;
ok( 'cbdeghijklmnopqrstuvwxy' eq join'',@av);

$sv = $h->get_priority_levels;
ok($sv == 2);

$h->lowest_first;
@av = $h->get_priority_levels;
ok('01' eq join'',@av);

$h->highest_first;
@av = $h->get_priority_levels;
ok('10' eq join'',@av);

$sv = $h->get_level(0);
ok( $sv = 24 );

$sv = $h->get_level(1);
ok( $sv = 1 );

@av = $h->get_level(0);
ok( 'bdeghijklmnopqrstuvwxy' eq join'',@av);

$sv = $h->pop();
ok($sv eq 'c');

$sv = $h->get_priority_levels;
ok($sv == 1);

$h->add('d',1);
$h->add('d');
@av = $h->get_heap;
ok( 'dbdeghijklmnopqrstuvwxyd' eq join'',@av);

$h->delete_item('d',0);
@av = $h->get_heap;
ok( 'dbeghijklmnopqrstuvwxy' eq join'',@av);

$h->add('d',0);
@av = $h->get_heap;
ok( 'dbeghijklmnopqrstuvwxyd' eq join'',@av);

$h->delete_item('d');
@av = $h->get_heap;
ok( 'beghijklmnopqrstuvwxy' eq join'',@av);

$h->add('e',1);
$h->delete_item('e',0);
@av = $h->get_heap;
ok( 'ebghijklmnopqrstuvwxy' eq join'',@av);

$h->delete_priority_level(0);
@av = $h->get_heap;
ok( 'e' eq join'',@av );

$h->delete_item('e');
$sv = $h->get_heap;
ok( $sv == 0 );
@av = $h->get_heap;
ok( ! @av );
$sv = $h->pop();
ok( ! $sv );

# test error messages

$h->add();
ok( $h->err_str eq "Need to supply an item to add to heap!\n" );
$h->reset_err_str;

$h->delete_priority_level(42);
ok( $h->err_str eq "Priority level 42 does not exist in heap!\n");
$h->reset_err_str;

$h->delete_item('non existant');
ok( $h->err_str eq "Item non existant does not exist in heap!\n" );
$h->reset_err_str;

$h->get_level(42);
ok( $h->err_str eq "Priority level 42 does not exist in heap!\n" );
$h->reset_err_str;
