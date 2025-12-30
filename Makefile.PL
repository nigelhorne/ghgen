use 5.036;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'App::GHGen',
    AUTHOR           => 'Your Name <njh@nigelhorne.com>',
    VERSION_FROM     => 'lib/App/GHGen.pm',
    ABSTRACT_FROM    => 'lib/App/GHGen.pm',
    LICENSE          => 'perl_5',
    MIN_PERL_VERSION => '5.036',
    
    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/yourusername/App-GHGen.git',
                web  => 'https://github.com/yourusername/App-GHGen',
            },
            bugtracker => {
                web => 'https://github.com/yourusername/App-GHGen/issues',
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
        'Test::Exception' => 0,
    },
    
    EXE_FILES => ['bin/ghgen', 'bin/ghgen-analyze', 'bin/ghgen-generator'],
    
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'App-GHGen-*' },
);
