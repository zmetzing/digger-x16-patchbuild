# DIGGER

	    D I G G E R

	    for Commander X16

	    Beta Release 1.0

	    ported by Zach Metzinger, 2026

This release is a port of the IBM PC/XT game DIGGER by Windmill software.

As the copyright holder of the original DIGGER game could not be contacted,
this game is being released as a patch against the original sources.

You'll need to clone this repo and then locate digsrc_orig.zip using your
favorite World Wide Web search engine. Place the zip file in this directory
and run "make".

Assuming you have [oscar64](https://github.com/drmortalwombat/oscar64)
installed and in your path, you should get five .prg files in the
build subdirectory. Copy them onto the SD card and load thusly:

```
LOAD"DIGGER.PRG",8,1
RUN
```

Enjoy!

# TODO

 - Two player mode can't be enabled, but this will be fixed soon.
 - There is no music nor are there sound effects. Also on the list to fix.
 - No joystick (joypad) control -- you guessed it: on the list to fix.
 - Fix bugs. Probably a few in there. I don't claim to be an expert, be kind.

# AI Statement

No AI assistance was used for this port.

I believe the use of AI weakens
our skills and will result in a future even more similar to Idiocracy than
it currently does.
