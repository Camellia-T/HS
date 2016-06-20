package TakeOneDamage;

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
		name     => "Arrow Field",
		context  => "Take 1 Damage to own hero",
	});
}

sub manifest_ability {
	my $self = shift;
	my ($player,$opponent) = @_;
	$player->add_damage(1);
}

sub show_content {
	my $self = shift;
	my $name = $self->get_name;
	my $context = $self->get_context;
	print "Name: ${name}.\n";
	print "Context : ${context}.\n";
}

1;