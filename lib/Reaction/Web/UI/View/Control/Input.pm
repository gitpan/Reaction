package Reaction::Web::UI::View::Control::Input;


use Reaction::Class;

extends 'Reaction::Web::UI::View::Control';

has 'type' => (isa => 'Str', is => 'rw', default => 'text');
has 'size' => (isa => 'Int', is => 'rw', default => 25);

sub BUILD {
  my $self = shift;
  $self->{template} = 'control/input';
}

1;
