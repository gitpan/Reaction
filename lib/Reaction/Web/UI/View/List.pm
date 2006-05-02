package Reaction::Web::UI::View::List;

use Reaction::Class;

extends 'Reaction::Web::UI::View';

has 'heading' => (isa => 'Reaction::Web::UI::View', is => 'rw',
                  trigger => sub {
                    my ($self, $new) = @_;
                    $new->id(join('-',$self->id,'heading'));
                  });

has 'entries' => (isa => 'ArrayRef', is => 'rw');

has 'actions' => (isa => 'ArrayRef', is => 'rw');

sub BUILD {
  my $self = shift;
  $self->{template} = 'list';
  $self->model($self->build_model) unless $self->model;
  $self->heading($self->build_heading) unless $self->heading;
  $self->entries($self->build_entries) unless $self->entries;
  $self->actions($self->build_actions) unless $self->actions;
}

sub order_model_by { [ $_[1]->result_source->primary_columns ]; }

sub model_name { confess "Abstract method!" }

sub build_model {
  my $self = shift;
  my $rs = $self->ctx->model($self->model_name);
  $rs = $rs->search(undef, { order_by => $self->order_model_by($rs) });
  return $rs;
}

sub entry_view_type { confess "Abstract method!" }

sub build_entries {
  my $self = shift;
  my $model = $self->model;
  my $c = $self->ctx;
  my @entries;
  $model->reset;
  my $i = 0;
  while (my $obj = $model->next) {
    push(@entries, $c->view($self->entry_view_type)->new(
                     id => join('-', $self->id, 'entry', $i++),
                     ctx => $c,
                     model => $obj
                   ));
  }
  $self->entries(\@entries);
}

sub action_name_for {
  my ($self, $name) = @_;
  return ucfirst($name);
}

sub build_actions { []; }

sub heading_view_type { 'Value' }

sub heading_value { 'Untitled List' }

sub build_heading {
  my $self = shift;
  $self->heading($self->ctx->view('Value')->new(
                   ctx => $self->ctx,
                   value => $self->heading_value));
}

1;
