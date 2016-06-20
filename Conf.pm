package Conf;

use strict;
use warnings;

sub build {
	my $class = shift;

	print "1: default\n";
	print "2: speed\n";
	print "3: power\n";
	print "which card deck do you play? type no \n";
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

	if($no == 1){
		return $class->DEFAULT_DECK_SEED;
	}elsif($no == 2){
		return $class->SPEED_DECK_SEED;
	}elsif($no == 3){
		return $class->POWER_DECK_SEED;
	}

	return $class->DEFAULT_DECK_SEED;
}

sub DEFAULT_DECK_SEED {
	my $class = shift;

	return +[
		+{
			type   => "Minion", 
			cost   => 1,
			attack => 1,
			health => 1,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 2,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 3,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 1,
			attack => 1,
			health => 2,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 3,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 1,
			attack => 2,
			health => 1,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 1,
			attack => 2,
			health => 3,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 1,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 4,
			health => 3,
		},
		+{
			type   => "Minion",
			cost   => 1,
			attack => 1,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 3,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 4,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 3,
			health => 2,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 3,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 3,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 5,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 5,
			health => 2,
		},
		+{
			type   => "Minion",
			cost   => 4,
			attack => 3,
			health => 5,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 4,
			attack => 4,
			health => 5,
		},
		+{
			type   => "Minion",
			cost   => 4,
			attack => 3,
			health => 5,
		},
		+{
			type   => "Minion",
			cost   => 5,
			attack => 5,
			health => 5,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "DealTwoDamage",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "DealTwoDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "TakeOneDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "TakeOneDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "None",
			cost   => 2,
		},
	],
}

sub SPEED_DECK_SEED {
	my $class = shift;

	return +[
		+{
			type   => "Minion", 
			cost   => 1,
			attack => 1,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 1,
			attack => 1,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 1,
			attack => 1,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 1,
			health => 2,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 1,
			health => 2,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 1,
			health => 2,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 1,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 1,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 1,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 2,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 2,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 2,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 3,
			health => 2,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 3,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 3,
			health => 1,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 5,
			health => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 5,
			health => 2,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 2,
			health => 3,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 2,
			attack => 2,
			health => 2,
		},
		+{
			type   => "Field",
			ability=> "TakeOneDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "TakeOneDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "TakeOneDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "None",
			cost   => 2,
		},
		+{
			type   => "Field",
			ability=> "None",
			cost   => 2,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
	],
}

sub POWER_DECK_SEED {
	my $class = shift;

	return +[
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 1,
			provocation => 1
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 1,
			provocation => 1
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 1,
			provocation => 1
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 3,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 3,
			health => 3,
		},
		+{
			type   => "Minion",
			cost   => 5,
			attack => 3,
			health => 2,
			divine_shield => 1,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 5,
			attack => 3,
			health => 2,
			divine_shield => 1,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 5,
			attack => 3,
			health => 2,
			divine_shield => 1,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 5,
			attack => 3,
			health => 3,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 5,
			attack => 3,
			health => 3,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 6,
			attack => 3,
			health => 4,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 6,
			attack => 3,
			health => 4,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 6,
			attack => 3,
			health => 4,
			charge => 1,
		},
		+{
			type   => "Minion",
			cost   => 7,
			attack => 5,
			health => 5,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 7,
			attack => 5,
			health => 5,
			provocation => 1,
		},
		+{
			type   => "Field",
			ability=> "TakeOneDamage",
			cost   => 3,
		},
		+{
			type   => "Field",
			ability=> "None",
			cost   => 2,
		},
		+{
			type   => "Field",
			ability=> "None",
			cost   => 2,
		},
		+{
			type   => "Field",
			ability=> "None",
			cost   => 2,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "LifeTap",
			cost   => 3,
		},
		+{
			type   => "Spell",
			ability=> "DealThreeDamageToAllMinion",
			cost   => 6,
		},
		+{
			type   => "Spell",
			ability=> "DealThreeDamageToAllMinion",
			cost   => 6,
		},
		+{
			type   => "Spell",
			ability=> "DealThreeDamageToAllMinion",
			cost   => 6,
		},
		+{
			type   => "Minion",
			cost   => 4,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 4,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 4,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 1,
			health => 3,
			provocation => 1,
		},
		+{
			type   => "Minion",
			cost   => 3,
			attack => 1,
			health => 3,
			provocation => 1,
		},
	],
}

1;