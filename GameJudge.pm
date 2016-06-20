package GameJudge;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

use Player;
use AbilityMgr;
use Deck;
use Hero;

my @attributes = qw/
	abilityMgr
	player1
	player2
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

sub build {
	my $class = shift;

	my $abilityMgr = AbilityMgr->build;


	print "Enter Player 1 name.\n";
	my $player1_name = <STDIN>;
	chomp $player1_name;

	my $deck = Deck->build;
	print "Choose hero power by name.\n";
	$abilityMgr->show_hero_power_list;
	my $hp_name = <STDIN>;
	chomp $hp_name;
	my $hero = Hero->build_by_hero_power($hp_name);

	my $player1 = Player->build_by_player_name_deck_and_hero($player1_name,$deck,$hero,$abilityMgr);
	$player1->initialize;


	
	print "Enter Player 2 name.\n";
	my $player2_name = <STDIN>;
	chomp $player2_name;

	$deck = Deck->build;
	print "Choose hero power by name.\n";
	$abilityMgr->show_hero_power_list;
	$hp_name = <STDIN>;
	chomp $hp_name;
	my $hero = Hero->build_by_hero_power($hp_name);

	my $player2 = Player->build_by_player_name_deck_and_hero($player2_name,$deck,$hero,$abilityMgr);
	$player2->initialize;
	
	$player1->turn_start;
	$player1->turn_initialize(no_draw => 1);


	return $class->new(+{
		player1    => $player1,
		player2    => $player2,
		abilityMgr => $abilityMgr,
	});
}


1;