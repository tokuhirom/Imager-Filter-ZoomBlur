use strict;
use warnings;
use Imager;
use Imager::Filter::ZoomBlur;

my ($src, $dst) = @ARGV;

my $img = Imager->new;
$img->read(file => $src) or die $img->errstr;
$img->filter(type => 'zoom_blur', strength => 20, radian_mode => 1) or die $img->errstr;
$img->write(file => $dst) or die $img->errstr;
