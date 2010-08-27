package Dist::Zilla::Plugin::JSAN::Prereq;
BEGIN {
  $Dist::Zilla::Plugin::JSAN::Prereq::VERSION = '0.01_05';
}

# ABSTRACT: list simple prerequisites in JavaScript naming convention

use Moose;


extends 'Dist::Zilla::Plugin::Prereq';

has _prereq => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { {} },
);

sub register_prereqs {
    my ($self) = @_;
    
    my $prereq        = $self->_prereq;
    my $jsan_prereq   = {};
    
    foreach my $key (keys %$prereq) {
        my $key_copy    = $key;
        $key_copy       =~ s/\./::/g;
        
        $jsan_prereq->{ $key_copy } = $prereq->{ $key };
    }    

    $self->_prereq($jsan_prereq);
    
    return $self->SUPER::register_prereqs();
}

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

1;




__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::JSAN::Prereq - list simple prerequisites in JavaScript naming convention

=head1 VERSION

version 0.01_05

=head1 SYNOPSIS

In your F<dist.ini>:

  [JSAN::Prereq]
  Foo.Bar       = 1.002
  MRO.Compat    = 10
  Sub.Exporter  = 0

=head1 DESCRIPTION

This module adds "fixed" prerequisites to your distribution.  These are prereqs
with a known, fixed minimum version that doens't change based on platform or
other conditions. 

The only difference from standard [Prereq] plugin is that this plugin
allows you to use the dot in the prereq name as the namespace delimeter.

=head1 AUTHOR

Nickolay Platonov <nplatonov@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Nickolay Platonov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

