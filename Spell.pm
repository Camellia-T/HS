package Spell;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

#手札破壊の効果が実装される場合を考え health 及び is_alive は残した。

my @attributes = qw/
	type
	cost
	ability
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

sub build_by_conf {
	my $class = shift;
	my ($conf) = @_;

	return $class->new(+{
		type          => $conf->{type} || 0,
		cost          => $conf->{cost},
		ability       => $conf->{ability},
	});

}

sub show_content {
	my $self = shift;

	print "type: Spell.\n";
	my $cost   = $self->get_cost;
	print "cost: ${cost}.\n";
}

1;