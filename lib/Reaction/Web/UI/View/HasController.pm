package Reaction::Web::UI::View::HasController;

use Moose::Role;

sub has_controller { 1 }

sub controller_type { confess "Abstract method!"; }

sub register_controller {
  my ($self, $c) = @_;
  my $controller_class = $c->controller($self->controller_type($c));
  my $controller = $controller_class->new(
                     model => $self->model,
                     view => $self);
  $c->stash->{controllers}{$self->id} = $controller;
}

1;
