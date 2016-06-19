package Conf;

use strict;
use warnings;

sub DEFAULT_DECK_SEED {
	my $class = shift;

	return +[
		+{
			cost   => 1,
			attack => 1,
			health => 1,
			provocation => 1,
		},
		+{
			cost   => 2,
			attack => 2,
			health => 2,
			provocation => 1,
		},
		+{
			cost   => 3,
			attack => 3,
			health => 3,
			charge => 1,
		},
		+{
			cost   => 1,
			attack => 1,
			health => 2,
			provocation => 1,
		},
		+{
			cost   => 2,
			attack => 2,
			health => 3,
			provocation => 1,
		},
		+{
			cost   => 3,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			cost   => 1,
			attack => 2,
			health => 1,
			divine_shield => 1,
		},
		+{
			cost   => 2,
			attack => 2,
			health => 1,
			charge => 1,
		},
		+{
			cost   => 3,
			attack => 3,
			health => 4,
			divine_shield => 1,
		},
		+{
			cost   => 1,
			attack => 2,
			health => 3,
			charge => 1,
		},
		+{
			cost   => 2,
			attack => 2,
			health => 1,
			divine_shield => 1,
		},
		+{
			cost   => 3,
			attack => 4,
			health => 3,
		},
		+{
			cost   => 1,
			attack => 1,
			health => 1,
		},
		+{
			cost   => 2,
			attack => 2,
			health => 3,
		},
		+{
			cost   => 2,
			attack => 4,
			health => 1,
		},
		+{
			cost   => 2,
			attack => 3,
			health => 2,
			charge => 1,
		},
		+{
			cost   => 2,
			attack => 2,
			health => 3,
		},
		+{
			cost   => 2,
			attack => 3,
			health => 1,
			charge => 1,
		},
		+{
			cost   => 3,
			attack => 5,
			health => 1,
		},
		+{
			cost   => 3,
			attack => 5,
			health => 2,
		},
		+{
			cost   => 4,
			attack => 3,
			health => 5,
			charge => 1,
		},
		+{
			cost   => 4,
			attack => 4,
			health => 5,
		},
		+{
			cost   => 4,
			attack => 3,
			health => 5,
		},
		+{
			cost   => 5,
			attack => 5,
			health => 5,
		},
		+{
			cost   => 1,
			type   => 1,
			id     => 0,
		},
		+{
			cost   => 1,
			type   => 1,
			id     => 0,
		},
		+{
			cost   => 1,
			type   => 2,
			id     => 0,
		},
		+{
			cost   => 3,
			type   => 2,
			id     => 1,
		},
		+{
			cost   => 3,
			type   => 2,
			id     => 1,
		},
		+{
			cost   => 2,
			type   => 2,
			id     => 0,
		},
	],
}

1;