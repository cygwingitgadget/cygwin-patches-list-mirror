Return-Path: <cygwin-patches-return-4508-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4021 invoked by alias); 16 Dec 2003 01:14:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2729 invoked from network); 16 Dec 2003 01:08:37 -0000
Message-ID: <3.0.5.32.20031215200813.00826100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 18 Dec 2003 10:00:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Improving tty_list security (part 1).
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1071554893==_"
X-SW-Source: 2003-q4/txt/msg00227.txt.bz2
Message-ID: <20031218100000.DOWWhWnLaZNQrJAb13rxlQ28jBvzdoN3AH6bwGBcJn8@z>

--=====================_1071554893==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 3220

Now that the PROCESS_DUP_HANDLE security hole (part 1) is plugged,
the next easily exploitable security breach in the core of Cygwin lies
in the PROCESS_DUP_HANDLE privilege between parent and seteuid children.
<http://cygwin.com/ml/cygwin-developers/2003-09/msg00078.html>
That's close to the sig area currently being worked on by Chris,
so I won't touch it. 

Next is the tty_list. It is currently implemented as an array in
the cygwin_shared file mapping, which is writable by Everybody.

As requested, changes toward a secure implementation involve a series
of incremental patches. In fact this first one introduces
NO CHANGE in functionality nor in basic logic, only the level of 
abstraction is increased.

In particular all references to "cygwin_shared->ttys" have been
removed, except from two functions in tty.cc.

In addition a new class, "tinfo" has been defined. For the
moment it only includes a single member, which points to an 
element of cygwin_shared->tty.ttys, but it will eventually become
richer. It is shamelessly inspired by pinfo. 

To facilitate the review I would suggest starting with the change
in dcrto.cc to understand the logic. Significant edits are in tty.h,
tty.cc and fhandler_tty.cc. The rest is minor. I have run with
those changes for 6 weeks, both on NT4 and WinME.

The subsequent patches on this topic will be a lot smaller although
they will contain real improvements. 
 
Pierre

2003-12-16  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler.h: Include tty.h.
	(fhandler_termios::tc): Change type to tinfo.
	(fhandler_termios::get_ttyp): Adjust for new type of tc.
	(fhandler_tty_master::init): Add argument.
	* tty.h: Add _TTY_H guard.
	(tty_list::terminate): Delete.
	(tty_list::get_tty): Delete.
	(tty_list::allocate_tty): Change type and arguments.
	(tty_list::connect_tty): Ditto.
	(class tinfo): Create.
	(attach_tty): Delete declaration.
	(create_tty_master): Change argument type.
	* dcrt0.cc (do_exit): Use tinfo constructor instead of accessing
	cygwin_shared->tty directly.
	* exceptions.cc (ctrl_c_handler): Ditto.
	* fhandler_console.cc (tty_list::get_tty): Delete.
	* fhandler_termios.cc (fhandler_termios::tcinit): Adjust for new type of tc.
	* fhandler_tty.cc (fhandler_tty_master::init): Add argument. Use it instead
	of accessing cygwin_shared->tty directly.
	(fhandler_tty_slave::open): Use tinfo method to connect to tty.
	(fhandler_pty_master::open): Use tinfo method to attach to tty.
	(fhandler_pty_master::tcgetattr): Use get_ttyp () to access
cygwin_shared->tty.
	(fhandler_pty_master::tcsetattr): Ditto.
	* termios.cc: Include cygwin/version.h before fhandler.h.
	* tty.cc (tty_init): Reorganize to use a tinfo constructor.
	(create_tty_master): Change argument type, use it appropriately and pass it 
	to tty_master->init. Do not set myself->ctty.
	(attach_tty): Delete.
	(tty_terminate): Reorganize and merge with former tty_list::terminate. 
	Call logwtmp().
	(tty_list::terminate): Delete.
	(tty_list::connect_tty): Change type, add argument and reorganize to access
	cygwin_shared->tty directly.
	(tty_list::allocate_tty): Change type, add argument, reorganize to access 
	cygwin_shared->tty directly and pass argument to create_tty_master.
	

--=====================_1071554893==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="tty.diff"
Content-length: 17311

Index: dcrt0.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.198
diff -u -p -r1.198 dcrt0.cc
--- dcrt0.cc	14 Dec 2003 07:09:22 -0000	1.198
+++ dcrt0.cc	16 Dec 2003 00:24:18 -0000
@@ -1026,13 +1026,16 @@ do_exit (int status)
       /* Kill the foreground process group on session leader exit */
       if (getpgrp () > 0 && myself->pid =3D=3D myself->sid && real_tty_att=
ached (myself))
 	{
-	  tty *tp =3D cygwin_shared->tty[myself->ctty];
-	  sigproc_printf ("%d =3D=3D sid %d, send SIGHUP to children",
-			  myself->pid, myself->sid);
+	  tinfo tc (myself->ctty);
+	  if (tc.exists ())
+	    {
+	      sigproc_printf ("%d =3D=3D sid %d, send SIGHUP to children",
+			      myself->pid, myself->sid);

-	/* CGF FIXME: This can't be right. */
-	  if (tp->getsid () =3D=3D myself->sid)
-	    tp->kill_pgrp (SIGHUP);
+	      /* CGF FIXME: This can't be right. */
+	      if (tc->getsid () =3D=3D myself->sid)
+		tc->kill_pgrp (SIGHUP);
+	    }
 	}

     }
Index: exceptions.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.186
diff -u -p -r1.186 exceptions.cc
--- exceptions.cc	14 Dec 2003 16:55:24 -0000	1.186
+++ exceptions.cc	16 Dec 2003 00:24:23 -0000
@@ -946,10 +946,10 @@ ctrl_c_handler (DWORD type)
   if (!pinfo (cygwin_pid (GetCurrentProcessId ())))
     return TRUE;

-  tty_min *t =3D cygwin_shared->tty.get_tty (myself->ctty);
+  tinfo t (myself->ctty);
   /* Ignore this if we're not the process group leader since it should be =
handled
      *by* the process group leader. */
-  if (myself->ctty !=3D -1 && t->getpgid () =3D=3D myself->pid &&
+  if (t.exists () && t->getpgid () =3D=3D myself->pid &&
        (GetTickCount () - t->last_ctrl_c) >=3D MIN_CTRL_C_SLOP)
     /* Otherwise we just send a SIGINT to the process group and return TRU=
E (to indicate
        that we have handled the signal).  At this point, type should be
Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.178
diff -u -p -r1.178 fhandler.h
--- fhandler.h	11 Dec 2003 06:12:41 -0000	1.178
+++ fhandler.h	16 Dec 2003 00:24:30 -0000
@@ -10,6 +10,7 @@ details. */

 #ifndef _FHANDLER_H_
 #define _FHANDLER_H_
+#include "tty.h"

 enum
 {
@@ -704,7 +705,7 @@ class fhandler_termios: public fhandler_
   virtual void doecho (const void *, DWORD) {};
   virtual int accept_input () {return 1;};
  public:
-  tty_min *tc;
+  tinfo tc;
   fhandler_termios () :
   fhandler_base ()
   {
@@ -889,7 +890,7 @@ class fhandler_tty_common: public fhandl

   virtual int dup (fhandler_base *child);

-  tty *get_ttyp () { return (tty *)tc; }
+  tty *get_ttyp () { return (tty *)tc.ttyinfo; }

   int close ();
   void set_close_on_exec (int val);
@@ -965,7 +966,7 @@ class fhandler_tty_master: public fhandl
   fhandler_console *console;	// device handler to perform real i/o.

   fhandler_tty_master ();
-  int init ();
+  int init (tinfo & tc);
   int init_console ();
   void set_winsize (bool);
   void fixup_after_fork (HANDLE parent);
Index: fhandler_console.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.119
diff -u -p -r1.119 fhandler_console.cc
--- fhandler_console.cc	11 Dec 2003 06:12:41 -0000	1.119
+++ fhandler_console.cc	16 Dec 2003 00:24:38 -0000
@@ -125,21 +125,6 @@ set_console_ctty ()
   (void) fhandler_console::get_tty_stuff ();
 }

-/* Return the tty structure associated with a given tty number.  If the
-   tty number is < 0, just return a dummy record. */
-tty_min *
-tty_list::get_tty (int n)
-{
-  static tty_min nada;
-  if (n =3D=3D TTY_CONSOLE)
-    return fhandler_console::get_tty_stuff ();
-  else if (n >=3D 0)
-    return &cygwin_shared->tty.ttys[n];
-  else
-    return &nada;
-}
-
-
 /* Determine if a console is associated with this process prior to a spawn.
    If it is, then we'll return 1.  If the console has been initialized, th=
en
    set it into a more friendly state for non-cygwin apps. */
Index: fhandler_termios.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_termios.cc,v
retrieving revision 1.50
diff -u -p -r1.50 fhandler_termios.cc
--- fhandler_termios.cc	7 Dec 2003 22:37:11 -0000	1.50
+++ fhandler_termios.cc	16 Dec 2003 00:24:42 -0000
@@ -29,7 +29,7 @@ fhandler_termios::tcinit (tty_min *this_
 {
   /* Initial termios values */

-  tc =3D this_tc;
+  tc.ttyinfo =3D this_tc;

   if (force || !TTYISSETF (INITIALIZED))
     {
Index: fhandler_tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler_tty.cc,v
retrieving revision 1.121
diff -u -p -r1.121 fhandler_tty.cc
--- fhandler_tty.cc	12 Dec 2003 20:46:03 -0000	1.121
+++ fhandler_tty.cc	16 Dec 2003 00:24:47 -0000
@@ -58,7 +58,7 @@ fhandler_tty_master::set_winsize (bool s
 }

 int
-fhandler_tty_master::init ()
+fhandler_tty_master::init (tinfo & t)
 {
   slave =3D dev ();
   termios_printf ("Creating master for tty%d", get_unit ());
@@ -73,7 +73,8 @@ fhandler_tty_master::init ()
   memset (&ti, 0, sizeof (ti));
   console->tcsetattr (0, &ti);

-  cygwin_shared->tty[get_unit ()]->common_init (this);
+  tc =3D t;
+  get_ttyp ()->common_init (this);

   set_winsize (false);

@@ -459,9 +460,11 @@ fhandler_tty_slave::open (int flags, mod
       goto out;
     }

-  tcinit (cygwin_shared->tty[get_unit ()]);
-
-  attach_tty (get_unit ());
+  if (!tc.connect_tty (get_unit ()))
+    {
+      set_errno (ENOENT);
+      return 0;
+    }

   set_flags ((flags & ~O_TEXT) | O_BINARY);
   /* Create synchronisation events */
@@ -925,9 +928,7 @@ fhandler_tty_common::dup (fhandler_base
   fhandler_tty_slave *fts =3D (fhandler_tty_slave *) child;
   int errind;

-  fts->tcinit (get_ttyp ());
-
-  attach_tty (get_unit ());
+  tc.dup (&fts->tc);

   HANDLE nh;

@@ -1153,13 +1154,15 @@ fhandler_pty_master::fhandler_pty_master
 int
 fhandler_pty_master::open (int flags, mode_t)
 {
-  int ntty =3D cygwin_shared->tty.allocate_tty (0);
-  if (ntty < 0)
-    return 0;
+  if (!tc.attach_tty (false))
+    {
+      debug_printf ("Cannot attach pty master");
+      return 0;
+    }

   slave =3D *ttys_dev;
-  slave.setunit (ntty);
-  cygwin_shared->tty[ntty]->common_init (this);
+  slave.setunit (tc->ntty);
+  get_ttyp ()->common_init (this);
   inuse =3D get_ttyp ()->create_inuse (TTY_MASTER_ALIVE);
   set_flags ((flags & ~O_TEXT) | O_BINARY);
   set_open_status ();
@@ -1262,14 +1265,14 @@ fhandler_pty_master::read (void *ptr, si
 int
 fhandler_pty_master::tcgetattr (struct termios *t)
 {
-  *t =3D cygwin_shared->tty[get_unit ()]->ti;
+  *t =3D get_ttyp ()->ti;
   return 0;
 }

 int
 fhandler_pty_master::tcsetattr (int, const struct termios *t)
 {
-  cygwin_shared->tty[get_unit ()]->ti =3D *t;
+  get_ttyp ()->ti =3D *t;
   return 0;
 }

Index: termios.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/termios.cc,v
retrieving revision 1.26
diff -u -p -r1.26 termios.cc
--- termios.cc	28 Nov 2003 20:55:58 -0000	1.26
+++ termios.cc	16 Dec 2003 00:24:51 -0000
@@ -17,10 +17,10 @@ details. */
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
+#include "cygwin/version.h"
 #include "fhandler.h"
 #include "dtable.h"
 #include "cygheap.h"
-#include "cygwin/version.h"
 #include "perprocess.h"
 #include "sigproc.h"
 #include <sys/termios.h>
Index: tty.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.59
diff -u -p -r1.59 tty.cc
--- tty.cc	7 Dec 2003 22:37:12 -0000	1.59
+++ tty.cc	16 Dec 2003 00:24:53 -0000
@@ -62,24 +62,25 @@ tty_init (void)

   if (NOTSTATE (myself, PID_USETTY))
     return;
-  if (myself->ctty =3D=3D -1)
-    if (NOTSTATE (myself, PID_CYGPARENT))
-      myself->ctty =3D attach_tty (myself->ctty);
-    else
-      return;
-  if (myself->ctty =3D=3D -1)
-    termios_printf ("Can't attach to tty");
+  if (myself->ctty =3D=3D -1 && NOTSTATE (myself, PID_CYGPARENT))
+    {
+      tinfo tc (true);
+      if (!tc.exists ())
+	termios_printf ("Can't attach to tty");
+      else
+	myself->ctty =3D tc->ntty;
+    }
 }

 /* Create session's master tty */

 void __stdcall
-create_tty_master (int ttynum)
+create_tty_master (tinfo & tc)
 {
   device ttym =3D *ttym_dev;
-  ttym.setunit (ttynum); /* CGF FIXME device */
+  ttym.setunit (tc->ntty); /* CGF FIXME device */
   tty_master =3D (fhandler_tty_master *) build_fh_dev (ttym);
-  if (tty_master->init ())
+  if (tty_master->init (tc))
     api_fatal ("Can't create master tty");
   else
     {
@@ -91,7 +92,7 @@ create_tty_master (int ttynum)
       (void) time (&our_utmp.ut_time);
       strncpy (our_utmp.ut_name, getlogin (), sizeof (our_utmp.ut_name));
       GetComputerName (our_utmp.ut_host, &len);
-      __small_sprintf (our_utmp.ut_line, "tty%d", ttynum);
+      __small_sprintf (our_utmp.ut_line, "tty%d", tc->ntty);
       if ((len =3D strlen (our_utmp.ut_line)) >=3D UT_IDLEN)
 	len -=3D UT_IDLEN;
       else
@@ -99,7 +100,6 @@ create_tty_master (int ttynum)
       strncpy (our_utmp.ut_id, our_utmp.ut_line + len, UT_IDLEN);
       our_utmp.ut_type =3D USER_PROCESS;
       our_utmp.ut_pid =3D myself->pid;
-      myself->ctty =3D ttynum;
       login (&our_utmp);
     }
 }
@@ -107,32 +107,16 @@ create_tty_master (int ttynum)
 void __stdcall
 tty_terminate (void)
 {
-  if (NOTSTATE (myself, PID_USETTY))
-    return;
-  cygwin_shared->tty.terminate ();
-}
+  int ttynum =3D myself->ctty;

-int __stdcall
-attach_tty (int num)
-{
-  if (num !=3D -1)
-    {
-      return cygwin_shared->tty.connect_tty (num);
-    }
-  if (NOTSTATE (myself, PID_USETTY))
-    return -1;
-  return cygwin_shared->tty.allocate_tty (1);
-}
+  if (NOTSTATE (myself, PID_USETTY) || ttynum < 0 || ttynum >=3D NTTYS)
+    return;

-void
-tty_list::terminate (void)
-{
-  int ttynum =3D myself->ctty;
+  tty *t =3D cygwin_shared->tty[ttynum];

   /* Keep master running till there are connected clients */
-  if (ttynum !=3D -1 && ttys[ttynum].master_pid =3D=3D GetCurrentProcessId=
 ())
+  if (t->master_pid =3D=3D GetCurrentProcessId ())
     {
-      tty *t =3D ttys + ttynum;
       CloseHandle (t->from_master);
       CloseHandle (t->to_master);
       /* Wait for children which rely on tty handling in this process to
@@ -159,27 +143,11 @@ tty_list::terminate (void)

       char buf[20];
       __small_sprintf (buf, "tty%d", ttynum);
-      logout (buf);
+      if (logout (buf))
+        logwtmp(buf, "", "");
     }
 }

-int
-tty_list::connect_tty (int ttynum)
-{
-  if (ttynum < 0 || ttynum >=3D NTTYS)
-    {
-      termios_printf ("ttynum (%d) out of range", ttynum);
-      return -1;
-    }
-  if (!ttys[ttynum].exists ())
-    {
-      termios_printf ("tty %d was not allocated", ttynum);
-      return -1;
-    }
-
-  return ttynum;
-}
-
 void
 tty_list::init (void)
 {
@@ -190,15 +158,33 @@ tty_list::init (void)
     }
 }

+bool
+tty_list::connect_tty (tinfo &info, int ttynum)
+{
+  info.ttyinfo =3D NULL;
+
+  if (ttynum =3D=3D TTY_CONSOLE)
+    info.ttyinfo =3D fhandler_console::get_tty_stuff (0);
+  else if (ttynum < 0 || ttynum >=3D NTTYS)
+    termios_printf ("ttynum (%d) out of range", ttynum);
+  else if (cygwin_shared->tty[ttynum]->exists ())
+    info.ttyinfo =3D cygwin_shared->tty[ttynum];
+  else
+    termios_printf ("tty %d was not allocated", ttynum);
+
+  debug_printf ("ttynum %d", ttynum);
+  return info.exists ();
+}
+
 /* Search for tty class for our console. Allocate new tty if our process is
    the only cygwin process in the current console.
-   Return tty number or -1 if error.
    If flag =3D=3D 0, just find a free tty.
  */
-int
-tty_list::allocate_tty (int with_console)
+bool
+tty_list::allocate_tty (tinfo & info, bool with_console)
 {
   HWND console;
+  info.ttyinfo =3D NULL;

   /* FIXME: This whole function needs a protective mutex. */

@@ -211,12 +197,12 @@ tty_list::allocate_tty (int with_console
       if (!oldtitle)
 	{
 	  termios_printf ("Can't *allocate console title buffer");
-	  return -1;
+	  return false;
 	}
       if (!GetConsoleTitle (oldtitle, TITLESIZE))
 	{
 	  termios_printf ("Can't read console title");
-	  return -1;
+	  return false;
 	}

       if (WaitForSingleObject (title_mutex, INFINITE) =3D=3D WAIT_FAILED)
@@ -238,7 +224,7 @@ tty_list::allocate_tty (int with_console
       if (console =3D=3D NULL)
 	{
 	  termios_printf ("Can't find console window");
-	  return -1;
+	  return false;
 	}
     }
   /* Is a tty allocated for console? */
@@ -246,7 +232,8 @@ tty_list::allocate_tty (int with_console
   int freetty =3D -1;
   for (int i =3D 0; i < NTTYS; i++)
     {
-      if (!ttys[i].exists ())
+      tty *t =3D cygwin_shared->tty[i];
+      if (!t->exists ())
 	{
 	  if (freetty < 0)	/* Scanning? */
 	    freetty =3D i;	/* Yes. */
@@ -254,17 +241,18 @@ tty_list::allocate_tty (int with_console
 	    break;		/* No.  We've got one. */
 	}

-      if (with_console && ttys[i].gethwnd () =3D=3D console)
+      if (with_console && t->gethwnd () =3D=3D console)
 	{
 	  termios_printf ("console %x already associated with tty%d",
 		console, i);
 	  /* Is the master alive? */
 	  HANDLE hMaster;
-	  hMaster =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE, ttys[i].master_pid);
+	  hMaster =3D OpenProcess (PROCESS_DUP_HANDLE, FALSE, t->master_pid);
 	  if (hMaster)
 	    {
 	      CloseHandle (hMaster);
-	      return i;
+	      info.ttyinfo =3D t;
+	      return true;
 	    }
 	  /* Master is dead */
 	  freetty =3D i;
@@ -276,22 +264,24 @@ tty_list::allocate_tty (int with_console
   if (freetty =3D=3D -1)
     {
       system_printf ("No free ttys available");
-      return -1;
+      return false;
     }
-  tty *t =3D ttys + freetty;
+  tty * t =3D cygwin_shared->tty[freetty];
   t->init ();
   t->setsid (-1);
   t->setpgid (myself->pgid);
   t->sethwnd (console);
+  info.ttyinfo =3D t;

   if (with_console)
     {
       termios_printf ("console %x associated with tty%d", console, freetty=
);
-      create_tty_master (freetty);
+      create_tty_master (info);
     }
   else
     termios_printf ("tty%d allocated", freetty);
-  return freetty;
+
+  return true;
 }

 bool
Index: tty.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/tty.h,v
retrieving revision 1.13
diff -u -p -r1.13 tty.h
--- tty.h	7 Dec 2003 22:37:12 -0000	1.13
+++ tty.h	16 Dec 2003 00:24:56 -0000
@@ -8,6 +8,8 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */

+#ifndef _TTY_H
+#define _TTY_H

 /* tty tables */

@@ -132,21 +134,37 @@ public:
   }
 };

+class tinfo;
 class tty_list
 {
   tty ttys[NTTYS];

 public:
   tty * operator [](int n) {return ttys + n;}
-  int allocate_tty (int n); /* n non zero if allocate a tty, pty otherwise=
 */
-  int connect_tty (int);
-  void terminate ();
   void init ();
-  tty_min *get_tty (int n);
+  static bool allocate_tty (tinfo & t, bool with_console);
+  static bool connect_tty (tinfo &t, int ttynum);
+};
+
+class tinfo
+{
+public:
+  tty_min * ttyinfo;
+
+  tinfo () {}
+  tinfo (int n) { connect_tty (n); }
+  tinfo (bool with_console) { attach_tty (with_console); }
+
+  tty_min * operator -> () const { return ttyinfo;}
+  bool exists () { return ttyinfo; }
+  bool connect_tty (int n) { return tty_list::connect_tty (*this, n); }
+  bool attach_tty (bool with_console) { return tty_list::allocate_tty (*th=
is, with_console); }
+  int dup (tinfo * child) { child->ttyinfo =3D ttyinfo; return 0; }
 };

 void __stdcall tty_init ();
 void __stdcall tty_terminate ();
-int __stdcall attach_tty (int);
-void __stdcall create_tty_master (int);
+void __stdcall create_tty_master (tinfo & tc);
 extern "C" int ttyslot (void);
+
+#endif /*_TTY_H*/

--=====================_1071554893==_--
