package Reaction::Web::UI::Controller::DBIC::EditForm;

use strict;
use warnings;
use Moose;

extends 'Reaction::Web::UI::Controller::Form';

sub can_apply { shift->is_valid; }

sub do_apply {
  my ($self, $c) = @_;
  foreach my $field (@{$self->view->fields}) {
    my $name = $field->control->name;
    if ($self->model->can($name)) {
      $self->model->$name($field->control->value);
    }
  }
  if ($self->model->in_storage) {
    $self->model->update;
  } else {
    $self->model->insert;
  }
  $self->view->message->value("Changes saved");
  $self->view->button('cancel')->value('Close');
}

sub check_constraints_for {
  my ($self, $field) = @_;
  unless ($self->model->column_info($field->control->name)->{is_nullable}) {
    unless (length $field->control->value) {
      $field->message->value($field->title->value.' must be provided');
      return 0;
    }
  }
  return 1;
}

sub can_cancel { 1 };

sub do_cancel {
  my ($self, $c) = @_;
  $self->handle_close($c);
}

after 'check_constraints' => sub {
  my $self = shift;
  $self->view->button('cancel')->value('Cancel');
};

1;
