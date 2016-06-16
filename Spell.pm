package Spell;

use strict;
use warnings;

use Ability;

use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	cost
	spell
	health
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

sub build_by_conf {
	my $class = shift;
	my ($conf) = @_;

	my $spell = Ability->build;

	return $class->new(+{
		cost          => $conf->{cost},
		spell         => $spell,
		health        => 1,
	});

}

sub is_alive {
	my $self = shift;

	return $self->get_health > 0 ? 1 : 0;
}

sub is_spell {
	my $self = shift;

	return 1;
}

sub use_spell {
	my $self = shift;
	my ($player, $opponent) = @_;

	#ここでアビリティ使用
	$self->get_spell->manifest_ability($player, $opponent);
}

sub show_content {
	my $self = shift;

	print "type: Spell.\n";
	my $cost   = $self->get_cost;
	print "cost: ${cost}.\n";
	$self->get_spell->show_content;
	
}

1;