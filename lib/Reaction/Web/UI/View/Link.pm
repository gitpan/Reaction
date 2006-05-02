package Reaction::Web::UI::View::Link;

use Reaction::Class;

extends 'Reaction::Web::UI::View::Value';

has 'uri' => (isa => 'URI', is => 'ro', writer => 'set_uri');

sub BUILD {
  my $self = shift;
  $self->{template} = 'link';
}

1;
