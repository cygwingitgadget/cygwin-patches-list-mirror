Return-Path: <cygwin-patches-return-5905-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4479 invoked by alias); 2 Jul 2006 16:19:15 -0000
Received: (qmail 4468 invoked by uid 22791); 2 Jul 2006 16:19:14 -0000
X-Spam-Check-By: sourceware.org
Received: from mailproxy-in2.jaist.ac.jp (HELO mailproxy-in2.jaist.ac.jp) (150.65.5.23)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 02 Jul 2006 16:19:10 +0000
Received: from localhost (localhost [127.0.0.1]) by mailproxy-in2.jaist.ac.jp  (JAIST-MAIL) with SMTP id <0J1S00LO2ANW7O@mailproxy-in2.jaist.ac.jp> for  cygwin-patches@cygwin.com; Mon, 03 Jul 2006 01:19:08 +0900 (JST)
Received: from NFORCE1 (nforce1.jaist.ac.jp [150.65.191.58])  by mailproxy-in2.jaist.ac.jp (JAIST-MAIL)  with ESMTP id <0J1S007HIANR0S@mailproxy-in2.jaist.ac.jp> for  cygwin-patches@cygwin.com; Mon, 03 Jul 2006 01:19:04 +0900 (JST)
Date: Sun, 02 Jul 2006 16:19:00 -0000
From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Subject: setmetamode
To: cygwin-patches@cygwin.com
Message-id: <u8xncvv26.fsf@jaist.ac.jp>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="=-=-="
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (windows-nt)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00000.txt.bz2


--=-=-=
Content-length: 584

Here is the patch to control the handling of the meta key with
the setmetamode command on the Cygwin console like the Linux
console.

I submitted the previous version of this patch three years ago,
but it didn't work on Corinna's environment. I, however, wasn't
able to find any reason why it didn't work, so the logic of this
patch is the same as the previous one.

May it works fine on environment other than mine.
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology

--=-=-=
Content-Disposition: attachment; filename=ChangeLog.cygwin
Content-length: 525

2006-07-03  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* fhandler.h (class dev_console): Add `metabit' indicating the
	current meta key mode.
	* fhandler_console.cc (fhandler_console::read): Set the top bit of
	the character if metabit is true.
	* fhandler_console.cc (fhandler_console::ioctl): Implement
	KDGKBMETA and KDSKBMETA commands.
	* fhandler_tty.cc (process_ioctl): Support KDSKBMETA.
	(fhandler_tty_slave::ioctl): Send KDGKBMETA and KDSKBMETA to the
	master.
	* include/cygwin/kd.h: New file for the meta key mode.

--=-=-=
Content-Disposition: attachment; filename=ChangeLog.utils
Content-length: 120

2006-07-03  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* Makefile.in: Build setmetamode.exe.
	* setmetamode.c: New file.

--=-=-=
Content-Disposition: attachment; filename=setmeta-cygwin.diff
Content-length: 4244

Index: cygwin/fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.294
diff -u -r1.294 fhandler.h
--- cygwin/fhandler.h	26 Jun 2006 12:12:11 -0000	1.294
+++ cygwin/fhandler.h	2 Jul 2006 15:29:59 -0000
@@ -821,6 +821,7 @@
   unsigned rarg;
   bool saw_question_mark;
   bool alternate_charset_active;
+  bool metabit;
 
   char my_title_buf [TITLESIZE + 1];
 
Index: cygwin/fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.164
diff -u -r1.164 fhandler_console.cc
--- cygwin/fhandler_console.cc	3 Jun 2006 20:32:07 -0000	1.164
+++ cygwin/fhandler_console.cc	2 Jul 2006 15:29:59 -0000
@@ -20,6 +20,7 @@
 #include <winnls.h>
 #include <ctype.h>
 #include <sys/cygwin.h>
+#include <cygwin/kd.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -397,6 +398,11 @@
 		meta = (control_key_state & dev_state->meta_mask) != 0;
 	      if (!meta)
 		toadd = tmp + 1;
+	      else if (dev_state->metabit)
+		{
+		  tmp[1] |= 0x80; 
+		  toadd = tmp + 1;
+		}
 	      else
 		{
 		  tmp[0] = '\033';
@@ -745,6 +751,20 @@
       case TIOCSWINSZ:
 	bg_check (SIGTTOU);
 	return 0;
+      case KDGKBMETA:
+	*(int *) buf = (dev_state->metabit) ? K_METABIT : K_ESCPREFIX;
+	return 0;
+      case KDSKBMETA:
+	if ((int) buf == K_METABIT)
+	  dev_state->metabit = TRUE;
+	else if ((int) buf == K_ESCPREFIX)
+	  dev_state->metabit = FALSE;
+	else
+	  {
+	    set_errno (EINVAL);
+	    return -1;
+	  }
+	return 0;
       case TIOCLINUX:
 	if (* (int *) buf == 6)
 	  {
Index: cygwin/fhandler_tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.172
diff -u -r1.172 fhandler_tty.cc
--- cygwin/fhandler_tty.cc	12 Jun 2006 14:56:31 -0000	1.172
+++ cygwin/fhandler_tty.cc	2 Jul 2006 15:30:00 -0000
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <ctype.h>
 #include <limits.h>
+#include <cygwin/kd.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -435,9 +436,12 @@
     {
       WaitForSingleObject (tty_master->ioctl_request_event, INFINITE);
       termios_printf ("ioctl() request");
-      tty_master->get_ttyp ()->ioctl_retval =
-      tty_master->console->ioctl (tty_master->get_ttyp ()->cmd,
-			     (void *) &tty_master->get_ttyp ()->arg);
+      tty *ttyp = tty_master->get_ttyp ();
+      ttyp->ioctl_retval =
+      tty_master->console->ioctl (ttyp->cmd,
+				  (ttyp->cmd == KDSKBMETA)
+				  ? (void *) ttyp->arg.value
+				  : (void *) &ttyp->arg);
       SetEvent (tty_master->ioctl_done_event);
     }
 }
@@ -1001,6 +1005,8 @@
     case TIOCGWINSZ:
     case TIOCSWINSZ:
     case TIOCLINUX:
+    case KDGKBMETA:
+    case KDSKBMETA:
       break;
     case FIONBIO:
       set_nonblocking (*(int *) arg);
@@ -1057,6 +1063,28 @@
 	  *(unsigned char *) arg = get_ttyp ()->arg.value & 0xFF;
 	}
       break;
+    case KDGKBMETA:
+      if (ioctl_request_event)
+	{
+	  SetEvent (ioctl_request_event);
+	  if (ioctl_done_event)
+	    WaitForSingleObject (ioctl_done_event, INFINITE);
+	  *(int *) arg = get_ttyp ()->arg.value;
+	}
+      else
+	get_ttyp ()->ioctl_retval = -EINVAL;
+      break;
+    case KDSKBMETA:
+      if (ioctl_request_event)
+	{
+	  get_ttyp ()->arg.value = (int) arg;
+	  SetEvent (ioctl_request_event);
+	  if (ioctl_done_event)
+	    WaitForSingleObject (ioctl_done_event, INFINITE);
+	}
+      else
+	get_ttyp ()->ioctl_retval = -EINVAL;
+      break;
     }
 
   release_output_mutex ();
--- /dev/null	2006-07-03 00:31:47.828125000 +0900
+++ cygwin/include/cygwin/kd.h	2005-09-21 08:54:34.015625000 +0900
@@ -0,0 +1,20 @@
+/* cygwin/kd.h
+
+   Copyright 2005 Red Hat Inc.
+   Written by Kazuhiro Fujieda <fujieda@jaist.ac.jp>
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _CYGWIN_KD_H_
+#define _CYGWIN_KD_H_
+
+#define KDGKBMETA 0x4b62
+#define KDSKBMETA 0x4b63
+#define K_METABIT 0x03
+#define K_ESCPREFIX 0x04
+
+#endif

--=-=-=
Content-Disposition: attachment; filename=setmeta-utils.diff
Content-length: 2468

Index: utils/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.62
diff -u -r1.62 Makefile.in
--- utils/Makefile.in	18 Jan 2006 15:57:55 -0000	1.62
+++ utils/Makefile.in	2 Jul 2006 15:33:40 -0000
@@ -74,7 +74,7 @@
 
 PROGS:=	cygcheck.exe cygpath.exe getfacl.exe kill.exe mkgroup.exe \
 	mkpasswd.exe mount.exe passwd.exe ps.exe regtool.exe setfacl.exe \
-	ssp.exe strace.exe umount.exe ipcrm.exe ipcs.exe
+	setmetamode.exe ssp.exe strace.exe umount.exe ipcrm.exe ipcs.exe
 
 CLEAN_PROGS:=$(PROGS)
 ifndef build_dumper
--- /dev/null	2006-07-03 00:34:58.640625000 +0900
+++ utils/setmetamode.c	2005-09-21 08:54:51.593750000 +0900
@@ -0,0 +1,82 @@
+/* setmetamode.c
+
+   Copyright 2005 Red Hat Inc.
+
+   Written by Kazuhiro Fujieda <fujieda@jaist.ac.jp>
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <cygwin/kd.h>
+
+static const char version[] = "$Revision$";
+static char *prog_name;
+
+static void
+usage (void)
+{
+  fprintf (stderr, "Usage: %s [metabit|escprefix]\n"
+	   "  Without argument, it shows the current meta key mode.\n"
+	   "  metabit|meta|bit     The meta key sets the top bit of the character.\n"
+	   "  escprefix|esc|prefix The meta key sends an escape prefix.\n",
+	   prog_name);
+}
+
+static void
+error (void)
+{
+  fprintf (stderr,
+	   "%s: The standard input isn't a console device.\n",
+	   prog_name);
+}
+
+int
+main (int ac, char *av[])
+{
+  int param;
+
+  prog_name = strrchr (av[0], '/');
+  if (!prog_name)
+    prog_name = strrchr (av[0], '\\');
+  if (!prog_name)
+    prog_name = av[0];
+  else
+    prog_name++;
+
+  if (ac < 2)
+    {
+      if (ioctl (0, KDGKBMETA, &param) < 0)
+	{
+	  error ();
+	  return 1;
+	}
+      if (param == 0x03)
+	puts ("metabit");
+      else
+	puts ("escprefix");
+      return 0;
+    }
+  if (!strcmp ("meta", av[1]) || !strcmp ("bit", av[1])
+      || !strcmp ("metabit", av[1]))
+    param = 0x03;
+  else if (!strcmp ("esc", av[1]) || !strcmp ("prefix", av[1])
+	   || !strcmp ("escprefix", av[1]))
+    param = 0x04;
+  else
+    {
+      usage ();
+      return 1;
+    }
+  if (ioctl (0, KDSKBMETA, param) < 0)
+    {
+      error ();
+      return 1;
+    }
+  return 0;
+}

--=-=-=--


