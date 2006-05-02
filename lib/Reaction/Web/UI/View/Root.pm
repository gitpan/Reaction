package Reaction::Web::UI::View::Root;

use Reaction::Class;

extends 'Reaction::Web::UI::View';

has 'mainpanel' => (isa => 'Reaction::Web::UI::View', is => 'rw',
                    trigger => sub { shift; shift->id('mainpanel'); });
has 'title' => (isa => 'Reaction::Web::UI::View::Value', is => 'rw',
                    trigger => sub { shift; shift->id('title'); });

sub BUILD {
  my $self = shift;
  $self->{template} = 'html';
  $self->build_title unless $self->title;
}

sub build_title {
  my $self = shift;
  my $c = $self->ctx;
  $self->title($c->view('Value')->new(value => $c->config->{name},
                                      ctx => $c));
}

1;
