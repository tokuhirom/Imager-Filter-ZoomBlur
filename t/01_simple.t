use strict;
use warnings;
use Test::More;
use Imager;
use Imager::Filter::ZoomBlur;

my $img = Imager->new(file => 't/data/foo.jpg') or die;
ok(my $img1 = $img->copy->filter(type => 'zoom_blur', strength => 40, radian_mode => 1))
    or die $img->errstr();
ok(my $img2 = $img->filter(type => 'zoom_blur', strength => 40, radian_mode => 0))
    or die $img->errstr();
if ($ENV{DEBUG}) {
    $img1->write(file => 'rotate_blur.jpg');
    $img2->write(file => 'zoom_blur.jpg');
}

done_testing;

