package Reaction::Web::UI::View::PagedList;

use Reaction::Class;

extends 'Reaction::Web::UI::View::List';

has 'current_page' => (isa => 'Int', is => 'rw', default => 1);

sub accept_current_page {
  my ($self, $page) = @_;
  $self->current_page($page);
  $self->model($self->build_model);
  $self->entries($self->build_entries);
  $self->actions($self->build_actions);
}

sub rows_per_page { 30; }

sub model_name { confess "Abstract method!" }

override 'build_model' => sub {
  my $self = shift;
  my $rs = super()->search(undef, {
           rows => $self->rows_per_page,
           page => $self->current_page
         });
};

override 'build_actions' => sub {
  my $self = shift;
  my $pager = $self->model->pager;
  my $c = $self->ctx;
  my @actions = @{super()};
  if (my $p = $pager->previous_page) {
    push(@actions, $self->build_pager_action('previous' => $p));
  }
  if (my $p = $pager->next_page) {
    push(@actions, $self->build_pager_action('next' => $p));
  }
  return \@actions;
};

sub build_pager_action {
  my ($self, $name, $page) = @_;
  my $c = $self->ctx;
  my $action_uri = $c->req->uri_with({
                     join('.',$self->id,'current_page') => $page
                   });
  return $c->view('Link')->new(
           id => join('-', $self->id, 'action', $name),
           uri => $action_uri,
           value => $self->action_name_for($name)
         );
}

1;
