#!/usr/bin/perl -w
use strict;

use Blog;
use Plack::Request;
use Plack::Response;

my $app = sub {

    my $env = shift;
    my $req = Plack::Request->new($env);
    my $path = $req->path;

    if ($path =~ /^\/blog$/)
    {
       return [200, ['Content-Type' => 'text/html'], [blog]];
    }

    my $res = Plack::Response->new;
    $res->redirect('/blog');
    $res->finalize;
};
