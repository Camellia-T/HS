package DealThreeDamageToAllMinion;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	name
	context
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

sub build {
	my $self = shift;

	return $self->new(+{
		name     => "Inferno",
		context  => "Deal 3 Damage to all minions on field",
	});
}

sub manifest_ability {
	my $self = shift;
	my ($player,$opponent) = @_;
	
	for my $card (@{$player->field_list}) {
		$card->add_damage(3);
	}

	for my $card (@{$opponent->field_list}) {
		$card->add_damage(3);
	}

	$player->cleanup_field;
	$opponent->cleanup_field;

}

sub show_content {
	my $self = shift;
	my $name = $self->get_name;
	my $context = $self->get_context;
	print "Name: ${name}.\n";
	print "Context : ${context}.\n";
}

1;