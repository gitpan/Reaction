package Reaction::Web::UI::View::ActionLink;

use Reaction::Class;

extends 'Reaction::Web::UI::View::LiveLink';

has 'action' => (isa => 'Str', is => 'rw');

override uri_query_params => sub {
  my $self = shift;
  return { %{super()}, action => $self->action };
};

1;
