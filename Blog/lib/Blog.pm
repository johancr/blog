package Blog;

use 5.014;
use strict;
use warnings;

use POSIX qw(strftime);
use HTML::Template;
use Blog::Templates;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Blog ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
    blog
    projects
    about
    edit
    articles
    articles_to_hashes
    load_article
);

our $VERSION = '0.01';

sub blog {

    my $template = HTML::Template->new(
        scalarref => \Blog::Templates::BLOG
    );

    my @articles = &articles;
    my @hashes = articles_to_hashes(@articles);
    $template->param(ARTICLES => \@hashes);

    $template->output;
}

sub articles {
    opendir my $handle, 'articles' or die 'Couldn\'t open articles';
    my @articles = grep {/\.txt$/} readdir $handle;
    closedir $handle;

    reverse sort @articles;
}

sub articles_to_hashes {

    my @articles = @_;
    my @hashes;

    for (@articles) {
        push @hashes, {ARTICLE => load_article($_)};
    }
    
    @hashes;
}

sub load_article {

    my $article = shift;
    &load_file("articles/$article");
}

sub load_file {

    my $file = shift;
    local $/ = undef;

    open my $handle, '<', $file or die "Could not load $file";
    my $content = <$handle>;
    close $handle;

    return $content;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Blog - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Blog;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Blog, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Johan Cronsioe, E<lt>Johan@apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Johan Cronsioe

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
