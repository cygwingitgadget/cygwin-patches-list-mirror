From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/dsp
Date: Thu, 29 Mar 2001 11:48:00 -0000
Message-id: <20010329134518.E16622@cygbert.vinschen.de>
References: <F28ukp53NVBRIoni4u60000de19@hotmail.com>
X-SW-Source: 2001-q1/msg00268.html

On Wed, Mar 28, 2001 at 11:07:42PM -0000, Andy Younger wrote:
> Hi,
> 
> Here is my first revision of the /dev/dsp device for cygwin.

Cool! 

> I am not overly familiar with Changelog formats, diff files etc, 
> so any pointers would be well appreciated.

Ok, here we go... your ChangeLog looks good. Just some minor nits:

> CHANGELOG:
> ----------
> Wed Mar 28 2001 Andy Younger <andylyounger@hotmail.com>
> 
> 	* fhandler_dsp.cc: new file. Implements OSS like /dev/dsp
								 ^
								Missing the
								full stop.

> 	* include/sys/soundcard.h: new file. User land includes for OSS /dev/dsp
				   ^
				   Always begin upper case.

> 	* fhandler.h: add new class fhandler_dev_dsp and a FH_OSS_DSP definition
> 	* makefile.in: add fhandler_dsp.o
> 	* dtable.cc (dtable::build_fhandler): allow creation of the /dev/dsp
> 	  device.
	  ^^^^^^^
	  All lines should have the same indentation:

 	* dtable.cc (dtable::build_fhandler): allow creation of the /dev/dsp
 	device.

> 	* path.cc (windows_device_names): add /dev/dsp into list of device
> 	  names
> 
> DIFF:
> -----
> 
> The diff was created by,
> 
> 	diff -up src.original/winsup/cygwin/ src/winsup/cygwin/  >dsp.diff
> 
> is this ok, or do I need to do something different?

diff -up is fine. We are using the same format. But I (and Chris as well)
would appreciate to get it included into the mail text itself (assuming
your mail client handles indentation and line breaks reasonable) or
at least as attachment without compression, just the diff.

Thanks for your efforts!
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
