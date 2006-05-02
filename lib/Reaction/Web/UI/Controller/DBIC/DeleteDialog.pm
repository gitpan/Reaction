package Reaction::Web::UI::Controller::DBIC::DeleteDialog;

use strict;
use warnings;
use Moose;

extends 'Reaction::Web::UI::Controller::Dialog';

sub can_OK { 1 }

sub do_OK {
  my ($self, $c) = @_;
  $self->model->delete;
  $self->handle_close($c);
}

sub can_cancel { 1 }

sub do_cancel {
  my ($self, $c) = @_;
  $self->handle_close($c);
}

1;
