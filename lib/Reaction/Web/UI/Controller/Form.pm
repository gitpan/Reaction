package Reaction::Web::UI::Controller::Form;

use strict;
use warnings;
use Moose;

has 'view' => (is => 'rw');
has 'model' => (is => 'rw');
has 'is_valid' => (is => 'rw');

extends 'Reaction::Web::UI::Controller::Dialog';

before 'handle_request' => sub {
  my ($self, $c) = @_;
  $self->handle_field_events($c);
};

sub handle_field_events {
  my ($self, $c) = @_;
  foreach my $field (@{$self->view->fields}) {
    my $control = $field->control;
    if (defined(my $value = $c->req->params->{$control->id})) {
      $field->control->value($value);
      if ($self->check_constraints_for($field)) {
        $field->message->value('OK');
      }
    }
  }
  $self->check_constraints;
}

sub check_constraints {
  my $self = shift;
  my $fail = 0;
  foreach my $field (@{$self->view->fields}) {
    unless ($self->check_constraints_for($field)) {
      $fail++;
      last;
    }
  }
  $self->is_valid($fail ? 0 : 1);
  $self->view->button('cancel')->value('Cancel');
}

1;
