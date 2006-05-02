package Reaction::Web::UI::PathController;

use strict;
use warnings;
use Moose;

has 'model' => (is => 'rw');

BEGIN { extends 'Moose::Object', 'Catalyst::Controller'; }

sub auto :Private {
  my ($self, $c) = @_;
  $self->setup($c);
  return 1;
}                                                                               

sub setup {
  my ($self, $c) = @_;
  $self->setup_model($c);                                                       
}

sub setup_model { }

sub model_type { confess "Abstract method!"; }

sub focus {
  my ($self, $c) = @_;
  $self->setup_view($c);
}

sub setup_view {
  my ($self, $c) = @_;
  my $parent = $self->parent_view($c);
  my $name = $self->attach_view_where($c);
  my $id = join('-',($parent->id ? ($parent->id) : ()), $name);
  my $view_class = $c->view($self->view_type($c));
  my %attrs;
  foreach my $key (keys %{$c->req->query_params}) {
    warn "$key $id";
    if ($key =~ m/${id}\.(.*)$/) {
      my $attr = $1;
      my $accept = "accept_${attr}";
      if ($view_class->can($accept)) {
        $attrs{$attr} = $c->req->query_params->{$key};
      }
    }
  }
  my $view = $view_class->new(
               id => $id,
               ctx => $c,
               model => $self->model,
               %attrs
             );
  $parent->$name($view);
  if ($view->has_controller) {
    $view->register_controller($c);
  }
}

sub parent_view {
  my ($self, $c) = @_;
  return $c->stash->{root_view};
}

sub attach_view_where { "mainpanel" }

1;
