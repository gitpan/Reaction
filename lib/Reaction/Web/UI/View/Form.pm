package Reaction::Web::UI::View::Form;

use Reaction::Class;

extends 'Reaction::Web::UI::View::Dialog';

has 'model' => (isa => 'Object', is => 'rw');
has 'fields' => (isa => 'ArrayRef', is => 'rw');

sub field_names { confess "virtual method!"; }

sub BUILD {
  my $self = shift;
  $self->template('form');
  $self->setup_fields($self->field_names);
}

sub setup_fields { # too much magic in here. delegate it.
  my ($self, @to_setup) = @_;
  my @fields;
  my $model = $self->model;
  my $c = $self->ctx;
  foreach my $name (@to_setup) {
    my $field = $c->view('Field')->new(id => join('-',$self->id,'field',$name));
    my $info = $model->column_info($name);
    my $title = join(' ', map ucfirst, split('_', $name));
    $field->set_title($c->view('Value')->new(value => $title));
    $field->set_message($c->view('Value')->new);
    my $control_type = ($info->{control_type}
                          ? join('::', 'Control', $info->{control_type})
                          : 'Control::Input');
    $field->set_control($c->view($control_type)->new(
                          name => $name, value => $model->$name,
                          %{$info->{control_args}||{}}));
    push(@fields, $field);
  }
  $self->fields(\@fields);
}

sub field {
  my ($self, $name) = @_;
  return (grep { $_->control->name eq $name } @{$self->fields})[0];
}

1;
