#!/usr/bin/perl -w
use strict;
use Test::More tests => 1;

use Plack::Test;
use HTTP::Request::Common;

my $app = sub {
    return [200, [{'Content-Type' => 'text/plain'}], ['Text']];
};

my $test = Plack::Test->create($app);
my $res = $test->request(GET "/");

is($res->content, 'Text');
