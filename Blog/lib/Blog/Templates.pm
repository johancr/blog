package Blog::Templates;

use 5.014;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(
    
);

our $VERSION = '0.01';

use constant BLOG => << '_END_';
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
        <title>Cronsioe blog</title>
        <link href="static/css/main.css" type="text/css" rel="stylesheet"/>
        <link href="static/css/default.css" type="text/css" rel="stylesheet"/>
        <script src="static/js/jquery-1.11.1.min.js"></script>
        <script src="static/js/highlight.pack.js"></script>
        <script>
            $( document ).ready(function() {
                hljs.initHighlightingOnLoad();

                $('section').slice(1).each(function() { 
                    $(this).children().not('h2').hide();
                });

                $('h2').slice(1).each(function() { 
                    $(this).append('<span style=cursor:pointer> [+]</span>'); 
                });

                $('h2 > span').click(function() { 
                    $(this).parent().parent().children().show(); 
                    $(this).remove();
                });
            });
        </script>
    </head>
    <body>
        <div class="container">
            <nav>
            <a href="/blog">Blog</a> |
            <a href="/projects">Projects</a> |
            <a href="/about">About me</a>
            </nav>
            <div id="section-container" class="section-container">
                <TMPL_LOOP NAME="ARTICLES">
                    <section>
                        <TMPL_VAR NAME="ARTICLE">
                    </section>
                </TMPL_LOOP>
            </div>
        </div>
    </body>
</html>
_END_

