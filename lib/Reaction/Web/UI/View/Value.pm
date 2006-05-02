package Reaction::Web::UI::View::Value;


use Reaction::Class;

extends 'Reaction::Web::UI::View';

has 'value' => (isa => 'Value', is => 'rw');

1;
