package Reaction::Web::UI::View::Control::Button;

use Reaction::Class;

extends 'Reaction::Web::UI::View::Control';

sub BUILD {
  my $self = shift;
  $self->{template} = 'button';
}

1;
