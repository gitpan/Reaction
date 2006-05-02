package Reaction::Store::DBIC;

use strict;
use warnings;
require Class::C3;

use base qw/DBIx::Class::Schema/;

use Reaction::Store::DBIC::ResultSet;

sub load_classes {
  my $self = shift;
  $self->next::method(@_);
  foreach my $name ($self->sources) {
    $self->source($name)->resultset_class('Reaction::Store::DBIC::ResultSet');
  }
}

1;
