#!/usr/bin/perl -w
use strict;
use Test::More tests => 1;

use HTML::Template;

my $template = HTML::Template->new(
    filename => "t/resources/foo.tmpl"
);

$template->param(FOO => "BAR");

is($template->output, "BAR\n");
