package Ability;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	name
	ability_context
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

# アビリティは敵味方両方の保持するデータ全てに適用される可能性が在るため、
# 引数は自分自身と敵対者のPlayerクラスを引数にもらい、効果を適用する。
# プレイヤーが持つヒーローやカードがプレイヤーに影響を及ぼすという
# 処理の循環が生じる可能性があるためアビリティは一元管理していたほうが良いと判断。

# 今回は１つの効果を実現すれば良いため、このクラスで実装しているが、
# これから効果を増やすに当たっては、このクラスをアビリティの管理クラスに据えて
# 効果ごとに以下の関数テンプレートに則ったクラスを量産する。

sub build {
	my $self = shift;

	return $self->new(+{
		name     => "Hunter",
		ability_context => "Deal 2 Damage to the enemy hero",
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
	my $context = $self->get_ability_context;
	print "Ability Name: ${name}.\n";
	print "Ability Context : ${context}.\n";
	print "\n";
}

1;