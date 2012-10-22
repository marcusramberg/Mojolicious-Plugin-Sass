#!/usr/bin/env perl
use Test::Mojo;
use Test::More tests => 8;
use Mojolicious::Lite;
$|++;
use lib ('../lib', '../../lib');

my $t = Test::Mojo->new;

my $app = $t->app;

$app->plugin('Sass');

my $c = Mojolicious::Controller->new;
$c->app($app);

my $scss = << 'SCSS';
p {
  color: black;
  a {
    color: red;
  }
}
p {
  font-size: 12pt;
}
SCSS

like($c->sass_stylesheet(sub { $scss }), qr/p a /, 'scss stylesheet' );
unlike($c->sass_stylesheet(compress => 1, sub { $scss }),
       qr/\s\s/, 'scss stylesheet (compressed)' );

like($c->render_partial(
  inline => $scss,
  format => 'css',
  handler => 'scss'
), qr/p a /, 'scss handler');


unlike($c->render_partial(
  inline => $scss,
  format => 'css',
  handler => 'scssc'
), qr/\s\s/, 'scssc handler');


my $sass = << 'SASS';
p
 color: black
 a
  color: red
p
 font-size: 12pt
SASS

like($c->sass_stylesheet(type => 'sass', sub { $sass }), qr/p a /, 'sass stylesheet' );
unlike($c->sass_stylesheet(compress => 1, type => 'sass', sub { $sass }),
       qr/\s\s/, 'sass stylesheet (compressed)' );

like($c->render_partial(
  inline => $sass,
  format => 'css',
  handler => 'sass'
), qr/p a /, 'sass handler');


unlike($c->render_partial(
  inline => $sass,
  format => 'css',
  handler => 'sassc'
), qr/\s\s/, 'sassc handler');



__END__
