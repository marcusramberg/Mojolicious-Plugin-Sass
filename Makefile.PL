#!/usr/bin/env perl
use 5.010001;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION_FROM => 'lib/Mojolicious/Plugin/Sass.pm',
    NAME         => 'Mojolicious::Plugin::Sass',
    AUTHOR       => 'Nils Diewald',
    PREREQ_PM => {
        'Mojolicious' => 3.43,
	'Text::Sass' => 0.96,
	'CSS::Compressor' => 0.02
    },
    test => {TESTS => 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t'}
);

