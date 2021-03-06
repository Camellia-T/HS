package CardBuilder;

use strict;
use warnings;

use Minion;
use Spell;
use Field;

use parent qw/Class::Accessor::Fast/;

__PACKAGE__->follow_best_practice;

# 2016/06/17
# SpellとMinionを一緒くたに実装するのはコードが解り辛くなるので、
# それぞれをクラスに分けてしまい、このクラスでまとめることにした。
# 受け取った conf がスペルかどうかでビルドするカードの種類を変えている。

# 継承先で絶対に実装しなければいけない関数リスト
# build_by_conf
# is_spell
# is_alive
# show_content

sub build_by_conf {
	my $class = shift;
	my ($conf) = @_;

	my $type = $conf->{type};

	if($type eq "Minion"){
		return Minion->build_by_conf($conf);
	}elsif($type eq "Spell"){
		return Spell->build_by_conf($conf);
	}elsif($type eq "Field"){
		return Field->build_by_conf($conf);
	}
}

1;