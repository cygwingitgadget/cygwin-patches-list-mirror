From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Make Cygwin damons easier to use on Win9x.
Date: Tue, 26 Jun 2001 07:44:00 -0000
Message-id: <s1sithjcndc.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00340.html

The following patch makes Cygwin daemons more easier to use on Win9x.
It allows daemons run without their console window and terminate
silently without annoying us with the "End task" dialog twice.

My patch against syscalls.cc isn't perfect. It doesn't consider the
case where an application run on the tty mode or re-attach the
console as its controlling terminal. But it works well practically.

2001-06-26  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* syscalls.cc (setsid): Detach process from its console if
	the current controlling terminal is the console device.
	* exception.cc (ctrl_c_handler): Send SIGTERM to myself when catch
	CTRL_LOGOFF_EVENT.

Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.120
diff -u -p -r1.120 syscalls.cc
--- syscalls.cc	2001/06/05 10:45:52	1.120
+++ syscalls.cc	2001/06/08 14:57:12
@@ -214,6 +214,8 @@ setsid (void)
   /* FIXME: for now */
   if (myself->pgid != _getpid ())
     {
+      if (myself->ctty == TTY_CONSOLE)
+	FreeConsole ();
       myself->ctty = -1;
       myself->sid = _getpid ();
       myself->pgid = _getpid ();

Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.90
diff -u -p -r1.90 exceptions.cc
--- exceptions.cc	2001/06/24 22:26:50	1.90
+++ exceptions.cc	2001/06/26 13:13:57
@@ -893,7 +893,10 @@ static BOOL WINAPI
 ctrl_c_handler (DWORD type)
 {
   if (type == CTRL_LOGOFF_EVENT)
-    return TRUE;
+    {
+      sig_send (NULL, SIGTERM);
+      return FALSE;
+    }
 
   if ((type == CTRL_CLOSE_EVENT) || (type == CTRL_SHUTDOWN_EVENT))
     /* Return FALSE to prevent an "End task" dialog box from appearing

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
