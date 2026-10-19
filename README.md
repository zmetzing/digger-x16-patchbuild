# DIGGER
```
	    D I G G E R

	    for Commander X16

	    Beta Release 1.3

	    ported by Zach Metzinger, 2026
```

![main](/digger_main.png)
![level1](/digger_level_1.png)

This release is a port of the IBM PC/XT game [DIGGER](https://www.digger.org) by Windmill software.

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

Joystick support has been added, but may be a bit flakey.

Two-player mode can be toggled with the ESC key at the intro screen.

Enjoy!

# Known bugs (to be fixed)

 - Nobbins can sometimes pass through the dirt between two adjacent tunnels.
 - Death march timing is off

# TODO

 - Music is still very much "in-work", but it is no longer a silent game!
 - Sound effects are next on the list.
 - Fix bugs. Probably a few in there. I don't claim to be an expert, be kind.

# AI Statement

No AI assistance was used for this port.

I believe the use of AI weakens our skills and will result in a future
even more similar to Idiocracy than it currently does.
