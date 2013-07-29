ks0108_lib
==========

KS0108 Graphics Library for PIC16F microcontrollers 

The project is based on the source found here:

http://en.radzio.dxp.pl/ks0108/

The source is made pretty universal, still it took some
work and modifications to have it working in mikroC. The archive is a
ready working project for mikroC.

I tested and developed it on the EasyPIC5 development board
with a PIC16F887 microcontroller. You have to have the board  configured
for the touchscreen panel and GLCD display - I suppose you know how to
do that, if not you should consult the EasyPIC5 manual.

The project has everything you need:

    * a small demo program that uses text and bitmaps so you can see how
    the touchscreen, graphics, images and text work
    * a font file
    * a file to host your bitmap data
    * graphic functions
    * ks0108 functions
    * microcontroller dependent functions.
