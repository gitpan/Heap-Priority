#
# This test set is intended to provide complete code coverage
#

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

BEGIN { plan tests => 10505 }
use Heap::Priority;
ok(1);

sub compare_arrays {
    my ($first, $second) = @_;
    return 0 unless @$first == @$second;
    for (my $i = 0; $i < @$first; $i++) {
	return 0 if $first->[$i] ne $second->[$i];
    }
    return 1;
}

sub test_empty {
# 28 tests

#
# Test for empty heap, and all its properties
#

    my ($sv,@av);
    
    $sv = $h->count;
    ok($sv == 0);

    $sv = $h->next_level;
    ok(!defined($sv));

    $sv = $h->next_item;
    ok(!defined($sv));

    @av = $h->get_priority_levels;
    ok(!defined(@av));

    @av = $h->get_list;
    ok(@av == 0);

    @av = $h->get_heap;
    ok(@av == 0);

    @av = $h->get_level(0);
    ok(@av == 0); 
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./); 
    
    @av = $h->get_level(1);
    ok(@av == 0); 
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);

# Deleting items on an empty list should fail
    $sv = $h->err_str;
    ok($sv !~ /./);

    $h->delete_item(1);
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == 0);
    
    $h->delete_item(1,0);
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == 0);
    
    $h->delete_item(1,1);
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == 0);
    
    $h->delete_priority_level(0);
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == 0);
    
    $h->delete_priority_level(1);
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == 0);
}    

sub test_invalid {
# 30 tests

#
# Test invariant error conditions
# (Illegal parameters, etc.)
#
    my ($sv,@av);
    my $save = $h->count;

    $h->add;
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);
    
    $h->add(1,'DEF');
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);

    @av = $h->get_level;
    ok(!defined(@av));
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);

    @av = $h->get_level('ABC');
    ok(!defined(@av));
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);
    
    $h->delete_item;
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);

    $h->delete_item('GHI');
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);

    $h->delete_item(-1,'JKL');
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);

    $h->delete_priority_level;
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);
    
    $h->delete_priority_level('MNO');
    $sv = $h->err_str;
    ok($sv =~ /./);
    $h->reset_err_str;
    $sv = $h->err_str;
    ok($sv !~ /./);
    $sv = $h->count;
    ok($sv == $save);

    my @l = ('A','NNYYZZ',-1,0.9,1.66,3,9,99,999);
    for (@l) {
	$h->raise_error($_);
	$sv = $h->err_str;
	ok($sv =~ /./);
	$h->reset_err_str;
	$sv = $h->err_str;
	ok($sv !~ /./);
	$sv = $h->count;
	ok($sv == $save);
    }

    ok($save == $h->count);
}


# Test heap creation
$h = new Heap::Priority;
ok(defined($h));

# Errors should be silent
$h->raise_error(0);

# Test lack of errors
$sv = $h->err_str;
ok($sv !~ /./);



test_empty();
test_invalid();

#
# Basic test, all items at default priority (0)
#

for my $testcase (0..7) {
    if ($testcase > 3) {
	$h->highest_first;
    } else {
	$h->lowest_first;
    }
    if (($testcase % 4) == 0) {
	$h->fifo;
    } elsif (($testcase % 4) == 1) {
	$h->filo;
    } elsif (($testcase % 4) == 2) {
	$h->lilo;
    } elsif (($testcase % 4) == 3) {
	$h->lifo;
    }

# Add some items, all at default priority
    for (1..10) {
	$h->add($_);
    }
    
# Test lack of errors
    $sv = $h->err_str;
    ok($sv !~ /./);
    
    test_invalid();

    my @answers;
    if (($testcase%2)==0) {
	# fifo
	@answers = (1,2,3,4,5,6,7,8,9,10);
    } else {
	# lifo
	@answers = (10,9,8,7,6,5,4,3,2,1);
    }

    my $count=0; my $okcount=0;
    while(defined($sv = $h->pop)) {
	$count++;
	$okcount++ if ($sv == shift @answers);
	ok($h->count == 10 - $count);
	if ($count < 10) {
	    $sv = $h->next_level;
	    ok($sv == 0);
	    $sv = $h->next_item;
	    ok($sv == $answers[0]);
	    @av = $h->get_priority_levels;
	    ok($av[0] == 0);
	    ok($#av == 0);
	    @av = $h->get_level(0);
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_list;
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_heap;
	    ok(compare_arrays(\@av, \@answers));
	}
    }
    ok($count == 10);
    ok($okcount == $count);

    test_invalid();
    test_empty();
}

#
# Advanced test, all items at default priority (0)
#

for my $testcase (0..7) {
    if ($testcase > 3) {
	$h->highest_first;
    } else {
	$h->lowest_first;
    }
    if (($testcase % 4) == 0) {
	$h->fifo;
    } elsif (($testcase % 4) == 1) {
	$h->filo;
    } elsif (($testcase % 4) == 2) {
	$h->lilo;
    } elsif (($testcase % 4) == 3) {
	$h->lifo;
    }

# Add some items, all at default priority
    for (1..10) {
	$h->add($_);
    }
    
# Test lack of errors
    $sv = $h->err_str;
    ok($sv !~ /./);
    
    test_invalid();

    my @answers;
    if (($testcase%2)==0) {
	# fifo
	@answers = (1,2,3,4,5,6,7,8,9,10);
    } else {
	# lifo
	@answers = (10,9,8,7,6,5,4,3,2,1);
    }

    my $count=0; my $okcount=0;
    while(defined($sv = $h->pop)) {
	$count++;
	$okcount++ if ($sv == shift @answers);
	ok($h->count == 10 - $count);
	if ($count == 3) {
	    if ($testcase > 3) {
		$h->lowest_first;
	    } else {
		$h->highest_first;
	    }
	}
	if ($count == 5) {
	    $h->delete_item(999);
	    $sv = $h->err_str;
	    ok($sv =~ /./);
	    $h->reset_err_str;
	    $sv = $h->err_str;
	    ok($sv !~ /./);
	    ok($h->count == 10 - $count);
	}
	if ($count == 6) {
	    $h->delete_item(999,0);
	    $sv = $h->err_str;
	    ok($sv =~ /./);
	    $h->reset_err_str;
	    $sv = $h->err_str;
	    ok($sv !~ /./);
	    ok($h->count == 10 - $count);
	}
	if ($count == 7) {
	    $h->delete_item($answers[0],0);
	    shift @answers;
	    $count++; $okcount++;
	}
	if ($count == 8) {
	    $h->delete_item($answers[0]);
	    shift @answers;
	    $count++; $okcount++;
	}
	if ($count == 9) {
	    $h->delete_priority_level(0);
	    shift @answers;
	    $count++; $okcount++;
	    test_empty();
	    last;
	}
	if ($count < 10) {
	    $sv = $h->next_level;
	    ok($sv == 0);
	    $sv = $h->next_item;
	    ok($sv == $answers[0]);
	    @av = $h->get_priority_levels;
	    ok($av[0] == 0);
	    ok($#av == 0);
	    @av = $h->get_level(0);
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_list;
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_heap;
	    ok(compare_arrays(\@av, \@answers));
	}
    }
    ok($count == 10);
    ok($okcount == $count);

    test_invalid();
    test_empty();
}

#
# Basic test, all items at constant priority
#

my $k = int(sqrt(9.9+(1/3))*1000000000)/1000000000;
for my $testcase (0..7) {
    if ($testcase > 3) {
	$h->highest_first;
    } else {
	$h->lowest_first;
    }
    if (($testcase % 4) == 0) {
	$h->fifo;
    } elsif (($testcase % 4) == 1) {
	$h->filo;
    } elsif (($testcase % 4) == 2) {
	$h->lilo;
    } elsif (($testcase % 4) == 3) {
	$h->lifo;
    }

    
    for (1..10) {
	$h->add($_,$k);
    }
    
# Test lack of errors
    $sv = $h->err_str;
    ok($sv !~ /./);
    
    test_invalid();

    my @answers;
    if (($testcase%2)==0) {
	# fifo
	@answers = (1,2,3,4,5,6,7,8,9,10);
    } else {
	# lifo
	@answers = (10,9,8,7,6,5,4,3,2,1);
    }

    my $count=0; my $okcount=0;
    while(defined($sv = $h->pop)) {
	$count++;
	$okcount++ if ($sv == shift @answers);
	ok($h->count == 10 - $count);
	if ($count < 10) {
	    $sv = $h->next_level;
	    ok($sv == $k);
	    $sv = $h->next_item;
	    ok($sv == $answers[0]);
	    @av = $h->get_priority_levels;
	    ok($av[0] == $k);
	    ok($#av == 0);
	    @av = $h->get_level($k);
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_list;
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_heap;
	    ok(compare_arrays(\@av, \@answers));
	}
    }
    ok($count == 10);
    ok($okcount == $count);

    test_invalid();
    test_empty();
}

#
# Advanced test, all items at constant priority
#

for my $testcase (0..7) {
    if ($testcase > 3) {
	$h->highest_first;
    } else {
	$h->lowest_first;
    }
    if (($testcase % 4) == 0) {
	$h->fifo;
    } elsif (($testcase % 4) == 1) {
	$h->filo;
    } elsif (($testcase % 4) == 2) {
	$h->lilo;
    } elsif (($testcase % 4) == 3) {
	$h->lifo;
    }

    
    for (1..10) {
	$h->add($_,$k);
    }
    
# Test lack of errors
    $sv = $h->err_str;
    ok($sv !~ /./);
    
    test_invalid();

    my @answers;
    if (($testcase%2)==0) {
	# fifo
	@answers = (1,2,3,4,5,6,7,8,9,10);
    } else {
	# lifo
	@answers = (10,9,8,7,6,5,4,3,2,1);
    }

    my $count=0; my $okcount=0;
    while(defined($sv = $h->pop)) {
	$count++;
	$okcount++ if ($sv == shift @answers);
	ok($h->count == 10 - $count);
	if ($count == 3) {
	    if ($testcase > 3) {
		$h->lowest_first;
	    } else {
		$h->highest_first;
	    }
	}
	if ($count == 5) {
	    $h->delete_item(999);
	    $sv = $h->err_str;
	    ok($sv =~ /./);
	    $h->reset_err_str;
	    $sv = $h->err_str;
	    ok($sv !~ /./);
	    ok($h->count == 10 - $count);
	}
	if ($count == 6) {
	    $h->delete_item(999,0);
	    $sv = $h->err_str;
	    ok($sv =~ /./);
	    $h->reset_err_str;
	    $sv = $h->err_str;
	    ok($sv !~ /./);
	    ok($h->count == 10 - $count);
	}
	if ($count == 7) {
	    $h->delete_item($answers[0],$k);
	    shift @answers;
	    $count++; $okcount++;
	}
	if ($count == 8) {
	    $h->delete_item($answers[0]);
	    shift @answers;
	    $count++; $okcount++;
	}
	if ($count == 9) {
	    $h->delete_priority_level($k);
	    shift @answers;
	    $count++; $okcount++;
	    test_empty();
	    last;
	}
	if ($count < 10) {
	    $sv = $h->next_level;
	    ok($sv == $k);
	    $sv = $h->next_item;
	    ok($sv == $answers[0]);
	    @av = $h->get_priority_levels;
	    ok($av[0] == $k);
	    ok($#av == 0);
	    @av = $h->get_level($k);
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_list;
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_heap;
	    ok(compare_arrays(\@av, \@answers));
	}
    }
    ok($count == 10);
    ok($okcount == $count);
    test_invalid();
    test_empty();
}


#
# Basic test, all items at their own priority
#

for my $testcase (0..7) {
    if ($testcase > 3) {
	$h->highest_first;
    } else {
	$h->lowest_first;
    }
    if (($testcase % 4) == 0) {
	$h->fifo;
    } elsif (($testcase % 4) == 1) {
	$h->filo;
    } elsif (($testcase % 4) == 2) {
	$h->lilo;
    } elsif (($testcase % 4) == 3) {
	$h->lifo;
    }

    for (1..10) {
	$h->add($_,$_);
    }
    
# Test lack of errors
    $sv = $h->err_str;
    ok($sv !~ /./);
    
    test_invalid();

    my @answers;
    if ($testcase > 3) {
	# highest first
	@answers = (10,9,8,7,6,5,4,3,2,1);
    } else {
	# lowest first
	@answers = (1,2,3,4,5,6,7,8,9,10);
    }

    my $count=0; my $okcount=0;
    while(defined($sv = $h->pop)) {
	$count++;
	$okcount++ if ($sv == shift @answers);
	ok($h->count == 10 - $count);
	if ($count < 10) {
	    $sv = $h->next_level;
	    ok($sv == $answers[0]);
	    $sv = $h->next_item;
	    ok($sv == $answers[0]);
	    @av = $h->get_priority_levels;
	    ok(@av == 10 - $count);
	    @av = $h->get_list;
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_heap;
	    ok(compare_arrays(\@av, \@answers));
	}
    }
    ok($count == 10);
    ok($okcount == $count);

    test_invalid();
    test_empty();
}

#
# Advanced test, all items at their own priority
#

for my $testcase (0..7) {
    if ($testcase > 3) {
	$h->highest_first;
    } else {
	$h->lowest_first;
    }
    if (($testcase % 4) == 0) {
	$h->fifo;
    } elsif (($testcase % 4) == 1) {
	$h->filo;
    } elsif (($testcase % 4) == 2) {
	$h->lilo;
    } elsif (($testcase % 4) == 3) {
	$h->lifo;
    }

    for (1..10) {
	$h->add($_,$_);
    }
    
# Test lack of errors
    $sv = $h->err_str;
    ok($sv !~ /./);
    
    test_invalid();

    my @answers;
    if ($testcase > 3) {
	# highest first
	@answers = (10,9,8,7,6,5,4,3,2,1);
    } else {
	# lowest first
	@answers = (1,2,3,4,5,6,7,8,9,10);
    }

    my $count=0; my $okcount=0;
    while(defined($sv = $h->pop)) {
	$count++;
	$okcount++ if ($sv == shift @answers);
	ok($h->count == 10 - $count);
	if ($count == 1) {
	    $h->delete_priority_level($answers[-1]);
	    pop @answers;
	    $count++; $okcount++;
	}
	if ($count == 3) {
	    if ($testcase > 3) {
		$h->lowest_first;
		@answers = reverse @answers;
	    } else {
		$h->highest_first;
		@answers = reverse @answers;
	    }
	}
	if ($count == 5) {
	    $h->delete_item(999);
	    $sv = $h->err_str;
	    ok($sv =~ /./);
	    $h->reset_err_str;
	    $sv = $h->err_str;
	    ok($sv !~ /./);
	    ok($h->count == 10 - $count);
	}
	if ($count == 6) {
	    $h->delete_item(999,0);
	    $sv = $h->err_str;
	    ok($sv =~ /./);
	    $h->reset_err_str;
	    $sv = $h->err_str;
	    ok($sv !~ /./);
	    ok($h->count == 10 - $count);
	}
	if ($count == 7) {
	    $h->delete_item($answers[0],$answers[0]);
	    shift @answers;
	    $count++; $okcount++;
	}
	if ($count == 8) {
	    $h->delete_item($answers[0]);
	    shift @answers;
	    $count++; $okcount++;
	}
	if ($count == 9) {
	    $h->delete_priority_level($answers[0]);
	    shift @answers;
	    $count++; $okcount++;	    
	    test_empty();
	    last;
	}
	if ($count < 10) {
	    $sv = $h->next_level;
	    ok($sv == $answers[0]);
	    $sv = $h->next_item;
	    ok($sv == $answers[0]);
	    @av = $h->get_priority_levels;
	    ok(@av == 10 - $count);
	    @av = $h->get_list;
	    ok(compare_arrays(\@av, \@answers));
	    @av = $h->get_heap;
	    ok(compare_arrays(\@av, \@answers));
	}
    }
    ok($count == 10);
    ok($okcount == $count);

    test_invalid();
    test_empty();
}
