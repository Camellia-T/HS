package Card;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

#2016/06/14
##add provocation
##add divine_shield

my @attributes = qw/
	cost
	attack
	health
	charge
	provocation
	divine_shield
	is_attacked
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

#2016/06/14
#add provocation
#add divine_shield

sub build_by_conf {
	my $class = shift;
	my ($conf) = @_;

	return $class->new(+{
		cost          => $conf->{cost},
		attack        => $conf->{attack},
		health        => $conf->{health},
		charge        => $conf->{charge} || 0,
		provocation   => $conf->{provocation} || 0,
		divine_shield => $conf->{divine_shield} || 0,
		is_attacked   => 0,
	});

}

sub is_alive {
	my $self = shift;

	return $self->get_health > 0 ? 1 : 0;
}

sub set_attacked {
	my $self = shift;

	$self->set_is_attacked(1);
}

sub set_no_attacked {
	my $self = shift;

	$self->set_is_attacked(0);
}

sub has_charge {
	my $self = shift;

	$self->get_charge ? 1 : 0;
}

#2016/06/14
#add has_provocation function

sub has_provocation {
	my $self = shift;

	$self->get_provocation ? 1 : 0;
}

#2016/06/14
#add has_divine_shield function

sub has_divine_shield {
	my $self = shift;

	$self->get_divine_shield ? 1 : 0;
}

sub add_damage {
	my $self = shift;
	my ($damage) = @_;

	if($self->has_divine_shield){
		$self->set_divine_shield(0);
	}else{
		my $new_health = $self->get_health - $damage;
		$self->set_health($new_health);
	}
}

sub can_attack {
	my $self = shift;

	return $self->get_is_attacked ? 0 : 1;
}

#2016/06/14
#カード自体が情報を開示出来る方が良し。
sub show_content {
	my $self = shift;

	my $cost   = $self->get_cost;
	my $attack = $self->get_attack;
	my $health = $self->get_health;
	my $has_charge = $self->has_charge;
	my $has_provocation = $self->has_provocation;
	my $has_divine_shield = $self->has_divine_shield;

	print "cost: ${cost}.\n";
	print "attack: ${attack}.\n";
	print "health: ${health}.\n";
	if ($has_charge) {
		print "has charge.\n";
	}
	if ($has_provocation) {
		print "has provocation.\n";
	}
	if ($has_divine_shield) {
		print "has divine shield.\n";
	}
}

1;