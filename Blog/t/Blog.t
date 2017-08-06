# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Blog.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::More tests => 6;
use POSIX qw(strftime);
BEGIN { use_ok('Blog') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

`rm -rf articles`;
mkdir 'articles';

my @articles = &articles;
is(scalar @articles, 0, 'No articles when directory empty');

my $date = strftime("%Y%m%d", gmtime);
my $title = "$date-A-title.txt";
my $content = "some content";

open(my $fh, '>', "articles/$title");
print $fh $content;
close($fh);

@articles = &articles;
is(scalar @articles, 1, 'Find the one article');

is($articles[0], $title, 
    'Article names should start with date and use dash as separator');

my @articles_param = articles_to_hashes(@articles);
is_deeply(\@articles_param, [{ARTICLE => $content}]);


# Load article
my $article_content = load_article($title);
is($article_content, $content, 'Article content is loaded');

