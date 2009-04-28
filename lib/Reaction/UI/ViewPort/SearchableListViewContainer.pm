package Reaction::UI::ViewPort::SearchableListViewContainer;
use Reaction::Class;

#use aliased 'Reaction::InterfaceModel::Search::Spec', 'SearchSpec';
use aliased 'Reaction::InterfaceModel::Action::Search::UpdateSpec', 'UpdateSearchSpec';
use aliased 'Reaction::UI::ViewPort::ListViewWithSearch';
use aliased 'Reaction::UI::ViewPort::Action' => 'ActionVP';
use aliased 'Reaction::UI::ViewPort::Collection::Role::Pager', 'PagerRole';

use Method::Signatures::Simple;

use namespace::clean -except => 'meta';

extends 'Reaction::UI::ViewPort';

has 'listview' => (
    isa => ListViewWithSearch, 
    is => 'ro', 
    required => 1, 
);

has 'search_form' => (isa => ActionVP, is => 'ro', required => 1);

override BUILDARGS => sub {
  my $args = super;
  my $spec_event_id = $args->{location}.':search-spec';
  my $spec_class = $args->{spec_class}
    or confess "Argument spec_class is required";
  my $action_class = $args->{action_class}
    or confess "Argument action_class is required";
#  TODO: how do we autodiscover spec classes?
#  $spec_class =~ s/^::/${\SearchSpec}::/;
  Class::MOP::load_class($spec_class);
  my $spec = do {
    if (my $string = $args->{ctx}->req->query_params->{$spec_event_id}) {
      $spec_class->from_string($string, $args->{spec}||{});
    } else {
      $spec_class->new($args->{spec}||{});
    }
  };
  my $listview_location = $args->{location}.'-listview';
  # should this maybe use the listview class in $args->{listview}?
  my $listview = $args->{listview} = ListViewWithSearch->new(
    %$args,
    layout => 'list_view',
    search_spec => $spec,
    location => $listview_location,
  );
  # same as with listview wrt. class name
  $args->{search_form} = ActionVP->new(
    model => $action_class->new(target_model => $spec),
    location => $args->{location}.'-search_form',
    apply_label => 'search',
    ctx => $args->{ctx},
    on_apply_callback => sub {
      my ($vp, $spec) = @_;
      my $req = $vp->ctx->req;
      my $new_uri = $req->uri->clone;
      my %query = %{$req->query_parameters};
      delete @query{grep /^\Q${listview_location}\E/, keys %query};
      $query{$spec_event_id} = $spec->to_string;
      $new_uri->query_form(\%query);
      $req->uri($new_uri);
      $listview->clear_page;
      $listview->clear_order_by;
    },
    %{$args->{search}||{}}
  );
  $args;
};

override child_event_sinks => method () {
  ((map $self->$_, 'listview', 'search_form'), super);
};

1;
