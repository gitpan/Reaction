package Reaction::Web::Application;

use Reaction::Class;

use Module::Find ();

extends 'Catalyst';

sub application { return ref($_[0])||$_[0]; }

sub setup_components {
  my $self = shift;
  $self->NEXT::setup_components(@_);
  $self->_shadow_prefix('View');
  $self->_shadow_prefix('Controller');
}

sub _shadow_prefix {
  my ($self, $prefix) = @_;
  my $std_prefix = "Reaction::Web::UI::${prefix}";
  my $app_prefix = $self->application."::${prefix}";
  my @found = Module::Find::findallmod($std_prefix);
  foreach my $found (@found) {
    my $name = $found;
    $name =~ s/$std_prefix/$app_prefix/;
    next if $self->components->{$name};
    eval "use $found";
    die $@ if $@;
    $self->components->{$name} = $found;
  }
}

1;
