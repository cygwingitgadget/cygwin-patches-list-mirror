From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sources.redhat.com
Cc: cwilson@ece.gatech.edu
Subject: Re: [patch] limited /dev/clipboard support
Date: Mon, 16 Oct 2000 18:49:00 -0000
Message-id: <200010170148.VAA15515@envy.delorie.com>
X-SW-Source: 2000-q4/msg00004.html

> 2000-10-12  Charles Wilson  <cwilson@ece.gatech.edu>
> 
> 	* winsup/cygwin/fhandler_clipboard.cc: new file
> 	* winsup/cygwin/Makefile.in: add libuser32.a to the DLL_IMPORTS list,
> 	and include fhandler_clipboard.o in DLL_OFILES list.
> 	* winsup/cygwin/fhandler.h: add FH_CLIPBOARD to the devices enum.
> 	* winsup/cygwin/fhandler.h (fhandler_dev_clipboard): new
> 	* winsup/cygwin/path.cc (windows_device_names): add "\\dev\\clipboard"
> 	* winsup/cygwin/path.cc (get_device_number): check for "clipboard"
> 	* winsup/cygwin/winsup.h: declare a few more functions from winuser.h
> 	* winsup/cygwin/dtable.cc (dtable::build_fhandler): check for 
> 	FH_CLIPBOARD in switch().

Applied, with some minor changes:

* user32 functions are autoloaded through dcrt0.cc; we don't link
  libuser32.a

* files that need <winuser.h> include it themselves (and wingdi.h).
  The one exception in winsup.h is because *most* cygwin files use
  that one function.

* We are "Red Hat, Inc." not just "Red Hat" (they make me say that ;)

Thanks!
