package Reaction::Web::UI::View::Control::TextArea;

use Reaction::Class;

extends 'Reaction::Web::UI::View::Control';

has 'rows' => (isa => 'Int', is => 'rw', default => 15);
has 'cols' => (isa => 'Int', is => 'rw', default => 50);

sub BUILD {
  my $self = shift;
  $self->{template} = 'control/textarea';
}

1;
