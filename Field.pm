package Field;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	type
	cost
	id
	health
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

sub build_by_conf {
	my $class = shift;
	my ($conf) = @_;

	return $class->new(+{
		type          => $conf->{type} || 0,
		cost          => $conf->{cost},
		id            => $conf->{id},
		health        => 1,
	});

}

sub is_alive {
	my $self = shift;

	return $self->get_health > 0 ? 1 : 0;
}

sub show_content {
	my $self = shift;

	print "type: Field.\n";
	my $cost   = $self->get_cost;
	print "cost: ${cost}.\n";
}

1;