use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	    => 'Heap::Priority',
    'VERSION_FROM'  => 'Priority.pm', # finds $VERSION
    'AUTHOR'        => 'Frank J Wojcik <fwojcik+pri@besh.com>',
    'ABSTRACT_FROM' => 'Priority.pm',
    'PREREQ_PM'     => { 'Heap' => 0.50 },
    
);
