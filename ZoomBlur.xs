#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"
#ifdef __cplusplus
}
#endif

#include <math.h>
#include "imext.h"
#include "imperl.h"

#define min(x,y) ((x)<(y) ? (x) : (y))

void 
__zoom_blur(i_img *im, int strength, int radian_mode) {
    i_color color;
    int x,y;
    i_img *canvas = i_img_8_new(im->xsize, im->ysize, im->channels);
    
    // configuration
    int num_samples = 17;
    int numbase = 8;

    double maxdist = sqrt((im->xsize/2)*(im->xsize/2) + (im->ysize/2)*(im->ysize/2));
    double cx = im->xsize/2; // center
    double cy = im->ysize/2; // center
    int i;

    for(x = 0; x < im->xsize; ++x) {
        for(y = 0; y < im->ysize; ++y) {
            int rr=0; int gg=0; int bb=0;
            int sum_weighing = 0;
            double dx = x-cx;
            double dy = y-cy;
            double rad = atan2(dy, dx);
            double dist = sqrt(dx*dx + dy*dy);
            double rate = strength * dist / maxdist / numbase;
            if (radian_mode) {
                rad += M_PI/2;
            }
            for (i=0; i<num_samples; i++) {
                int weighting = (i== numbase) ? 3 : 1;

                int dist_i = (i-numbase) * rate;
                int xx = dist_i * cos(rad) + x;
                int yy = dist_i * sin(rad) + y;
                if (0<= xx && xx < im->xsize && 0<= yy && y < im->ysize) {
                    i_color tmp;
                    i_gpix(im, xx, yy, &tmp);
                    rr += tmp.rgb.r * weighting;
                    gg += tmp.rgb.g * weighting;
                    bb += tmp.rgb.b * weighting;
                    sum_weighing += weighting;
                }
            }
            color.rgb.r = rr / sum_weighing;
            color.rgb.g = gg / sum_weighing;
            color.rgb.b = bb / sum_weighing;
            i_ppix(canvas, x,   y, &color);
        }
    }
    i_copyto(im, canvas, 0, 0, (int)im->xsize, (int)im->ysize, 0, 0);
    i_img_destroy(canvas);
}

DEFINE_IMAGER_CALLBACKS;

MODULE = Imager::Filter::ZoomBlur   PACKAGE = Imager::Filter::ZoomBlur

PROTOTYPES: ENABLE

void
__zoom_blur(im, strength, radian_mode)
    Imager::ImgRaw im
    int strength;
    int radian_mode;

BOOT:
        PERL_INITIALIZE_IMAGER_CALLBACKS;

