package Reaction::Store::DBIC::ResultSet;

use strict;
use warnings;
use base qw/DBIx::Class::ResultSet/;

sub entity_for_path {
  my ($self, @path) = @_;
  return (@path ? $self->find(@path) : $self->new({}));
}

1;
