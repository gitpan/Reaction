package Reaction::Web::UI::ActivityController;

use strict;
use warnings;

use Moose;

BEGIN { extends 'Reaction::Web::UI::PathController'; }

after 'setup' => sub {
  my ($self, $c) = @_;
  $c->stash->{next_uri} = $c->uri_for('/', $self->path_prefix($c));
};

sub handler :Path {
  my ($self, $c) = @_;
  $self->focus($c);
}

1;
