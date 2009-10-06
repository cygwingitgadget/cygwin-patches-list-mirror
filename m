Return-Path: <cygwin-patches-return-6714-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12655 invoked by alias); 6 Oct 2009 09:09:14 -0000
Received: (qmail 12644 invoked by uid 22791); 6 Oct 2009 09:09:12 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 09:09:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 21C746D5598; Tue,  6 Oct 2009 11:08:53 +0200 (CEST)
Date: Tue, 06 Oct 2009 09:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Fix tcgetpgrp output
Message-ID: <20091006090853.GJ12789@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00045.txt.bz2

Hi,


I'd like to have your opinion for this patch before I check it in, since
I'm not sure this is the right way to fix it.

When I debugged the luit/tcsh problem yesterday, I found that the
tcgetpgrp function does not behave as advertised.

Per POSIX, the tcgetpgrp function returns the pgrp ID only if the file
descriptor references the controlling tty of the process.  If the
process has no ctty, or if the descriptor references another tty not
being the controlling tty, the function is supposed to set errno to
ENOTTY and return -1.

Cygwin OTOH, always returns the pgid of the tty, even if it's not the
controlling tty of the process.  This leads potentially to weird
results, as you can see in the output of the testcase below.

And then there's Linux, with a tiny special case.

If a Linux process opens the master side of a pty and then calls
tcgetpgrp on this file, the tcgetpgrp will return 0.  However, as soon
as a child process has called setsid() and opened the slave side of the
pty and made that tty its controlling tty, tcgetprgrp(master) returns
the own pid, not 0.  Don't look into the Linux man page, this behaviour
is not documented.

I checked that on Solaris as well, and Solaris behaves POSIX-compliant.
Here the master side returns -1/ENOTTY, unless you open the master side
without the O_NOCTTY flag and the opening process has no controlling tty
at that time.

My patch makes Cygwin behave like Linux.  It's just an additional test
in tcgetpgrp.  I'm not sure if that's TRTTD for two reasons.

- Since Linux behaves obviously not POSIX-compliant with respect to the
  master pty, I'm not sure we should really reflect Linux literally.
  Maybe it's better to behave POSIX-compliant and return -1/ENOTTY for a
  non-controlling master all the time, just as on Solaris?

- My first approach changed the actual values in tc->pgid, rather than
  just making a test for the ctty in tcgetprgrp.  I'm still wondering if
  the code should better try to maintain the correct values in the
  datastructures, or if it's better to just have this check in tcgetpgrp.

Ok, I used the following test application to verify the behaviour on
Linux, Solaris, and Cygwin:

==== SNIP ====
#define _XOPEN_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/fcntl.h>
#include <sys/wait.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

int main ()
{
  int master, slave, status;
  char pts[256];

  printf ("parent pid: %d\n", getpid ());
  if ((master = open ("/dev/ptmx", O_RDWR | O_NOCTTY)) >= 0)
    {
      int ret; 
      grantpt (master);
      unlockpt (master);
      printf ("parent tcgetpgrp master: %d\n", tcgetpgrp (master));
      strcpy (pts, ptsname (master));
      switch (fork ())
      	{
	case -1:
	  break;
	case 0:	// child
	  ret = setsid ();
	  printf ("child pid: %d (setsid: %d)\n", getpid (), ret);
	  printf ("child tcgetpgrp master before open: %d\n", tcgetpgrp (master));
	  if ((slave = open (pts, O_RDWR)) >= 0)
	    {
	      printf ("child tcgetpgrp master after open: %d\n", tcgetpgrp (master));
	      printf ("child tcgetpgrp slave: %d\n", tcgetpgrp (slave));
	      close (slave);
	    }
	  break;
	default:// parent
	  wait (&status);
	  printf ("parent tcgetpgrp master: %d\n", tcgetpgrp (master));
	  break;
	}
      close (master);
      return 0;
    }
  return 1;
}
==== SNAP ====

Output on Linux:

  parent pid: 14670
  parent tcgetpgrp master: 0
  child pid: 14671 (setsid: 14671)
  child tcgetpgrp master before open: 0
  child tcgetpgrp master after open: 14671
  child tcgetpgrp slave: 14671
  parent tcgetpgrp master: 0

Output on Solaris 10:

  parent pid: 20372
  parent tcgetpgrp master: -1
  child pid: 20374 (setsid: 20374)
  child tcgetpgrp master before open: -1
  child tcgetpgrp master after open: -1
  child tcgetpgrp slave: 20374
  parent tcgetpgrp master: -1

Output on Cygwin without my patch:

  parent pid: 3704
  parent tcgetpgrp master: 3704
  child pid: 1056 (setsid: 1056)
  child tcgetpgrp master before open: 3704
  child tcgetpgrp master after open: 1056
  child tcgetpgrp slave: 1056
  parent tcgetpgrp master: 1056

Output on Cygwin with my patch:

  parent pid: 4016
  parent tcgetpgrp master: 0
  child pid: 872 (setsid: 872)
  child tcgetpgrp master before open: 0
  child tcgetpgrp master after open: 872
  child tcgetpgrp slave: 872
  parent tcgetpgrp master: 0

So my patch results in a behaviour just like on Linux for now.

Patch attached.


Corinna


	* fhandler.h (fhandler_pty_master::tcgetpgrp): Declare.
	* fhandler_termios.cc (fhandler_termios::tcgetpgrp): Only return
	valid pgid if tty is controlling tty.  Set errno to ENOTTY and
	return -1 otherwise.
	(fhandler_pty_master::tcgetpgrp): New function.  Return 0 for
	master side of pty if it's not the controlling tty of the process.


Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.381
diff -u -p -r1.381 fhandler.h
--- fhandler.h	28 Sep 2009 12:10:32 -0000	1.381
+++ fhandler.h	6 Oct 2009 08:58:34 -0000
@@ -1109,6 +1109,7 @@ public:
   int dup (fhandler_base *);
   void fixup_after_fork (HANDLE parent);
   void fixup_after_exec ();
+  int tcgetpgrp ();
 };
 
 class fhandler_tty_master: public fhandler_pty_master
Index: fhandler_termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.74
diff -u -p -r1.74 fhandler_termios.cc
--- fhandler_termios.cc	3 Jan 2009 05:12:20 -0000	1.74
+++ fhandler_termios.cc	6 Oct 2009 08:58:34 -0000
@@ -99,7 +99,16 @@ fhandler_termios::tcsetpgrp (const pid_t
 int
 fhandler_termios::tcgetpgrp ()
 {
-  return tc->pgid;
+  if (myself->ctty != -1 && myself->ctty == tc->ntty)
+    return tc->pgid;
+  set_errno (ENOTTY);
+  return -1;
+}
+
+int
+fhandler_pty_master::tcgetpgrp ()
+{
+  return myself->ctty != -1 && myself->ctty == tc->ntty ? tc->pgid : 0;
 }
 
 void


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
