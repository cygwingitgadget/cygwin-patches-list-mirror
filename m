Return-Path: <cygwin-patches-return-4739-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6613 invoked by alias); 11 May 2004 23:24:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6526 invoked from network); 11 May 2004 23:24:37 -0000
Message-Id: <3.0.5.32.20040511192134.007d4950@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 11 May 2004 23:24:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: tty's on Terminal Services
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1084332094==_"
X-SW-Source: 2004-q2/txt/msg00091.txt.bz2

--=====================_1084332094==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 648

This patch allows the use of tty's from privileged
accounts on Terminal Services.

Pierre

2004-05-12  Pierre Humblet <pierre.humblet@ieee.org>

	* tty.h: Remove the %d or %x from all cygtty strings.
	(tty::open_output_mutex): Only declare.
	(tty::open_input_mutex): Ditto.
	(tty::open_mutex): New definition.
	* fhandlet_tty.cc (fhandler_tty_slave::open): Declare buf with
	size CYG_MAX_PATH and replace __small_printf calls by shared_name.
	* tty.cc (tty::create_inuse): Ditto.
	(tty::get_event): Ditto.
	(tty::common_init): Ditto.
	(tty::open_output_mutex): New method definition.
	(tty::open_input_mutex): Ditto.
	(tty::open_mutex): New method.
--=====================_1084332094==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="tty.diff"
Content-length: 6774

Index: tty.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/tty.h,v
retrieving revision 1.17
diff -u -p -r1.17 tty.h
--- tty.h	13 Apr 2004 09:04:22 -0000	1.17
+++ tty.h	11 May 2004 23:16:17 -0000
@@ -8,7 +8,6 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */

-
 /* tty tables */

 #define INP_BUFFER_SIZE 256
@@ -18,15 +17,15 @@ details. */

 /* Input/Output/ioctl events */

-#define OUTPUT_DONE_EVENT	"cygtty%d.output.done"
-#define IOCTL_REQUEST_EVENT	"cygtty%d.ioctl.request"
-#define IOCTL_DONE_EVENT	"cygtty%d.ioctl.done"
-#define RESTART_OUTPUT_EVENT	"cygtty%d.output.restart"
-#define INPUT_AVAILABLE_EVENT	"cygtty%d.input.avail"
-#define OUTPUT_MUTEX		"cygtty%d.output.mutex"
-#define INPUT_MUTEX		"cygtty%d.input.mutex"
-#define TTY_SLAVE_ALIVE		"cygtty%x.slave_alive"
-#define TTY_MASTER_ALIVE	"cygtty%x.master_alive"
+#define OUTPUT_DONE_EVENT	"cygtty.output.done"
+#define IOCTL_REQUEST_EVENT	"cygtty.ioctl.request"
+#define IOCTL_DONE_EVENT	"cygtty.ioctl.done"
+#define RESTART_OUTPUT_EVENT	"cygtty.output.restart"
+#define INPUT_AVAILABLE_EVENT	"cygtty.input.avail"
+#define OUTPUT_MUTEX		"cygtty.output.mutex"
+#define INPUT_MUTEX		"cygtty.input.mutex"
+#define TTY_SLAVE_ALIVE		"cygtty.slave_alive"
+#define TTY_MASTER_ALIVE	"cygtty.master_alive"

 #include <sys/termios.h>

@@ -105,18 +104,9 @@ public:
   HWND gethwnd () {return hwnd;}
   void sethwnd (HWND wnd) {hwnd =3D wnd;}
   bool make_pipes (fhandler_pty_master *ptym);
-  HANDLE open_output_mutex ()
-  {
-    char buf[80];
-    __small_sprintf (buf, OUTPUT_MUTEX, ntty);
-    return OpenMutex (MUTEX_ALL_ACCESS, TRUE, buf);
-  }
-  HANDLE open_input_mutex ()
-  {
-    char buf[80];
-    __small_sprintf (buf, INPUT_MUTEX, ntty);
-    return OpenMutex (MUTEX_ALL_ACCESS, TRUE, buf);
-  }
+  HANDLE open_mutex (const char *mutex);
+  HANDLE open_output_mutex ();
+  HANDLE open_input_mutex ();
   bool exists ()
   {
     HANDLE h =3D open_output_mutex ();
Index: fhandler_tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.130
diff -u -p -r1.130 fhandler_tty.cc
--- fhandler_tty.cc	10 Apr 2004 13:45:09 -0000	1.130
+++ fhandler_tty.cc	11 May 2004 23:16:19 -0000
@@ -466,14 +466,14 @@ fhandler_tty_slave::open (int flags, mod

   set_flags ((flags & ~O_TEXT) | O_BINARY);
   /* Create synchronisation events */
-  char buf[40];
+  char buf[CYG_MAX_PATH];

   /* output_done_event may or may not exist.  It will exist if the tty
      was opened by fhandler_tty_master::init, normally called at
      startup if use_tty is non-zero.  It will not exist if this is a
      pty opened by fhandler_pty_master::open.  In the former case, tty
      output is handled by a separate thread which controls output.  */
-  __small_sprintf (buf, OUTPUT_DONE_EVENT, get_unit ());
+  shared_name (buf, OUTPUT_DONE_EVENT, get_unit ());
   output_done_event =3D OpenEvent (EVENT_ALL_ACCESS, TRUE, buf);

   if (!(output_mutex =3D get_ttyp ()->open_output_mutex ()))
@@ -488,7 +488,7 @@ fhandler_tty_slave::open (int flags, mod
       __seterrno ();
       return 0;
     }
-  __small_sprintf (buf, INPUT_AVAILABLE_EVENT, get_unit ());
+  shared_name (buf, INPUT_AVAILABLE_EVENT, get_unit ());
   if (!(input_available_event =3D OpenEvent (EVENT_ALL_ACCESS, TRUE, buf)))
     {
       termios_printf ("open input event failed, %E");
@@ -498,9 +498,9 @@ fhandler_tty_slave::open (int flags, mod

   /* The ioctl events may or may not exist.  See output_done_event,
      above.  */
-  __small_sprintf (buf, IOCTL_REQUEST_EVENT, get_unit ());
+  shared_name (buf, IOCTL_REQUEST_EVENT, get_unit ());
   ioctl_request_event =3D OpenEvent (EVENT_ALL_ACCESS, TRUE, buf);
-  __small_sprintf (buf, IOCTL_DONE_EVENT, get_unit ());
+  shared_name (buf, IOCTL_DONE_EVENT, get_unit ());
   ioctl_done_event =3D OpenEvent (EVENT_ALL_ACCESS, TRUE, buf);

   /* FIXME: Needs a method to eliminate tty races */
Index: tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.60
diff -u -p -r1.60 tty.cc
--- tty.cc	27 Dec 2003 01:59:29 -0000	1.60
+++ tty.cc	11 May 2004 23:16:20 -0000
@@ -310,21 +310,41 @@ bool
 tty::alive (const char *fmt)
 {
   HANDLE ev;
-  char buf[sizeof (TTY_MASTER_ALIVE) + 16];
+  char buf[CYG_MAX_PATH];

-  __small_sprintf (buf, fmt, ntty);
+  shared_name (buf, fmt, ntty);
   if ((ev =3D OpenEvent (EVENT_ALL_ACCESS, FALSE, buf)))
     CloseHandle (ev);
   return ev !=3D NULL;
 }

+HANDLE
+tty::open_output_mutex ()
+{
+  return open_mutex (OUTPUT_MUTEX);
+}
+
+HANDLE
+tty::open_input_mutex ()
+{
+  return open_mutex (INPUT_MUTEX);
+}
+
+HANDLE
+tty::open_mutex (const char *mutex)
+{
+  char buf[CYG_MAX_PATH];
+  shared_name (buf, mutex, ntty);
+  return OpenMutex (MUTEX_ALL_ACCESS, TRUE, buf);
+}
+
 HANDLE
 tty::create_inuse (const char *fmt)
 {
   HANDLE h;
-  char buf[sizeof (TTY_MASTER_ALIVE) + 16];
+  char buf[CYG_MAX_PATH];

-  __small_sprintf (buf, fmt, ntty);
+  shared_name (buf, fmt, ntty);
   h =3D CreateEvent (&sec_all, TRUE, FALSE, buf);
   termios_printf ("%s =3D %p", buf, h);
   if (!h)
@@ -348,9 +368,9 @@ HANDLE
 tty::get_event (const char *fmt, BOOL manual_reset)
 {
   HANDLE hev;
-  char buf[40];
+  char buf[CYG_MAX_PATH];

-  __small_sprintf (buf, fmt, ntty);
+  shared_name (buf, fmt, ntty);
   if (!(hev =3D CreateEvent (&sec_all, manual_reset, FALSE, buf)))
     {
       termios_printf ("couldn't create %s", buf);
@@ -440,8 +460,8 @@ tty::common_init (fhandler_pty_master *p
   if (!(ptym->input_available_event =3D get_event (INPUT_AVAILABLE_EVENT, =
TRUE)))
     return false;

-  char buf[40];
-  __small_sprintf (buf, OUTPUT_MUTEX, ntty);
+  char buf[CYG_MAX_PATH];
+  shared_name (buf, OUTPUT_MUTEX, ntty);
   if (!(ptym->output_mutex =3D CreateMutex (&sec_all, FALSE, buf)))
     {
       termios_printf ("can't create %s", buf);
@@ -449,7 +469,7 @@ tty::common_init (fhandler_pty_master *p
       return false;
     }

-  __small_sprintf (buf, INPUT_MUTEX, ntty);
+  shared_name (buf, INPUT_MUTEX, ntty);
   if (!(ptym->input_mutex =3D CreateMutex (&sec_all, FALSE, buf)))
     {
       termios_printf ("can't create %s", buf);

--=====================_1084332094==_--
