package Player;

use strict;
use warnings;

use Hero;
use Deck;
use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	name
	used_mana
	max_mana
	hero
	deck
	hand
	field
	is_turn
	is_turn_initialized
	abilityMgr
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

my $DEFAULT_MANA   = 0;
my $INIT_HAND_NUM  = 3;
my $LIMIT_MAX_MANA_NUM = 10;
my $NO_DECK_DAMAGE = 1;
my $MAX_HAND_NUM   = 10;
my $MAX_FIELD_NUM  = 7;

sub build_by_player_name {
	my $class = shift;
	my ($name,$amgr) = @_;

	my $hero = Hero->build;
	my $deck = Deck->build;

	return $class->new(+{
		name      => $name,
		used_mana => 0,
		max_mana  => $DEFAULT_MANA,
		hero      => $hero,
		deck      => $deck,
		hand      => +[],
		field     => +[],
		is_turn   => 0,
		is_turn_initialized => 0, # turnごとのinitialize
		abilityMgr => $amgr,
	});

}

sub initialize {
	my $self = shift;

	# 手札を3枚つける
	for my $no (1 .. $INIT_HAND_NUM) {
		$self->draw_card;
	}
}

sub turn_initialize {
	my $self = shift;
	my (%options) = @_;

	$self->draw_card unless ($options{no_draw});
	$self->increment_max_mana;
	$self->reset_mana;
	$self->set_field_card_attackable;
	$self->set_is_turn_initialized(1);

	#2016/6/15
	#add hero power system
	$self->get_hero->refresh_hero_power;
}

sub is_turn {
	my $self = shift;

	return $self->get_is_turn ? 1 : 0;
}

sub is_turn_initialized {
	my $self = shift;

	return $self->get_is_turn_initialized ? 1 : 0;
}

sub turn_start {
	my $self = shift;

	$self->set_is_turn(1);
	$self->set_is_turn_initialized(0);
}

sub turn_end {
	my $self = shift;

	$self->set_is_turn(0);
}

#2016/06/14 
#ここ手札がMAX_HAND_NUMに到達している時、手札引いたら結局手札増えてました。
#MAX_HAND_NUM + 1 枚まで手札に加えられるようになってました。
#修正済

sub draw_card {
	my $self = shift;

	# deckがないときはダメージ
	if ($self->get_deck->deck_num == 0) {
		$self->add_damage($NO_DECK_DAMAGE);
		return;
	}

	# handが多すぎるときはhandに加えず消去
	if ($self->hand_num >= $MAX_HAND_NUM) {
		$self->get_deck->draw_card;
	}else{
		# handに加える
		push (@{$self->get_hand}, $self->get_deck->draw_card);
	}
}

# 2016/06/14 
# 召喚しようとしたカードのコストが利用可能マナを超えていた場合、カードが消失してました。
# 修正済

# 2016/06/17
# 呪文効果適用のため、引数に敵対者のPlayerクラス渡すよう変更。
sub play_card_by_no {
	my $self = shift;
	my ($no, $opponent) = @_;

	# no - 1 番目から 1枚取る
	my $played_card = splice(@{$self->get_hand}, $no - 1, 1);

	#マナが足りるかチェック
	if ($played_card->get_cost > $self->usable_mana) {
		splice(@{$self->get_hand}, $no - 1, 0, $played_card);
		return +{
			has_error => 1,
			message   => "not enough mana",
		};
	}

	#呪文ならば使用
	if ($played_card->get_type eq 1) {
		$self->use_mana_by_cost($played_card->get_cost);
		$self->get_abilityMgr->use_ability($played_card->get_id,$self, $opponent);

		return +{
			has_error => 0,
		};

	#フィールド魔法ならばアビリティマネジャーにセット
	}elsif($played_card->get_type eq 2) {
		$self->use_mana_by_cost($played_card->get_cost);
		$self->get_abilityMgr->set_field($played_card->get_id);

		return +{
			has_error => 0,
		};
	}

	# ミニオンならば field が一杯かチェック
	return +{
		has_error => 1,
		message   => "too much card on field",
	} unless ($self->field_num <= $MAX_FIELD_NUM);

	$played_card->set_attacked unless ($played_card->has_charge);

	# mana使う
	$self->use_mana_by_cost($played_card->get_cost);

	push (@{$self->get_field}, $played_card);

	return +{
		has_error => 0,
	};
}

# popはしない！！名前が微妙？？
sub pick_field_card_by_no {
	my $self = shift;
	my ($no) = @_;

	return $self->get_field->[$no - 1];
}

sub add_damage {
	my $self = shift;
	my ($damage) = @_;

	$self->get_hero->add_damage($damage);
}

sub surrender {
	my $self = shift;

	my $damage = $self->get_hero->get_health;
	$self->add_damage($damage);
}

sub usable_mana {
	my $self = shift;

	return $self->get_max_mana - $self->get_used_mana;
}

sub use_mana_by_cost {
	my $self = shift;
	my ($cost) = @_;

	my $next_used_mana = $self->get_used_mana + $cost;
	$self->set_used_mana($next_used_mana);
}

sub reset_mana {
	my $self = shift;

	$self->set_used_mana(0);
}

sub increment_max_mana {
	my $self = shift;

	return if ($self->get_max_mana == $LIMIT_MAX_MANA_NUM);

	my $next_max_mana = $self->get_max_mana + 1;
	$self->set_max_mana($next_max_mana);
}

sub cleanup_field {
	my $self = shift;

	my $cleanuped_field = $self->field_list;
	$self->set_field($cleanuped_field);
}

sub set_field_card_attackable {
	my $self = shift;

	for my $card (@{$self->field_list}) {
		$card->set_no_attacked;
	}
}

sub can_attack {
	my $self = shift;

	return (scalar @{$self->attackable_card_list} > 0) ? 1 : 0
}

sub can_play {
	my $self = shift;

	return (scalar @{$self->playable_card_list} > 0) ? 1 : 0
}

#2016/06/14 
#add provocation system

sub can_provoke {
	my $self = shift;

	return (scalar @{$self->provocation_card_list} > 0) ? 1 : 0
}

sub get_hero_health {
	my $self = shift;

	return $self->get_hero->get_health;
}

sub is_alive {
	my $self = shift;

	return $self->get_hero->get_health > 0 ? 1 : 0;
}

sub attackable_card_list {
	my $self = shift;

	return +[ grep { $_->can_attack } @{$self->field_list} ];
}

#2016/06/14 
#add provocation system

sub provocation_card_list {
	my $self = shift;

	return +[ grep { $_->has_provocation } @{$self->field_list} ];
}

sub playable_card_list {
	my $self = shift;

	return +[ grep { $_->get_cost <= $self->usable_mana } @{$self->hand_list} ];
}

sub field_list {
	my $self = shift;

	return +[ grep { $_->is_alive } @{$self->get_field}];
}

sub hand_list {
	my $self = shift;

	return +[ grep { $_->is_alive } @{$self->get_hand}];
}

sub hand_num {
	my $self = shift;

	return scalar @{$self->get_hand};
}

sub field_num {
	my $self = shift;

	return scalar @{$self->get_field};
}

#2016/06/15
#add hero power system

sub can_use_hero_power {
	my $self = shift;
	return $self->get_hero->can_use_hero_power && $self->get_hero->get_hero_power_cost <= $self->usable_mana;
}

sub use_hero_power {
	my $self = shift;
	my ($opponent) = @_;
	if ($self->can_use_hero_power) {
		print "Hero used hero power.\n";
		$self->use_mana_by_cost($self->get_hero->get_hero_power_cost);
		$self->get_abilityMgr->use_hero_power($self->get_hero->get_hero_power, $self, $opponent);
	}else{
		print "Hero couldn't use hero power.\n";
	}
	
}

sub show_content {
	my $self = shift;
	my ($no_hand_information) = @_;

	my $player_name = $self->get_name;
	print "### ${player_name}\'s information ###\n";

	# mana
	my $usable_mana = $self->usable_mana;
	my $max_mana     = $self->get_max_mana;
	print "mana ${usable_mana} / ${max_mana} .\n";
	print "\n";

	$self->get_hero->show_content;
	$self->get_abilityMgr->show_content_with_type_and_id(3, $self->get_hero->get_hero_power);
	print "\n";

	my $no = 1;
	unless ($no_hand_information) {
		print "### hand ###\n";
		for my $hand_card (@{$self->get_hand}) {
			print "===.\n";
			print "no: ${no}.\n";
			$hand_card->show_content;
			$self->get_abilityMgr->show_content_with_type_and_id($hand_card->get_type, $hand_card->get_id);

			$no++;
		}
		print "\n";
	}

	print "### field ###\n";
	print "field ability:\n";
	$self->get_abilityMgr->show_field_content;

	$no = 1;
	for my $field (@{$self->get_field}) {
		print "===.\n";
		print "no: ${no}.\n";
		$field->show_content;
		

		$no++;
	}
	print "\n";
}

1;