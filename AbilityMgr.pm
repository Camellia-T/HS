package AbilityMgr;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;
use Ability;
use None;

my @attributes = qw/
	field_id
	field_list
	ability_list
	hero_power_list
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

# AbilityMgr クラスはヒーローパワー、スペルアビリティ、
# そしてフィールドアビリティの一元管理機構と提供窓口を持つ。

#Type 0: ミニオン及び効果なしカード
#Type 1: スペルカード
#Type 2: フィールドカード
#Type 3: ヒーローパワー

sub build {
	my $self = shift;

	my @fl = (None->build, Ability->build);
	my @al = (None->build, Ability->build);
	my @hl = (None->build, Ability->build);

	return $self->new(+{
		field_id        => 0,
		field_list      => @fl,
		ability_list    => @al,
		hero_power_list => @hl,
	});
}

sub set_field {
	my $self = shift;
	my ($no) = @_;

	$self->set_field_id($no);
}

sub get_field {
	my $self = shift;

	my @field = $self->get_field_list;
	return $field[$self->get_field_id];
}

sub use_field {
	my $self = shift;
	my ($player, $opponent) = @_;

	my @field = $self->get_field_list;
	$field[$self->get_field_id]->manifest_ability($player, $opponent);
}

sub get_ability {
	my $self = shift;
	my ($no) = @_;

	my @ability = $self->get_ability_list;
	return $ability[$no];
}

sub use_ability {
	my $self = shift;
	my ($no, $player, $opponent) = @_;

	my @ability = $self->get_ability_list;
	$ability[$no]->manifest_ability($player, $opponent);
}

sub get_hero_power {
	my $self = shift;
	my ($no) = @_;

	my @hero_power = $self->get_hero_power_list;
	return $hero_power[$no];
}

sub use_hero_power {
	my $self = shift;
	my ($no, $player, $opponent) = @_;

	my @hero_power = $self->get_hero_power_list;
	$hero_power[$no]->manifest_ability($player, $opponent);
}

sub show_content_with_type_and_id {
	my $self = shift;
	my ($type,$id) = @_;

	if($type eq 1) {
		my @ability = $self->get_ability_list;
		$ability[$id]->show_content;
	}elsif($type eq 2) {
		my @field = $self->get_field_list;
		$field[$id]->show_content;
	}elsif($type eq 3) {
		my @hero_power = $self->get_hero_power_list;
		$hero_power[$id]->show_content;
	}
}

sub show_field_content {
	my $self = shift;
	my $field = $self->get_field;
	$field->show_content;
}

1;