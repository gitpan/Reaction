package Reaction::Web::UI::View::Control::RichText;


use Reaction::Class;

extends 'Reaction::Web::UI::View::Control::TextArea';
   with 'Reaction::Web::UI::View::WithWidget';

sub widget_type { 'Editor' }

sub widget_args { (items => [ qw/textGroup listGroup indentGroup/ ]); }

1;
