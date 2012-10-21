#!/usr/bin/env perl
use Test::Mojo;
use Test::More tests => 4;
use Mojolicious::Lite;
$|++;
use lib ('../lib', '../../lib');

my $t = Test::Mojo->new;

my $app = $t->app;

$app->plugin('Sass');

my $c = Mojolicious::Controller->new;
$c->app($app);

my $css = << 'CSS';
p {
  color: black;
  a {
    color: red;
  }
}
p {
  font-size: 12pt;
}
CSS

like($c->sass_stylesheet(sub { $css }), qr/p a /, 'sass_stylesheet' );
unlike($c->sass_stylesheet(compress => 1, sub { $css }), qr/\s\s/, 'sass_stylesheet (compressed)' );

like($c->render_partial(
  inline => $css,
  format => 'css',
  handler => 'scss'
), qr/p a /, 'scss handler');


unlike($c->render_partial(
  inline => $css,
  format => 'css',
  handler => 'scssc'
), qr/\s\s/, 'scssc handler');

__END__
