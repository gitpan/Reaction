package Reaction::Class;

use Moose ();

sub import {
  shift;
  &strict::import;
  &warnings::import;
  goto &Moose::import;
}

1;
