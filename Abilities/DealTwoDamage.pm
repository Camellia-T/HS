package DealTwoDamage;

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
		name     => "Steady Shot",
		context  => "Deal 2 Damage to the enemy hero",
	});
}

sub manifest_ability {
	my $self = shift;
	my ($player,$opponent) = @_;
	$opponent->add_damage(2);
}

sub show_content {
	my $self = shift;
	my $name = $self->get_name;
	my $context = $self->get_context;
	print "Name: ${name}.\n";
	print "Context : ${context}.\n";
}

1;