package Reaction::Web::UI::View::DataSet;

use Reaction::Class;
use Reaction::Web::UI::View::Value;

extends 'Reaction::Web::UI::View';

has 'model' => (isa => 'Object', is => 'rw');

has 'rows' => (isa => 'ArrayRef', is => 'rw');

has 'headings' => (isa => 'ArrayRef', is => 'rw');

sub BUILD {
  my $self = shift;
  $self->{template} = 'dataset';
  $self->setup_headings;
  $self->setup_rows;
}

sub column_names {
  my $self = shift;
  return [ $self->model->result_source->columns ];
}

sub setup_headings {
  my ($self) = @_;
  my @headings;
  my $i = 0;
  my $c = $self->ctx;
  foreach my $name (@{$self->column_names}) {
    my $h = $c->view('Value')->new(
              id => join('-',$self->id,'heading',$i++),
              ctx => $c,
              value => $name);
    push(@headings, $h);
  }
  $self->headings(\@headings);
}

sub setup_rows {
  my ($self) = @_;
  my $i = 0;
  my $c = $self->ctx;
  $self->model->reset;
  my @rows;
  while (my $o = $self->model->next) {
    my $e = $c->view('DataItem')->new(
              model => $o,
              id => join('-',$self->id,'entry',$i++),
              column_names => $self->column_names,
              action_controller => $self->entity_action_controller,
              ctx => $c,
            );
    push(@rows, $e);
  }
  $self->rows(\@rows);
}

sub entity_action_controller {
  my $self = shift;
  return $self->ctx->controller($self->entity_action_controller_type);
}

sub entity_action_controller_type { confess "Virtual method!" }

1;
