package Reaction::Web::UI::InterfaceController;

use Reaction::Class;

BEGIN { extends qw/Reaction::Web::UI::ActivityController
                   Catalyst::Plugin::DefaultEnd/; }

sub root_view_type { 'Root' }

sub begin :Private {
  my ($self, $c) = @_;
  $c->stash(controllers => {});
  $c->stash(template => 'entrypoint');
  $c->stash(root_view => $c->view($self->root_view_type)->new(ctx => $c));
}

sub end :Private {
  my ($self, $c) = @_;
  if ($c->req->method eq 'POST') {
    foreach my $controller (values %{$c->stash->{controllers}}) {
      $controller->handle_request($c);
    }
  }
  my @uri_path;
  if (my $model = $c->stash->{current_model}) {
    @uri_path = $model->path_parts;
  }
  my $uri = $c->uri_for( '/', $c->controller->path_prefix($c),
                         @uri_path, $c->req->query_params );
  $c->stash(current_uri => $uri);
  $self->NEXT::end($c);
}

1;
