Return-Path: <cygwin-patches-return-4932-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13099 invoked by alias); 7 Sep 2004 19:51:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13063 invoked from network); 7 Sep 2004 19:51:49 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Tue, 07 Sep 2004 19:51:00 -0000
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: [Patch] implementation of nonblocking writes on pipes
Message-Id: <20040907195148.9F797E5C1@wildcard.curl.com>
X-SW-Source: 2004-q3/txt/msg00084.txt.bz2

The following patch implements nonblocking writes on pipes.  Currently,
pipes ignore the O_NONBLOCK flag for writing, and programs like sshd or
rsync that use nonblocking I/O heavily can hang when writes unexpectedly
block.

This patch is similar to (and relies on) my previous patch to implement
select for write on pipes.  We have been using this for several months
for automated builds of our Windows products, and it does seem to help
prevent Cygwin hangs.

The existing code uses PeekNamedPipe to check for available data
before attempting nonblocking reads, with a guard mutex to ensure
that the data is not stolen by some other thread between the initial
PeekNamedPipe and the subsequent read.  For nonblocking writes, I used
NtQueryInformationFile to check for available space before writing,
with a similar guard mutex.

As for select, since NtQueryInformationFile isn't supported by Win9x, we
optimistically assume that we can transfer some data without blocking on
those systems (i.e., no change from the status quo).  We punt in the same
way if NtQueryInformationFile fails because we have somehow inherited a
(non-Cygwin) pipe without FILE_READ_ATTRIBUTES.

POSIX rules for nonblocking writes on pipes are a bit complicated;
I haved tried to annotate the code with comments from the spec.  If we
somehow inherit a tiny (non-Cygwin) pipe with size < PIPE_BUF, then we
try to do partial writes, as POSIX mandates for writes of size > PIPE_BUF.

--
Bob Byrnes
Curl Corporation
1 Cambridge Center, 10th Floor
Cambridge, MA 02142-1612

----------------------------------------

2004-09-07  Bob Byrnes  <byrnes@curl.com>

	* fhandler.h (class fhandler_pipe): Add write method.
	* pipe.cc (fhandler_pipe::write): New method to handle nonblocking
	writes on pipes using NtQueryInformationFile and a guard mutex.
	(fhandler_pipe::create): Create guard mutex for write side of pipe.

----------------------------------------

Index: fhandler.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.211
diff -u -p -r1.211 fhandler.h
--- fhandler.h	17 Aug 2004 09:52:50 -0000	1.211
+++ fhandler.h	7 Sep 2004 16:23:35 -0000
@@ -434,6 +434,7 @@ public:
   select_record *select_except (select_record *s);
   void set_close_on_exec (bool val);
   void __stdcall read (void *ptr, size_t& len) __attribute__ ((regparm (3)));
+  int write (const void *ptr, size_t len);
   int close ();
   void create_guard (SECURITY_ATTRIBUTES *sa) {guard = CreateMutex (sa, FALSE, NULL);}
   int dup (fhandler_base *child);
Index: pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.62
diff -u -p -r1.62 pipe.cc
--- pipe.cc	3 Sep 2004 01:32:02 -0000	1.62
+++ pipe.cc	7 Sep 2004 16:23:35 -0000
@@ -86,6 +86,130 @@ fhandler_pipe::read (void *in_ptr, size_
 }
 
 int
+fhandler_pipe::write (const void *ptr, size_t len)
+{
+  /* Perform standard blocking writes without further ado. */
+  if (!is_nonblocking ())
+    return fhandler_base::write (ptr, len);
+
+  if (guard == NULL)
+    {
+      debug_printf ("no guard mutex");
+      set_errno (ENXIO);
+      return -1;
+    }
+
+  if (WaitForSingleObject (guard, 0) != WAIT_OBJECT_0)
+    {
+      debug_printf ("couldn't get mutex %p, %E", guard);
+      set_errno (EAGAIN);
+      return -1;
+    }
+
+  bool transfer;        /* Can we transfer any data? */
+
+  IO_STATUS_BLOCK iosb = {0};
+  FILE_PIPE_LOCAL_INFORMATION fpli = {0};
+
+  if (NtQueryInformationFile (get_handle (),
+                              &iosb,
+                              &fpli,
+                              sizeof (fpli),
+                              FilePipeLocalInformation))
+    {
+      /* If NtQueryInformationFile fails, optimistically assume that we
+         can transfer some data without blocking.  The failure could happen
+         on Win9x, because NtQueryInformationFile is not available, or if
+         we somehow inherit a pipe that doesn't permit FILE_READ_ATTRIBUTES
+         access on the write end.  */
+      debug_printf ("NtQueryInformationFile failed");
+      transfer = true;
+    }
+  else if (fpli.OutboundQuota >= PIPE_BUF && len <= PIPE_BUF)
+    {
+      /* If the pipe is large enough (size >= PIPE_BUF), then obey the
+         POSIX atomic write requirements; the quoted comments below are
+         from the POSIX spec for nonblocking writes to pipes:
+         "A write request for PIPE_BUF or fewer bytes shall either ..." */
+      if (len <= fpli.WriteQuotaAvailable)
+        {
+          /* "If there is sufficient space available in the pipe, transfer
+             all the data and return the number of bytes requested." */
+          debug_printf ("sufficient space for full nonblocking write: "
+                        "size %lu, avail %lu, len %u",
+                        fpli.OutboundQuota,
+                        fpli.WriteQuotaAvailable,
+                        len);
+          transfer = true;
+        }
+      else
+        {
+          /* "If there is not sufficient space available in the pipe,
+             transfer no data and return -1 with errno set to EAGAIN." */
+          debug_printf ("insufficient space for full nonblocking write: "
+                        "size %lu, avail %lu, len %u",
+                        fpli.OutboundQuota,
+                        fpli.WriteQuotaAvailable,
+                        len);
+          transfer = false;
+        }
+    }
+  else
+    {
+      /* If we somehow inherit a tiny pipe (size < PIPE_BUF), then ignore
+         the POSIX atomic write requirements, or, according to POSIX:
+         "A write request for more than PIPE_BUF bytes shall either ..." */
+      if (fpli.WriteQuotaAvailable > 0)
+        {
+          /* "When at least one byte can be written, transfer what it can
+             and return the number of bytes written." */
+          debug_printf ("some space for nonblocking write: "
+                        "size %lu, avail %lu, len %u",
+                        fpli.OutboundQuota,
+                        fpli.WriteQuotaAvailable,
+                        len);
+
+          if (len > fpli.WriteQuotaAvailable)
+            {
+              debug_printf ("truncated write to avoid blocking: %lu < %u",
+                            fpli.WriteQuotaAvailable,
+                            len);
+              len = fpli.WriteQuotaAvailable;
+            }
+
+          transfer = true;
+        }
+      else
+        {
+          /* "When no data can be written, transfer no data and
+             return -1 with errno set to EAGAIN." */
+          debug_printf ("no space for nonblocking write: "
+                        "size %lu, avail %lu, len %u",
+                        fpli.OutboundQuota,
+                        fpli.WriteQuotaAvailable,
+                        len);
+          transfer = false;
+        }
+    }
+
+  int ret;
+
+  if (transfer)
+    ret = fhandler_base::write (ptr, len);
+  else
+    {
+      set_errno (EAGAIN);
+      ret = -1;
+    }
+
+  (void) ReleaseMutex (guard);
+
+  return ret;
+}
+
+int
 fhandler_pipe::close ()
 {
   if (guard)
@@ -367,6 +491,7 @@ fhandler_pipe::create (fhandler_pipe *fh
 
       res = 0;
       fhs[0]->create_guard (sa);
+      fhs[1]->create_guard (sa);
       if (wincap.has_unreliable_pipes ())
 	{
 	  char buf[80];
