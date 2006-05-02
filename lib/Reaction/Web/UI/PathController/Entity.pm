package Reaction::Web::UI::PathController::Entity;

use strict;
use warnings;

use Moose::Role;

override 'setup_model' => sub {
  my ($self, $c) = @_;
  $self->model(
    $c->model($self->model_type)->entity_for_path(@{$c->req->args})
  );
};

after 'focus' => sub {
  my ($self, $c) = @_;
  $c->stash(current_model => $self->model);
};

1;
