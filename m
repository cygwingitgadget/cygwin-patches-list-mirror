From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: DJ Delorie <dj@redhat.com>
Subject: Re: /dev/dsp
Date: Sun, 15 Apr 2001 20:30:00 -0000
Message-id: <20010415233048.A11789@redhat.com>
References: <F28ukp53NVBRIoni4u60000de19@hotmail.com>
X-SW-Source: 2001-q2/msg00069.html

Hi,
Your assignment came in last week so I committed this patch.

In the process, I reformatted your Makefile addition so that
the object files are still in alphabetical order.  I also removed
your addition of -lwinmm and added the loading of the routines
used by fhandler_dsp.cc to autoload.cc.

The fhandler_dsp.cc file didn't actually compile, though.  I had
to change an include from machine/soundcard.h to sys/soundcard.h.

Could you check this out and let me know if everything looks ok?
I wanted to get this into 1.3.0 so if you say it works ok, I'll
probably be releasing the new DLL asap.

Hmm.  Uh oh.  Wait a minute.  I just looked at the copyright in
the soundcard.h file.  I'm not sure if this is acceptable for
a cygwin release or not.

DJ, could you look at this file winsup/cygwin/include/sys/soundcard.h.

Are we going to have a problem with this?

cgf

On Wed, Mar 28, 2001 at 11:07:42PM -0000, Andy Younger wrote:
>Hi,
>
>Here is my first revision of the /dev/dsp device for cygwin.
>
>This patch is very much a work in progress, it only supports writing to 
>/dev/dsp & even then only supports a small subset of the IOCTLs. The subsets 
>it does supports is enough to get my current test applications, mpg123, 
>mikmod & ogg123 to work with no source-code modifications to the playback 
>code.
>
>I have also modifed /dev/dsp so that when you cat a wav file through it, it 
>groks the format and sets itself up accordingly. You do get a couple of 
>clicks as the header & footer go through the playback, which I should really 
>fix, anyway doing
>  cat testsample.wav >/dev/dsp
>should work fine, although I still have to fix the dup() to behave better.
>
>My assignment paperwork has just been sent off, so I presume I can't 
>actually properly submit anyhing for a while, but any feedback will be 
>welcomed. I am not overly familiar with Changelog formats, diff files etc, 
>so any pointers would be well appreciated.
>
>Anyway..
>
>
>Stuff still to do
>-----------------
>
>I am supplying my modified version of the linux soundcard.h, I have actually 
>done my own cut down version of it which only has the things I currently 
>support through emulation. But for testing purposes it is easier for me to 
>use the original. I am not sure of the licencing issues for this header 
>file. Presumably I should redo mine to use the same id's for all the 
>definitions as the linux one, so we have some form of compatiblity. 
>Presumably projects such as LINE would benefit from this.
>
>Fix dup() functionality to work properly, currently if you kill "cat 
>whatever.wav >/dev/dsp"
>it crashes out.
>
>Make /dev/dsp locked behaviour (under win9X) behave better.
>
>Fix up to be properly thread safe, I don't fully understand the issues 
>related to callbacks, are they in the same process context regardless of 
>number of processors etc? should find out & clean up code accordingly.
>
>Support many more IOCTL commands.
>
>Support reading from /dev/dsp as well
>
>Support subset of /dev/mixer
>
>Support more unusual sound formats such as ulaw etc, then I can set up 
>/dev/audio etc.
>
>
>CHANGELOG:
>----------
>Wed Mar 28 2001 Andy Younger <andylyounger@hotmail.com>
>
>	* fhandler_dsp.cc: new file. Implements OSS like /dev/dsp
>	* include/sys/soundcard.h: new file. User land includes for OSS /dev/dsp
>	* fhandler.h: add new class fhandler_dev_dsp and a FH_OSS_DSP definition
>	* makefile.in: add fhandler_dsp.o
>	* dtable.cc (dtable::build_fhandler): allow creation of the /dev/dsp
>	  device.
>	* path.cc (windows_device_names): add /dev/dsp into list of device
>	  names
>
>DIFF:
>-----
>
>The diff was created by,
>
>	diff -up src.original/winsup/cygwin/ src/winsup/cygwin/  >dsp.diff
>
>is this ok, or do I need to do something different?
>
>
>Cheers, Looking forward to some feedback.
>
>Andy.
>
>
>_________________________________________________________________________
>Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com .



-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
