package Reaction::Web::UI::Controller;

use strict;
use warnings;
use Moose;

has 'view' => (is => 'rw');
has 'model' => (is => 'rw');

sub handle_request {
}

sub handle_close {
  my ($self, $c) = @_;
  $c->res->redirect($c->stash->{next_uri} || $c->uri_for('/'));
}

1;
