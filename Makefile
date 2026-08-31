#/*-
# *
# * Copyright (c) 2026 Zach Metzinger
# * All rights reserved.
# *
# * Redistribution and use in source and binary forms, with or without
# * modification, are permitted provided that the following conditions
# * are met:
# * 1. Redistributions of source code must retain the above copyright
# *    notice, this list of conditions and the following disclaimer.
# * 2. Redistributions in binary form must reproduce the above copyright
# *    notice, this list of conditions and the following disclaimer in the
# *    documentation and/or other materials provided with the distribution.
# *
# * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# * SUCH DAMAGE.
# */

all: digger-x16

clean:
	rm -rf build tmp

# BEWARE: x16_memory.c must be the first file, as it sets up memory regions
# If the file src/x16_memory.c doesn't exist, try to build from patched original sources
digger-x16:
	stat src/x16_memory.c > /dev/null || make patchdist
	mkdir -p build
	oscar64 -O2 -tm=x16 \
		-i=inc \
		-i=inc/windmill \
		-i=inc/windmill/sprites \
		-dNOFLOAT -dNOLONG \
		-o=build/DIGGER.PRG \
		src/x16_memory.c \
		src/kblib.c \
		src/graphlib.c \
		src/sound.c \
		src/stubs.c \
		src/cutil.c \
		src/windmill/clib.c \
		src/windmill/image.c \
		src/windmill/image_b.c \
		src/windmill/ta.c \
		src/windmill/tb.c \
		src/windmill/tc.c \
		src/windmill/td.c \
		src/windmill/te.c \
		src/windmill/tf.c \
		src/windmill/tg.c \
		src/windmill/th.c \
		src/windmill/tx.c \
		src/windmill/tz.c

# If the file x16_memory.c doesn't exist, see if we can run the patch
patchdist: digger-x16.patch extract cp-historic apply-patch

apply-patch:
	mv tmp/* .
	patch -p0 -V none < digger-x16.patch || \
		(echo "---> Patching failed! <---" && false )

extract: digsrc_orig.zip
	sha256sum digsrc_orig.zip | \
		awk '{if ($$1 == "" || $$1 != "53c1b430b5c9e3422b2a406e7b92d4864649d98fb12ddf54e4de87cfc5688191") exit 1}' || \
		(echo "---> Wrong SHA-256 hash on digsrc_orig.zip <---" && false)
	unzip -d historic-src digsrc_orig.zip

cp-historic:
	rm -rf tmp && \
		mkdir -p tmp/src/windmill && \
		mkdir -p tmp/inc/windmill/chars && \
		mkdir -p tmp/inc/windmill/sprites
# <CR> at the end of some line still causes patch(1) fits. Remove them before the diff.
	cat historic-src/Source/CLIB.C | tr -d "\r" > tmp/src/windmill/clib.c
	cat historic-src/Source/IMAGE.C | tr -d "\r" > tmp/src/windmill/image.c
	cat historic-src/Source/IMAGE_B.C | tr -d "\r" > tmp/src/windmill/image_b.c
	cat historic-src/Work/TA.C | tr -d "\r" > tmp/src/windmill/ta.c
	cat historic-src/Work/TB.C | tr -d "\r" > tmp/src/windmill/tb.c
	cat historic-src/Work/TC.C | tr -d "\r" > tmp/src/windmill/tc.c
	cat historic-src/Work/TD.C | tr -d "\r" > tmp/src/windmill/td.c
	cat historic-src/Work/TE.C | tr -d "\r" > tmp/src/windmill/te.c
	cat historic-src/Work/TF.C | tr -d "\r" > tmp/src/windmill/tf.c
	cat historic-src/Work/TG.C | tr -d "\r" > tmp/src/windmill/tg.c
	cat historic-src/Work/TH.C | tr -d "\r" > tmp/src/windmill/th.c
	cat historic-src/Work/TX.C | tr -d "\r" > tmp/src/windmill/tx.c
	cat historic-src/Work/TZ.C | tr -d "\r" > tmp/src/windmill/tz.c
	cat historic-src/Work/DIGGER.H | tr -d "\r" > tmp/inc/windmill/digger.h
	cat historic-src/Work/NOTES.H | tr -d "\r" > tmp/inc/windmill/notes.h
	cp historic-src/Sprites/* tmp/inc/windmill/sprites
	(cd tmp/inc/windmill/sprites && \
		echo 'for i in *; do mv $${i} `echo $${i} | tr [:upper:] [:lower:]`; done' | sh -)
	cp historic-src/CLib/*.CHR tmp/inc/windmill/chars
	(cd tmp/inc/windmill/chars && \
		echo 'for i in *; do mv $${i} `echo $${i} | tr [:upper:] [:lower:]`; done' | sh -)

mkpatch: cp-historic
	diff -c -r --strip-trailing-cr -N tmp/inc inc >> tmp/digger-x16.patch || true
	diff -c -r --strip-trailing-cr -N tmp/src src >> tmp/digger-x16.patch || true

