package Reaction::Web::UI::View;

use Reaction::Class;

has 'template' => (isa => 'Str', is => 'rw', predicate => 'has_template');
has 'id' => (isa => 'Str', is => 'rw');
has 'ctx' => (is => 'ro', weak_ref => 1);
has 'model' => (is => 'rw');

sub set_id { shift->id(@_); }

sub has_controller { 0; }

sub class { return ref(shift); }

1;
