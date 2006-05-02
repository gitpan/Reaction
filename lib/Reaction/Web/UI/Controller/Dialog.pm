package Reaction::Web::UI::Controller::Dialog;

use strict;
use warnings;
use Moose;

extends 'Reaction::Web::UI::Controller';

after 'handle_request' => sub {
  my ($self, $c) = @_;
  $self->handle_button_events($c);
};

sub handle_button_events {
  my ($self, $c) = @_;
  $self->view->message->value("");
  foreach my $button (@{$self->view->buttons}) {
    if (exists $c->req->params->{$button->id}) {
      my $ev = $button->name;
      my ($can, $do) = ("can_$ev", "do_$ev");
      if ($self->$can) {
        $self->$do($c);
      } else {
        $self->view->message->value("Could not $ev, please check input");
      }
    }
  }
}

1;
