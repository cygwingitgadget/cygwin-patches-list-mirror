From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: rxvt pops up console with 2001-Aug-07 shapshot
Date: Thu, 23 Aug 2001 16:23:00 -0000
Message-id: <s1sg0aicqdh.fsf@jaist.ac.jp>
References: <4268681989.20010822182438@logos-m.ru> <s1sbsl7hp0u.fsf@jaist.ac.jp> <20010823103544.H20320@cygbert.vinschen.de> <s1sheuycxbu.fsf@jaist.ac.jp>
X-SW-Source: 2001-q3/msg00085.html

>>> On 24 Aug 2001 05:53:25 +0900
>>> Kazuhiro Fujieda <fujieda@jaist.ac.jp> said:

> I have another idea:
> 
> If the process has a pty slave, setsid() shouldn't call
> FreeConsole() because it has a chance to execute Windows
> application on the pty.
> 
> I will try it later.

I've done.
The following patch can solve the problem indicated by the subject.

2001-08-24  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* syscalls.cc (check_tty_fds): New function. Check whether there
	is a fd referring to pty slave.
	(setsid): Don't detach console if the process has a pty slave.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.138
diff -u -p -r1.138 syscalls.cc
--- syscalls.cc	2001/08/23 02:27:01	1.138
+++ syscalls.cc	2001/08/23 23:04:41
@@ -65,6 +65,22 @@ close_all_files (void)
   cygwin_shared->delqueue.process_queue ();
 }
 
+static BOOL __stdcall
+check_ttys_fds (void)
+{
+  int res = FALSE;
+  SetResourceLock (LOCK_FD_LIST, WRITE_LOCK | READ_LOCK, "close_all_files");
+  fhandler_base *fh;
+  for (int i = 0; i < (int) cygheap->fdtab.size; i++)
+    if ((fh = cygheap->fdtab[i]) != NULL && fh->get_device() == FH_TTYS)
+      {
+	res = TRUE;
+	break;
+      }
+  ReleaseResourceLock (LOCK_FD_LIST, WRITE_LOCK | READ_LOCK, "close_all_files");
+  return res;
+}
+
 extern "C" int
 _unlink (const char *ourname)
 {
@@ -240,7 +256,9 @@ setsid (void)
   /* FIXME: for now */
   if (myself->pgid != _getpid ())
     {
-      if (myself->ctty == TTY_CONSOLE && !cygheap->fdtab.has_console_fds ())
+      if (myself->ctty == TTY_CONSOLE &&
+	  !cygheap->fdtab.has_console_fds () &&
+	  !check_ttys_fds ())
 	FreeConsole ();
       myself->ctty = -1;
       myself->sid = _getpid ();

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  Center for Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
