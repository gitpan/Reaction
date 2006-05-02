package Reaction::Web::UI::View::LiveLink;

use Reaction::Class;

extends 'Reaction::Web::UI::View::Link';

has 'controller' => (isa => 'Reaction::Web::UI::PathController', is => 'rw');
has 'model' => (isa => 'Object', is => 'rw');

sub uri_query_params { {} }

sub uri {
  my $self = shift;
  my $c = $self->ctx;
  return $c->uri_for('/',$self->controller->path_prefix($c),
                     $self->model->path_parts, $self->uri_query_params);
}

1;
