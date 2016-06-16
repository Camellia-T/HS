package Ability;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	name
	ability_context
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

sub build {
	my $self = shift;

	return $self->new(+{
		name     => "Hunter",
		ability_context => "Deal 2 Damage to the enemy hero.",
	});
}

sub manifest_ability {
	my $class = shift;
	my ($player, $opponent) = @_;
	$opponent->hero->add_damage(2);
}

sub show_content {
	my $self = shift;
	my $name = $self->get_name;
	my $context = $self->get_ability_context;
	print "Ability Name: ${name}.\n";
	print "Ability Context :\n ${context}.\n";
}

1;