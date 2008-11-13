package Imager::Filter::ZoomBlur;
use strict;
use warnings;
use 5.00800;
our $VERSION = '0.01';

BEGIN {
    our $VERSION = "0.01";
    eval {
        require XSLoader;
        XSLoader::load( 'Imager::Filter::ZoomBlur', $VERSION );
        1;
    }
    or do {
        our @ISA;
        require DynaLoader;
        push @ISA, 'DynaLoader';
        Imager::Filter::ZoomBlur->bootstrap($VERSION);
    };
}

my %defaults = ( radian_mode => 0, strength => 40 );

Imager->register_filter(
    type     => 'zoom_blur',
    callsub  => sub { my %hsh = @_; __zoom_blur( $hsh{image}, $hsh{strength}, $hsh{radian_mode} ) },
    defaults => \%defaults,
    callseq  => ['image']
);

1;
__END__

=encoding utf8

=head1 NAME

Imager::Filter::ZoomBlur -

=head1 SYNOPSIS

  use Imager::Filter::ZoomBlur;

=head1 DESCRIPTION

Imager::Filter::ZoomBlur is

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
