package Dist::Zilla::Plugin::JSAN::StaticDir;
BEGIN {
  $Dist::Zilla::Plugin::JSAN::StaticDir::VERSION = '0.03';
}

# ABSTRACT: Process "static" directory

use Moose;

use Path::Class;

with 'Dist::Zilla::Role::FileMunger';


has 'static_dir' => (
    isa     => 'Str',
    is      => 'rw',
    default => 'static'
);



sub dist_name_as_dir {
    my ($self) = @_;
    
    my $name = $self->zilla->name;
    
    return (split /-/, $name);
}


sub munge_file {
    my ($self, $file) = @_;
    
    my $static_dir = $self->static_dir;
    
    if ($file->name =~ m|^$static_dir|) {
        
        my $filename = dir('lib', $self->dist_name_as_dir, $file->name);
        
        $file->name($filename . "")
    }
    
}


no Moose;
__PACKAGE__->meta->make_immutable();


1;




__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::JSAN::StaticDir - Process "static" directory

=head1 VERSION

version 0.03

=head1 SYNOPSIS

In your F<dist.ini>:

    [JSAN::StaticDir]
    static_dir = static ; default

=head1 DESCRIPTION

This plugin will move the "static" directory of your distribution into the "lib" folder, under its
distribution name. Please refer to L<Module::Build::JSAN::Installable> for details what is a "static" directory. 

=head1 AUTHOR

Nickolay Platonov <nplatonov@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Nickolay Platonov.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

