package None;

use strict;
use warnings;

use parent qw/Class::Accessor::Fast/;

my @attributes = qw/
	name
	context
/;

__PACKAGE__->follow_best_practice;
__PACKAGE__->mk_accessors(@attributes);

# アビリティクラスの１つ
# 何も効果を及ぼさないクラスです。

sub build {
	my $self = shift;

	return $self->new(+{
		name     => "None",
		context  => "No ability",
	});
}

sub manifest_ability {
	my $self = shift;
	my ($player,$opponent) = @_;
}

sub show_content {
	my $self = shift;
	my $name = $self->get_name;
	my $context = $self->get_context;
	print "Name: ${name}.\n";
	print "Context : ${context}.\n";
}

1;