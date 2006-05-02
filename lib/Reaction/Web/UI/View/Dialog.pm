package Reaction::Web::UI::View::Dialog;

use Reaction::Web::UI::View::Value;

use Reaction::Class;

extends 'Reaction::Web::UI::View';
   with 'Reaction::Web::UI::View::HasController';

has 'buttons' => (isa => 'ArrayRef', is => 'rw');
has 'message' => (isa => 'Reaction::Web::UI::View::Value', is => 'ro',
                  writer => 'set_message');
has 'model' => (isa => 'Object', is => 'rw');

sub BUILD {
  my $self = shift;
  $self->template('dialog');
  $self->setup_buttons($self->button_names);
  $self->setup_message;
}

sub button_names { qw/OK cancel/ }

sub setup_buttons {
  my ($self, @to_setup) = @_;

  my $c = $self->ctx;
  my @buttons;

  foreach my $name (@to_setup) {
    my $button = $c->view('Control::Button')->new(
                   id => join('-',$self->id,'button',$name),
                   name => $name,
                   value => join(' ', map ucfirst, split('_', $name)));
    push(@buttons,$button);
  }
  $self->buttons(\@buttons);
}

sub setup_message {
  my $self = shift;
  my $c = $self->ctx;
  $self->set_message($c->view('Value')->new(
                       id => join('-',$self->id,'message')
                    ));
}

sub button {
  my ($self, $name) = @_;
  return (grep { $_->name eq $name } @{$self->buttons})[0];
}

1;
