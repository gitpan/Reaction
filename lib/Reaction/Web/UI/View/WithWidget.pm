package Reaction::Web::UI::View::WithWidget;


use Moose::Role;
use JSON::Syck;

sub widget_type { confess "Abstract method!"; }

sub widget_args { () }

sub decorate {
  my ($self, $data) = @_;
  my $type = $self->widget_type;
  my $id = $self->id;
  my $args = JSON::Syck::Dump({ $self->widget_args });
  return $data.qq!<script type="text/javascript">
  dojo.require("dojo.widget.${type}");
  dojo.widget.fromScript("${type}", ${args}, dojo.byId("${id}"))
</script>\n!;
}

1;
