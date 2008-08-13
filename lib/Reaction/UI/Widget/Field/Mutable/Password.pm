package Reaction::UI::Widget::Field::Mutable::Password;

use Reaction::UI::WidgetClass;

use namespace::clean -except => [ qw(meta) ];
extends 'Reaction::UI::Widget::Field::Mutable';



around fragment widget {
  call_next;
  arg field_type => 'password';
  arg field_value => ''; # no sending password to user. really.
};

__PACKAGE__->meta->make_immutable;


1;

__END__;

=head1 NAME

Reaction::UI::Widget::Field::Password

=head1 DESCRIPTION

See L<Reaction::UI::Widget::Field>

=head1 AUTHORS

See L<Reaction::Class> for authors.

=head1 LICENSE

See L<Reaction::Class> for the license.

=cut
