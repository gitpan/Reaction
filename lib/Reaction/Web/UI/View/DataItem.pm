package Reaction::Web::UI::View::DataItem;


use Reaction::Class;

extends 'Reaction::Web::UI::View';

has 'model' => (isa => 'Object', is => 'rw');
has 'actions' => (isa => 'ArrayRef', is => 'rw');
has 'action_controller' => (isa => 'Reaction::Web::UI::ActionController', is => 'rw');
has 'column_names' => (isa => 'ArrayRef', is => 'rw');

sub BUILD {
  my $self = shift;
  $self->{template} = 'dataitem';
  $self->setup_actions;
}

sub setup_actions {
  my ($self) = @_;
  my @actions;
  my $c = $self->ctx;
  foreach my $name ($self->action_controller->action_names) {
    my $a = $c->view('ActionLink')->new(
      id => join('-',$self->id,'action',$name),
      action => $name,
      controller => $self->action_controller,
      model => $self->model,
      value => $name,
      ctx => $c
    );
    push(@actions, $a);
  }
  $self->actions(\@actions);
}

1;
