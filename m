From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Make Cygwin damons easier to use on Win9x.
Date: Wed, 11 Jul 2001 08:39:00 -0000
Message-id: <s1szoabcw66.fsf@jaist.ac.jp>
References: <s1sithjcndc.fsf@jaist.ac.jp> <20010626104909.B6427@redhat.com> <s1sr8w64yoq.fsf@jaist.ac.jp> <20010627012107.H19058@redhat.com> <s1su212yxwm.fsf@jaist.ac.jp> <005301c0ff01$5430ac20$0400a8c0@local> <s1ssngmylrs.fsf@jaist.ac.jp>
X-SW-Source: 2001-q3/msg00010.html

I had enjoyed my daemon patch for a while. I found detaching
the console worked fine and cause no undesirable side effect,
while the ctrl_c_handler caused an undesirable effect.
It terminated Cygwin processes running as services on NT/2000
when an user logged off. So I fixed it.

2001-07-12  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* syscalls.cc (setsid): Detach process from its console if
	the current controlling tty is the console and already closed.
	* dtable.h (class dtable): Add members to count descriptors
	referring to the console.
	* dtable.cc (dtable::dec_console_fds): New function to detach
	process from its console.
	(dtable::release): Decrement the counter of console descriptors.
	(dtable::build_fhandler): Increment it.
	* exception.cc (ctrl_c_handler): Send SIGTERM to myself when catch
	CTRL_SHUTDOWN_EVENT.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.126
diff -u -p -r1.126 syscalls.cc
--- syscalls.cc	2001/06/28 02:19:57	1.126
+++ syscalls.cc	2001/07/10 13:29:32
@@ -236,6 +236,8 @@ setsid (void)
   /* FIXME: for now */
   if (myself->pgid != _getpid ())
     {
+      if (myself->ctty == TTY_CONSOLE && !cygheap->fdtab.has_console_fds ())
+	FreeConsole ();
       myself->ctty = -1;
       myself->sid = _getpid ();
       myself->pgid = _getpid ();
Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.40
diff -u -p -r1.40 dtable.cc
--- dtable.cc	2001/06/24 22:26:50	1.40
+++ dtable.cc	2001/07/10 13:29:32
@@ -51,6 +51,13 @@ set_std_handle (int fd)
     SetStdHandle (std_consts[fd], cygheap->fdtab[fd]->get_output_handle ());
 }
 
+void
+dtable::dec_console_fds ()
+{
+  if (console_fds > 0 && !--console_fds && myself->ctty != TTY_CONSOLE)
+    FreeConsole ();
+}
+
 int
 dtable::extend (int howmuch)
 {
@@ -146,8 +153,13 @@ dtable::release (int fd)
 {
   if (!not_open (fd))
     {
-      if ((fds[fd]->get_device () & FH_DEVMASK) == FH_SOCKET)
-        dec_need_fixup_before ();
+      switch (fds[fd]->get_device ())
+	{
+	case FH_SOCKET:
+	  dec_need_fixup_before ();
+	case FH_CONSOLE:
+	  dec_console_fds ();
+	}
       delete fds[fd];
       fds[fd] = NULL;
     }
@@ -261,6 +273,7 @@ dtable::build_fhandler (int fd, DWORD de
       case FH_CONIN:
       case FH_CONOUT:
 	fh = new (buf) fhandler_console (name);
+	inc_console_fds ();
 	break;
       case FH_PTYM:
 	fh = new (buf) fhandler_pty_master (name);
Index: dtable.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.h,v
retrieving revision 1.9
diff -u -p -r1.9 dtable.h
--- dtable.h	2001/06/24 22:26:50	1.9
+++ dtable.h	2001/07/10 13:29:32
@@ -19,10 +19,11 @@ class dtable
   fhandler_base **fds_on_hold;
   int first_fd_for_open;
   int cnt_need_fixup_before;
+  int console_fds;
 public:
   size_t size;
 
-  dtable () : first_fd_for_open(3), cnt_need_fixup_before(0) {}
+  dtable () : first_fd_for_open(3), cnt_need_fixup_before(0), console_fds(0) {}
   void init () {first_fd_for_open = 3;}
 
   void dec_need_fixup_before ()
@@ -31,6 +32,12 @@ public:
     { ++cnt_need_fixup_before; }
   BOOL need_fixup_before ()
     { return cnt_need_fixup_before > 0; }
+
+  void dec_console_fds ();
+  void inc_console_fds ()
+    { ++console_fds; }
+  BOOL has_console_fds ()
+    { return console_fds > 0; }
 
   int vfork_child_dup ();
   void vfork_parent_restore ();
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.91
diff -u -p -r1.91 exceptions.cc
--- exceptions.cc	2001/06/28 02:19:57	1.91
+++ exceptions.cc	2001/07/10 13:29:33
@@ -895,14 +895,20 @@ ctrl_c_handler (DWORD type)
   if (type == CTRL_LOGOFF_EVENT)
     return TRUE;
 
-  if ((type == CTRL_CLOSE_EVENT) || (type == CTRL_SHUTDOWN_EVENT))
-    /* Return FALSE to prevent an "End task" dialog box from appearing
-       for each Cygwin process window that's open when the computer
-       is shut down or console window is closed. */
+  /* Return FALSE to prevent an "End task" dialog box from appearing
+     for each Cygwin process window that's open when the computer
+     is shut down or console window is closed. */
+  if (type == CTRL_SHUTDOWN_EVENT)
     {
+      sig_send (NULL, SIGTERM);
+      return FALSE;
+    }
+  if (type == CTRL_CLOSE_EVENT)
+    {
       sig_send (NULL, SIGHUP);
       return FALSE;
     }
+
   tty_min *t = cygwin_shared->tty.get_tty (myself->ctty);
   /* Ignore this if we're not the process group lead since it should be handled
      *by* the process group leader. */

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  Center for Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
