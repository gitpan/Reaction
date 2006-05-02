use strict;
use warnings;
use inc::Module::Install;

name 'Reaction';
all_from 'lib/Reaction.pm';
requires 'Moose' => '0.05';
requires 'Catalyst' => '5.56';
requires 'DBIx::Class' => '0.06002';
requires 'Module::Find' => 0;
requires 'JSON::Syck' => 0;

WriteAll;
