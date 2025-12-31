use 5.036;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'App::GHGen',
    AUTHOR           => 'Nigel Horne <njh@nigelhorne.com>',
    VERSION_FROM     => 'lib/App/GHGen.pm',
    ABSTRACT_FROM    => 'lib/App/GHGen.pm',
	((defined($ExtUtils::MakeMaker::VERSION) && ($ExtUtils::MakeMaker::VERSION >= 6.3002))
		? ('LICENSE'=> 'GPL')
		: ()),
    MIN_PERL_VERSION => '5.036',
    
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/nigelhorne/App-GHGen.git',
                web  => 'https://github.com/nigelhorne/App-GHGen',
            },
            bugtracker => {
                web => 'https://github.com/nigelhorne/App-GHGen/issues',
            },
        },
    },
    
    PREREQ_PM => {
        'YAML::XS'         => 0,
        'Path::Tiny'       => 0,
        'Term::ANSIColor'  => 0,
        'Getopt::Long'     => 0,
    },
    
    TEST_REQUIRES => {
        'Test::More'      => '0.98',
	'Test::DescribeMe' => 0,
        'Test::Exception' => 0,
    },
    
    # EXE_FILES => ['bin/ghgen', 'bin/ghgen-analyze', 'bin/ghgen-generator'],
    EXE_FILES => ['bin/ghgen'],
    
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-GHGen-*' },
);
