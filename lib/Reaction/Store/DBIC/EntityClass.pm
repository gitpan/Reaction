package Reaction::Store::DBIC::EntityClass;

use base qw/DBIx::Class::Componentised/;

sub import {
  my $class = shift;
  my $pkg = caller();
  $class->setup_result_class($pkg);
}

sub setup_result_class {
  my ($class, $target) = @_;
  $class->inject_base($target, 'DBIx::Class');
  $target->load_components(qw/PK::Auto Core/);
  my ($last) = lc((split('::',$target))[-1]);
  $target->table($last);
  {
    no strict 'refs';
    *{"${target}::AutoId"} = sub {
      return (data_type => 'integer', size => 16, is_auto_increment => 1);
    };
    *{"${target}::String"} = sub {
      return (data_type => 'varchar', size => 255);
    };
    *{"${target}::Text"} = sub {
      return (data_type => 'text', size => 65536, control_type => 'TextArea');
    };
    *{"${target}::path_parts"} = sub {
      my $self = shift;
      return ($self->in_storage ? $self->_ident_values : ());
    };
  }
}

1;
