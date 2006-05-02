package Reaction::Web::UI::ActionController;

use strict;
use warnings;

use Moose;

BEGIN { extends 'Reaction::Web::UI::PathController'; }

sub action_names { (shift->default_action); }

sub default_action { confess "Abstract method!" }

sub action_view_base { confess "Abstract method!" }

sub actions { return { map { ($_ => 1) } shift->action_names(@_) }; }

sub handler :Path {
  my ($self, $c) = @_;
  $self->focus($c);
}

sub action_view_type {
  my ($self, $action) = @_;
  return join('::',$self->action_view_base,ucfirst($action));
}

sub view_type {
  my ($self, $c) = @_;
  my $action = ($c->req->query_params->{'action'} ||= $self->default_action);
  if ($self->actions->{$action}) {
    return $c->view($self->action_view_type($action));
  } else {
    confess "Invalid action $action for resource ".$c->req->uri;
  }
}

1;
