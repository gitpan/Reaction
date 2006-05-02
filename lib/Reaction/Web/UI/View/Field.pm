package Reaction::Web::UI::View::Field;


use Reaction::Class;

extends 'Reaction::Web::UI::View';

has 'title' => (isa => 'Reaction::Web::UI::View::Value', is => 'ro', writer => 'set_title');
has 'control' => (isa => 'Reaction::Web::UI::View::Control', is => 'ro',
                  writer => 'set_control');
has 'message' => (isa => 'Reaction::Web::UI::View::Value', is => 'ro',
                  writer => 'set_message');

after 'set_title' => sub {
  my $self = shift;
  $self->title->set_id(join('-',$self->id,'title'));
};

after 'set_control' => sub {
  my $self = shift;
  $self->control->set_id(join('-',$self->id,'control'));
};

after 'set_message' => sub {
  my $self = shift;
  $self->message->set_id(join('-',$self->id,'message'));
};

1;
