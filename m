From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Cc: cygwin-developers@sources.redhat.com
Subject: tty handling patches
Date: Thu, 07 Sep 2000 09:27:00 -0000
Message-id: <20000907122643.A22869@cygnus.com>
X-SW-Source: 2000-q3/msg00076.html

I've just made some changes to the way Cygwin handles CYGWIN=tty.  They
speed output up ENORMOUSLY but I may have introduced synchronization
issues between the tty child and the tty master.  This also affects ptys.

These changes will obviously be in the next snapshot but I would appreciate
it if anyone who has the time could build this and check it out.  I'll probably
announce this on the cygwin mailing list but I'd like to have a slightly more
limited audience try it out first.

cgf

Thu Sep  7 12:14:43 2000  Christopher Faylor <cgf@cygnus.com>

	Split out tty and shared_info stuff into their own headers and use
	throughout.  Include sys/termios.h for files which need it.
	* tty.h: New file.
	* shared_info.h: New file.
	* fhandler.h: Move inline methods that rely on tty stuff to
	fhandler_console.cc.
	* fhandler_tty.cc (fhandler_pty_master::process_slave_output): Set
	output_done_event immediately after reading data to speed up tty output
	processing.
	(process_output): Set write_error to errno or zero.
	(fhandler_tty_slave::write): Check previous write error prior to
	writing to slave end of pipe.  This allows tty output to be slightly
	less synchronous.
	* fhandler_console.cc (fhandler_console::tcsetpgrp): Moved here from
	fhandler.h.
	(fhandler_console::set_input_state): Ditto.
