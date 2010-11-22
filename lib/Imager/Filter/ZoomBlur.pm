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

Imager::Filter::ZoomBlur - zoom blur filter for Imager

=head1 SYNOPSIS

    use Imager::Filter::ZoomBlur;

    my $img = Imager->new('path/to/image.jpg');

    # zoom blur
    my $filtered = $img->filter('zoom_blur', strength => 40, radian_mode => 0);

    # rotate blur
    my $filtered = $img->filter('zoom_blur', strength => 40, radian_mode => 1);

=head1 DESCRIPTION

Imager::Filter::ZoomBlur is zoom blur filter for L<Imager>.

=head1 PARAMETERS

=over 4

=item strength: Int

Strength of filter.

=item radian_mode: Bool

If it is false, the filter is zoom blur. If it is false, the filter is rotate blur.

=back

=head1 SAMPLE IMAGES

=over 4

=item L<original image|http://gyazo.com/b9c8c7d0f5b10af05d64b8040887c5a2.png>

=item L<zoom blur|http://gyazo.com/50adcf735c4bd5b67be5050b1264ffff.png>>

=item L<rotate blur|http://gyazo.com/ea297068147d34d81f81ce57d560530e.png>

=back

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF GMAIL COME<gt>

=head1 SEE ALSO

L<Imager>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
