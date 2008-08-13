package Reaction::UI::Widget::Collection;

use Reaction::UI::WidgetClass;

use namespace::clean -except => [ qw(meta) ];


implements fragment members {
  render member => over $_{viewport}->members;
};

implements fragment member {
  render 'viewport';
};

__PACKAGE__->meta->make_immutable;


1;

__END__;

=head1 NAME

Reaction::UI::Widget::Collection

=head1 DESCRIPTION

=head1 FRAGMENTS

=head1 AUTHORS

See L<Reaction::Class> for authors.

=head1 LICENSE

See L<Reaction::Class> for the license.

=cut