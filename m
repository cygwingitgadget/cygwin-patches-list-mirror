Return-Path: <cygwin-patches-return-2055-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27128 invoked by alias); 14 Apr 2002 19:43:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27111 invoked from network); 14 Apr 2002 19:43:17 -0000
Message-Id: <3.0.5.32.20020414152944.007ec460@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com
Date: Sun, 14 Apr 2002 12:43:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Workaround patch for MS CLOSE_WAIT bug
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2002-q2/txt/msg00039.txt.bz2

The problem 
***********
What I want to fix is this
> netstat -an
  TCP    65.96.132.163:22       65.114.186.130:4762    CLOSE_WAIT
  TCP    65.96.132.163:22       65.114.186.130:1777    CLOSE_WAIT
  TCP    65.96.132.163:22       193.55.113.140:35861   CLOSE_WAIT
  TCP    65.96.132.163:25       204.127.198.37:40365   CLOSE_WAIT
  TCP    65.96.132.163:25       216.148.227.85:41320   CLOSE_WAIT
  TCP    65.96.132.163:110      65.114.186.130:4874    CLOSE_WAIT
<snip, it goes on>

Sockets stay in CLOSE_WAIT forever on Win 95/98/Me due to the bug
http://support.microsoft.com/default.aspx?scid=kb;EN-US;q229658
Please read that page to understand what follows.

Typical server application code looks like this:

sock = socket()
bind(sock)
listen(sock)
while (1) {
 select()
 newsock = accept(sock)
 pid = fork()
 if (pid == 0) { 
   close(sock)
   child works 
 }
 if (pid > 0) close(newsock)
}

Because newsock is closed in the parent before
being closed in the child, it stays in CLOSE_WAIT
until the parent exits. Not good in server applications.

Fixing the application
**********************
To keep sock open in the parent, the ported application 
structure can be changed to:

int oldsocks[2^32];  /* I'll be smarter */
sock = socket()     (1)
bind(sock)
listen(sock)
while (1) {
 select()
 newsock = accept(sock)
 pid = fork()
 if (pid == 0) { 
    close(sock)     (2)
    child works 
 }
 if (pid > 0) {
    oldsocks[pid] = newsock
                 <= (3)
 }
}
sigchild_handler()
{ 
  pid = waitpid()
  close(oldsocks[pid]) (4)
}

The itch is that oldsocks[pidA] remains open in the parent,
thus cygwin will duplicate it in a child pidB when there
is another accept() and fork(). 
The socket of pidA will then remain in CLOSE_WAIT if pidA 
terminates before pidB... Experience shows that CLOSE_WAIT can
occur even if pidB closes its copy (but does not terminate)
before pidA terminates.

Help from cygwin
****************
The itch can be cured by adding to cygwin a 
"close_on_fork" call and using it on line (3) above.
This "close_on_fork" applies only to sockets and simply
sets a flag. When the flag is set the socket is not 
duplicated in the parent and it is closed in the child 
(during fixups).

The easiest way to implement this is with fcntl(fd,F_SETCF,flag)
where "F_SETCF" is a newly defined command and "flag" is unused.
Calling it with non-socket fd's returns an error.

See Changelog and diffs below.

Related items
*************
Adding shutdown() before line (4) has also proved necessary
in some cases. Not sure why.
Weird behavior (details on request) can also be avoided by
"closing on fork" the main sock after line (1) and deleting
line (2).
In this situation the "linger on close" hack is unnecessary
and potentially harmful. 
I added a test in fhandler_socket::close().
 
I have ported two servers, exim (an MTA)and qpopper. 
With those fixes they seem to run fine on all Windows 
platforms I have tried (98, Me, NT).
inetd could be similarly patched (IMHO) but I don't 
find the Cygwin sources.

Similar CLOSE_WAIT issues have been reported with Apache
on Win2000.
http://sources.redhat.com/ml/cygwin/2001-10/msg01171.html
I have no idea if this patch can help there.

Problems with duplicate LISTEN have also been reported
by me and others
http://sources.redhat.com/ml/cygwin/2002-01/msg01579.html
http://sources.redhat.com/ml/cygwin/2002-04/msg00515.html
No progress there, it's mind boggling. My problem occurs 
only when the server re-execs itself while a child is 
running. "close on fork" doesn't seem to help.

Pierre

*************************************************************************
*************************************************************************
Changelog

2002-04-14  Pierre Humblet  <Pierre.Humblet@ieee.org>

	* fhandler.h: define FH_CLOFORK, set_close_on_fork_flag()
	and get_close_on_fork().
	* fhandler_socket.cc: (fhandler_socket::fcntl): Add FD_SETCF case.
	(fhandler_socket::close): test with get_close_on_fork().
	* dtable.cc: (dtable::fixup_before_fork) Handle close on fork.
	(dtable::fixup_after_fork) Ditto.

diff -ut ./dtable.cc ../dtable.cc
--- ./dtable.cc	Thu Apr 11 18:38:28 2002
+++ ../dtable.cc	Wed Apr 10 00:10:42 2002
@@ -534,7 +534,7 @@
   SetResourceLock (LOCK_FD_LIST, WRITE_LOCK | READ_LOCK, "fixup_before_fork");
   fhandler_base *fh;
   for (size_t i = 0; i < size; i++)
-    if ((fh = fds[i]) != NULL)
+    if ((fh = fds[i]) != NULL && !fh->get_close_on_fork ())
       {
         debug_printf ("fd %d (%s)", i, fh->get_name ());
         fh->fixup_before_fork_exec (target_proc_id);
@@ -585,15 +585,20 @@
   for (size_t i = 0; i < size; i++)
     if ((fh = fds[i]) != NULL)
       {
-        if (fh->get_close_on_exec () || fh->get_need_fork_fixup ())
-          {
-            debug_printf ("fd %d (%s)", i, fh->get_name ());
-            fh->fixup_after_fork (parent);
+        if (fh->get_close_on_fork())
+          release (i);
+        else
+          {
+            if (fh->get_close_on_exec () || fh->get_need_fork_fixup ())
+              {
+                debug_printf ("fd %d (%s)", i, fh->get_name ());
+                fh->fixup_after_fork (parent);
+              }
+            if (i == 0)
+              SetStdHandle (std_consts[i], fh->get_io_handle ());
+            else if (i <= 2)
+              SetStdHandle (std_consts[i], fh->get_output_handle ());
           }
-        if (i == 0)
-          SetStdHandle (std_consts[i], fh->get_io_handle ());
-        else if (i <= 2)
-          SetStdHandle (std_consts[i], fh->get_output_handle ());
       }
 }
 
diff -ut ./fhandler.h ../fhandler.h
--- ./fhandler.h	Sun Apr 14 14:19:00 2002
+++ ../fhandler.h	Sun Apr 14 14:21:22 2002
@@ -207,6 +207,10 @@
   bool get_close_on_exec () { return FHISSETF (CLOEXEC); }
   int set_close_on_exec_flag (int b) { return FHCONDSETF (b, CLOEXEC); }
 
+#define FH_CLOFORK (FH_FFIXUP|FH_W95LSBUG)
+  bool get_close_on_fork () { return FHISSETF (CLOFORK) == FH_CLOFORK; }
+  int set_close_on_fork_flag () { return FHSETF (CLOFORK); }
+
   LPSECURITY_ATTRIBUTES get_inheritance (bool all = 0)
   {
     if (all)
diff -ut ./fhandler_socket.cc ../fhandler_socket.cc
--- ./fhandler_socket.cc	Tue Apr  9 22:19:46 2002
+++ ../fhandler_socket.cc	Sun Apr 14 11:00:36 2002
@@ -349,7 +349,7 @@
   struct linger linger;
   linger.l_onoff = 1;
   linger.l_linger = 240; /* seconds. default 2MSL value according to MSDN. */
-  setsockopt (get_socket (), SOL_SOCKET, SO_LINGER,
+  if (!get_close_on_fork()) setsockopt (get_socket (), SOL_SOCKET, SO_LINGER,
               (const char *)&linger, sizeof linger);
 
   while ((res = closesocket (get_socket ())) != 0)
@@ -534,6 +534,9 @@
         set_flags ((get_flags () & ~O_NONBLOCK_MASK) | new_flags);
         break;
       }
+    case F_SETCF:
+      set_close_on_fork_flag ();
+      break;
     default:
       res = fhandler_base::fcntl (cmd, arg);
       break;


*************************************************************************
*************************************************************************
Changelog
2002-04-14  Pierre Humblet  <Pierre.Humblet@ieee.org>

	* libc/include/sys/fcntl.h: Define FD_SETCF flag.

--- ./fcntl.h.in  Mon Feb 25 10:16:32 2002
+++ ./fcntl.h     Sat Apr  6 06:56:42 2002
@@ -124,6 +124,9 @@
 #define        F_CNVT          12      /* Convert a fhandle to an open fd */
 #define        F_RSETLKW       13      /* Set or Clear remote record-lock(Blocking) */
 #endif /* !_POSIX_SOURCE */
+#ifdef __CYGWIN__
+#define        F_SETCF         14      /* Set close on fork, only for sockets */
+#endif
 
 /* fcntl(2) flags (l_type field of flock structure) */
 #define        F_RDLCK         1       /* read lock */

