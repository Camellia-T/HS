use strict;
use warnings;

use Player;
use AbilityMgr;

my $abilityMgr = AbilityMgr->build;


print "Welcome to HS.\n";
print "Enter Player 1 name.\n";
my $player1_name = <STDIN>;
chomp $player1_name;
my $player1 = Player->build_by_player_name($player1_name,$abilityMgr);
$player1->initialize;

print "Enter Player 2 name.\n";
my $player2_name = <STDIN>;
chomp $player2_name;
my $player2 = Player->build_by_player_name($player2_name,$abilityMgr);
$player2->initialize;

$player1->turn_start;
$player1->turn_initialize(no_draw => 1);

while (1) {
	my $player;
	my $opponent;
	if ($player1->is_turn) {
		$player   = $player1;
		$opponent = $player2;
	} else {
		$player   = $player2;
		$opponent = $player1;
	}

	my $player_name = $player->get_name;
	print "${player_name}\'s turn.\n";

	# turn毎のinitializeしとく
	unless ($player->is_turn_initialized) {
		$player->turn_initialize;
		#ターンの最初にフィールド効果を適用（今は）
		$abilityMgr->use_field($player,$opponent);
	}

	

	print "tell me your choice.\n";
	my $command = <STDIN>;
	chomp $command;

	if ($command eq 'attack') {
		attack($player, $opponent);
	} elsif ($command eq 'play') {
		play($player,$opponent);
	} elsif ($command eq 'surrender') {
		$player->surrender;
	} elsif ($command eq 'end') {
		$player->turn_end;
		$opponent->turn_start;
	} elsif ($command eq 'list') {
		dump_information_by_player($player);
		dump_information_by_player($opponent, no_hand_information => 1);
	} elsif ($command eq 'clear') {
		for (1 .. 100) {
			print "\n";
		}
	#2016/06/15
	#ヒーローパワーの実装	
	} elsif ($command eq 'hp') {
		$player->use_hero_power($opponent);
	} else {
		print "attack: attack by your field card.\n";
		print "play: play by your hand.\n";
		print "surrender: you are loser!\n";
		print "end: end your turn \n";
		print "list: display information\n";
		print "clear: cleanup console\n";
	}

	# 両方生きてないと試合終了
	unless ($player->is_alive && $opponent->is_alive) {
		last;
	}
		print "\n\n\n";
}

if ($player1->is_alive) {
	my $player_name = $player1->get_name;
	print "${player_name} is win. \n";
} else {
	my $player_name = $player2->get_name;
	print "${player_name} is win. \n";
}

sub play {
	my ($player, $opponent) = @_;

	unless ($player->can_play) {
		print "no playable card you have! \n";
		return;
	}

	print "which card do you play? type no \n";
	my $no = <STDIN>;
	chomp $no;

	# 数字チェック
	if ($no !~ /^\d+$/) {
		print "invalid input: ${no} \n";
		return;
	}

	# 大きさチェック
	unless ($no > 0 && $no <= $player->hand_num) {
		print "invalid input: ${no} \n";
		return;
	}

	my $hash = $player->play_card_by_no($no, $opponent);
	$abilityMgr->play_card($hash, $player, $opponent);
	if ($hash->{has_error}) {
		print $hash->{message};
		print "\n";
	}
}

#2016/06/14 
#hoge, fugaという不必要な変数
#修正済

sub attack {
	my ($player, $opponent) = @_;

	unless ($player->can_attack) {
		print "no attackable card you have! \n";
		return;
	}

	# 挑発持ちの敵が場にあるとき、notice
	if ($opponent->can_provoke){
		print "Adovocation card is in opponent's field \n"
	}

	# 攻撃側
	print "which card do you attack from? type your card no \n";
	my $attack_card_no = <STDIN>;
	chomp $attack_card_no;

	# 数字チェック
	if ($attack_card_no !~ /^\d+$/) {
		print "invalid input: ${attack_card_no} \n";
		return;
	}

	# 大きさチェック
	unless ($attack_card_no > 0 && $attack_card_no <= $player->field_num) {
		print "invalid input: ${attack_card_no} \n";
		return;
	}
	my $attack_card = $player->pick_field_card_by_no($attack_card_no);

	# 攻撃可不可チェック
	unless ($attack_card->can_attack) {
		print "can not attack.. \n";
		return;
	}

	# 防御側
	print "which card do you attack to? type opponent card no.(type 0 to attack hero)\n";
	my $defense_card_no = <STDIN>;
	chomp $defense_card_no;

	# 数字チェック
	if ($defense_card_no !~ /^\d+$/) {
		print "invalid input: ${defense_card_no} \n";
		return;
	}

	# 大きさチェック
	unless ($defense_card_no >= 0 && $defense_card_no <= $opponent->field_num) {
		print "invalid input: ${defense_card_no} \n";
		return;
	}



	if ($defense_card_no == 0) {
		#挑発チェック
		if ($opponent->can_provoke){
			print "can not attack because of adovocation. \n";
			return;
		}
		$opponent->add_damage($attack_card->get_attack);
	} else {
		my $defense_card = $opponent->pick_field_card_by_no($defense_card_no);

		#挑発チェック
		if ($opponent->can_provoke && !$defense_card->has_provocation){
			print "can not attack because of adovocation. \n";
			return;
		}

		# お互いに攻撃
		$defense_card->add_damage($attack_card->get_attack);
		$attack_card->add_damage($defense_card->get_attack);

		# 掃除
		$player->cleanup_field;
		$opponent->cleanup_field;

	}
	# 攻撃済みにする
	$attack_card->set_attacked;

}

sub dump_information_by_player {
	my ($player, %options) = @_;
	my $no_hand_information = $options{no_hand_information};

	$player->show_content($no_hand_information);
}