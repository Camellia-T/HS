package AbilityMgr;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

use lib 'Abilities';
use None;
use TakeOneDamage;
use DealTwoDamage;
use LifeTap;
use DealThreeDamageToAllMinion;

my @attributes = qw/
	field_name
	field_list
	ability_list
	hero_power_list
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

# AbilityMgr クラスはヒーローパワー、スペルアビリティ、
# そしてフィールドアビリティの一元管理機構と提供窓口を持つ。

# アビリティは敵味方両方の保持するデータ全てに適用される可能性が在るため、
# 自分自身と敵対者のPlayerクラスを引数にもらい、効果を適用する。
# プレイヤーが持つヒーローやカードがプレイヤーに影響を及ぼすという
# 処理の循環が生じる可能性があるためアビリティは一元管理していたほうが良いと判断。

# type を表す引数を build で受け取りそれぞれに対応したアビリティクラスを返してやることで
# このクラスを使用するクラスがその中身を意識する必要性を限りなく低くする。

sub build {
	my $self = shift;

	my $fields = {
    	None           => None->build,
    	TakeOneDamage  => TakeOneDamage->build,
	};

	my $abilities = {
    	DealTwoDamage  => DealTwoDamage->build,
    	LifeTap => LifeTap->build,
    	DealThreeDamageToAllMinion => DealThreeDamageToAllMinion->build,
	};

	my $hero_powers = {
    	DealTwoDamage  => DealTwoDamage->build,
    	LifeTap => LifeTap->build,
	};

	return $self->new(+{
		field_name      => "None",
		field_list      => $fields,
		ability_list    => $abilities,
		hero_power_list => $hero_powers,
	});
}

sub play_card {
	my $self = shift;
	my ($hash, $player, $opponent) = @_;

	if($hash->{'has_error'} == 0){
		if($hash->{'type'} eq "Spell"){
			$self->use_ability($hash->{'ability'}, $player, $opponent);
		}elsif($hash->{'type'} eq "Field"){
			$self->use_field($hash->{'ability'}, $player, $opponent);
		}
	}
}

sub set_field {
	my $self = shift;
	my ($name) = @_;

	$self->set_field_name($name);
}

sub get_field {
	my $self = shift;
	my ($name) = @_;

	return $self->get_field_list->{$name};
}

sub use_field {
	my $self = shift;
	my ($player, $opponent) = @_;

	$self->get_field_list->{$self->get_field_name}->manifest_ability($player, $opponent);
}

sub get_ability {
	my $self = shift;
	my ($name) = @_;

	return $self->get_ability_list->{$name};
}

sub use_ability {
	my $self = shift;
	my ($name, $player, $opponent) = @_;

	$self->get_ability_list->{$name}->manifest_ability($player, $opponent);
}

sub get_hero_power {
	my $self = shift;
	my ($name) = @_;

	return $self->get_hero_power_list->{$name};
}

sub use_hero_power {
	my $self = shift;
	my ($name, $player, $opponent) = @_;

	$self->get_hero_power_list->{$name}->manifest_ability($player, $opponent);
}

sub show_content_with_type_and_id {
	my $self = shift;
	my ($type,$name) = @_;

	if($type eq "Spell") {
		$self->get_ability($name)->show_content;
	}elsif($type eq "Field") {
		$self->get_field($name)->show_content;
	}elsif($type eq "HeroPower") {
		$self->get_hero_power($name)->show_content;
	}
}

sub show_field_content {
	my $self = shift;

	$self->get_field($self->get_field_name)->show_content;
}

sub show_hero_power_list {
	my $self = shift;

	my @keylist = keys(%{$self->get_hero_power_list});
	my $keycount = keys(%{$self->get_hero_power_list});
	
	for (my $i = 1; $i <= $keycount; $i++){
	  print "${i}:$keylist[$i - 1] \n";
	}
}

1;