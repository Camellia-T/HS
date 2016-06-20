package Hero;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

#2016/06/15
#ヒーローパワーの実装

my @attributes = qw/
	health
	hero_power
	used_hero_power
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

my $DEFAULT_HEALTH = 30;
my $HERO_POWER_COST = 2;

sub build {
	my $class = shift;

	print "1: DealTwoDamage\n";
	print "2: LifeTap\n";
	print "which hero power do you play? type no \n";
	my $no = <STDIN>;
	chomp $no;

	# 数字チェック
	if ($no !~ /^\d+$/) {
		print "invalid input: ${no} \n";
	}

	# 大きさチェック
	unless ($no > 0 && $no <= 3) {
		print "invalid input: ${no} \n";
	}

	my $name = "";

	if($no == 1){
		$name = "DealTwoDamage";
	}elsif($no == 2){
		$name = "LifeTap";
	}else{
		$name = "DealTwoDamage";
	}

	return $class->new(+{
		health     => $DEFAULT_HEALTH,
		hero_power => $name,
		used_hero_power => 0,
	});
}

sub build_by_hero_power {
	my $class = shift;
	my $name = @_;

	return $class->new(+{
		health     => $DEFAULT_HEALTH,
		hero_power => $name,
		used_hero_power => 0,
	});
}

sub is_alive {
	my $self = shift;
	return $self->get_health > 0 ? 1 : 0;
}

sub add_damage {
	my $self = shift;
	my ($damage) = @_;

	my $new_health = $self->get_health - $damage;
	$self->set_health($new_health);
}

#2016/06/15
#ヒーローパワーの実装

sub refresh_hero_power {
	my $self = shift;
	$self->set_used_hero_power(1);
}

sub can_use_hero_power {
	my $self = shift;
	return $self->get_used_hero_power == 1 ? 1 : 0;
}

sub get_hero_power_cost {
	return $HERO_POWER_COST;
}

#2016/06/16
#内容の出力
sub show_content {
	my $self = shift;
	my $health = $self->get_health;

	print "### Hero ###\n";
	print "health: ${health}.\n";
}

1;