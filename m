Return-Path: <cygwin-patches-return-4927-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21442 invoked by alias); 2 Sep 2004 22:26:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21344 invoked from network); 2 Sep 2004 22:25:56 -0000
From: "Bob Byrnes" <byrnes@curl.com>
Date: Thu, 02 Sep 2004 22:26:00 -0000
Organization: Curl Corporation
X-Address: 1 Cambridge Center, 10th Floor, Cambridge, MA 02142-1612
X-Phone: 617-761-1238
X-Fax: 617-761-1201
To: cygwin-patches@cygwin.com
Subject: [Patch] implementation of select for write on pipes
Message-Id: <20040902222555.07657E627@wildcard.curl.com>
X-SW-Source: 2004-q3/txt/msg00079.txt.bz2

The following patch implements select for write on pipes.  Currently,
pipes always select writable, which sometimes causes programs like
rsync to hang when the pipe is full.  This can be observed directly from
strace output:

    http://www.mail-archive.com/rsync@lists.samba.org/msg07559.html

We have been using this patch successfully for several months for
automated builds of our Windows products using Cygwin, so it has been
extensively tested.  It is the first of several patches that I plan to
contribute, all with the goal of preventing Cygwin hangs, and it does
seem to really improve the behavior of programs like rsync (and sshd)
that use select extensively with pipes.

The existing code uses PeekNamedPipe to implement select for read on
pipes.  For the corresponding write test, I used NtQueryInformationFile to
fill in a FILE_PIPE_LOCAL_INFORMATION struct, which contains OutboundQuota
and WriteQuotaAvailable fields that allow us to detect when the pipe is
full.  I fixed the signature and return value for NtQueryInformationFile
as well.

Unfortunately, NtQueryInformationFile isn't supported by Win9x, so we
optimistically assume the pipe is always writable on those systems (i.e.,
no change from the status quo).

NtQueryInformationFile also requires FILE_READ_ATTRIBUTES access on the
write side of the pipe, but CreatePipe doesn't set that (at least before
WinXP SP2), so I added a new create_selectable_pipe function to do the
right thing: it uses CreateNamedPipe for the read side, and CreateFile
for the write side (with FILE_READ_ATTRIBUTES).  It's important to only
allow a single pipe instance, to ensure that the named pipe was not
created earlier by some other process.  We retry if necessary until
we're sure that we really have a new pipe (unlikely to ever happen,
but it's nice to be bulletproof).

If we somehow inherit a (non-Cygwin) pipe without FILE_READ_ATTRIBUTES,
then NtQueryInformationFile will fail, and we again optimistically assume
that the pipe is writable in this case.

We also have to deal with Win9x, which doesn't support CreateNamedPipe,
so we just call CreatePipe on those systems to use an anonymous pipe as
the best approximation.

(As an aside, I couldn't help noticing that CreatePipe stupidly creates
a full duplex pipe, which is a waste, since only a single direction is
actually used.  We avoid that silliness with our named pipes.)

For a pipe to select writable, it must have at least PIPE_BUF bytes
available, to satisfy POSIX atomic write requirements.  Subsequent writes
with size > PIPE_BUF can still block, but most (all?) UNIX variants seem
to work this way.

For experimenting, we use the CYGWIN_PIPEBUFSIZE environment variable to
set the buffer size for pipes, with 4*PIPE_BUF == 16k as the (unchanged)
default.  We refuse to create a tiny pipe with size < PIPE_BUF, however,
to ensure that there will always be enough space for POSIX atomic writes.
If we somehow inherit a tiny (non-Cygwin) pipe, then we consider the
pipe writable only if it is completely empty, to minimize the probability
that a subsequent write will block.

--
Bob Byrnes
Curl Corporation
1 Cambridge Center, 10th Floor
Cambridge, MA 02142-1612

----------------------------------------

2004-09-02  Bob Byrnes  <byrnes@curl.com>

	* autoload.cc (NtQueryInformationFile): Return nonzero on error.
	* ntdll.h (FILE_PIPE_LOCAL_INFORMATION): Add.
	(NtQueryInformationFile): Fix types for last two arguments.
	* pipe.cc: Include stdlib.h, stdio.h, limits.h, and ntdll.h.
	(create_selectable_pipe): New function to create a pipe that can be
	used with NtQueryInformationFile for select.
	(fhandler_pipe::create): Call create_selectable_pipe instead of
	CreatePipe.
	(pipe): Use CYGWIN_PIPEBUFSIZE environment variable if defined, or
	DEFAULT_PIPEBUFSIZE otherwise.
	* select.cc: Include limits.h and ntdll.h.
	(peek_pipe): Add select_printf output.  Call NtQueryInformationFile to
	implement select for write on pipes.
	(fhandler_pipe::select_read): Reorder field assignments to be
	consistent with fhandler_pipe::select_write.
	(fhandler_pipe::select_write): Initialize startup, verify, cleanup, and
	write_ready fields for select_record.
	(fhandler_pipe::select_except): Tweak indentation to be consistent with
	fhandler_pipe::select_write.

----------------------------------------

Index: autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.86
diff -u -p -r1.86 autoload.cc
--- autoload.cc	24 Jul 2004 09:41:34 -0000	1.86
+++ autoload.cc	2 Sep 2004 22:06:11 -0000
@@ -379,7 +379,7 @@ LoadDLLfuncEx (NtCreateToken, 52, ntdll,
 LoadDLLfuncEx (NtMapViewOfSection, 40, ntdll, 1)
 LoadDLLfuncEx (NtOpenFile, 24, ntdll, 1)
 LoadDLLfuncEx (NtOpenSection, 12, ntdll, 1)
-LoadDLLfuncEx (NtQueryInformationFile, 20, ntdll, 1)
+LoadDLLfuncEx2 (NtQueryInformationFile, 20, ntdll, 1, 1)
 LoadDLLfuncEx (NtQueryInformationProcess, 20, ntdll, 1)
 LoadDLLfuncEx2 (NtQueryObject, 20, ntdll, 1, 1)
 LoadDLLfuncEx (NtQuerySystemInformation, 16, ntdll, 1)
Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.24
diff -u -p -r1.24 ntdll.h
--- ntdll.h	3 Jun 2004 21:29:43 -0000	1.24
+++ ntdll.h	2 Sep 2004 22:06:11 -0000
@@ -358,6 +358,19 @@ typedef struct _FILE_NAME_INFORMATION
   WCHAR FileName[MAX_PATH + 100];
 } FILE_NAME_INFORMATION;
 
+typedef struct _FILE_PIPE_LOCAL_INFORMATION {
+  ULONG NamedPipeType;
+  ULONG NamedPipeConfiguration;
+  ULONG MaximumInstances;
+  ULONG CurrentInstances;
+  ULONG InboundQuota;
+  ULONG ReadDataAvailable;
+  ULONG OutboundQuota;
+  ULONG WriteQuotaAvailable;
+  ULONG NamedPipeState;
+  ULONG NamedPipeEnd;
+} FILE_PIPE_LOCAL_INFORMATION, *PFILE_PIPE_LOCAL_INFORMATION;
+
 typedef struct _FILE_COMPRESSION_INFORMATION
 {
   LARGE_INTEGER CompressedSize;
@@ -369,6 +382,7 @@ typedef struct _FILE_COMPRESSION_INFORMA
 
 typedef enum _FILE_INFORMATION_CLASS
 {
+  FilePipeLocalInformation = 24,
   FileCompressionInformation = 28
 } FILE_INFORMATION_CLASS, *PFILE_INFORMATION_CLASS;
 
@@ -404,7 +418,7 @@ extern "C"
 			     PIO_STATUS_BLOCK, ULONG, ULONG);
   NTSTATUS NTAPI NtOpenSection (PHANDLE, ACCESS_MASK, POBJECT_ATTRIBUTES);
   NTSTATUS NTAPI NtQueryInformationFile (HANDLE, IO_STATUS_BLOCK *, VOID *,
-					 DWORD, DWORD);
+					 ULONG, FILE_INFORMATION_CLASS);
   NTSTATUS NTAPI NtQueryInformationProcess (HANDLE, PROCESSINFOCLASS,
 					    PVOID, ULONG, PULONG);
   NTSTATUS NTAPI NtQueryObject (HANDLE, OBJECT_INFORMATION_CLASS, VOID *,
Index: pipe.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pipe.cc,v
retrieving revision 1.61
diff -u -p -r1.61 pipe.cc
--- pipe.cc	10 Apr 2004 13:45:10 -0000	1.61
+++ pipe.cc	2 Sep 2004 22:06:11 -0000
@@ -12,7 +12,10 @@ details. */
 
 #include "winsup.h"
 #include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
 #include <sys/socket.h>
+#include <limits.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "path.h"
@@ -22,6 +25,7 @@ details. */
 #include "thread.h"
 #include "pinfo.h"
 #include "cygthread.h"
+#include "ntdll.h"
 
 static unsigned pipecount;
 static const NO_COPY char pipeid_fmt[] = "stupid_pipe.%u.%u";
@@ -211,15 +215,139 @@ leave:
   return res;
 }
 
+/* Create a pipe, and return handles to the read and write ends,
+   just like CreatePipe, but ensure that the write end permits
+   FILE_READ_ATTRIBUTES access, on later versions of win32 where
+   this is supported.  This access is needed by NtQueryInformationFile,
+   which is used to implement select and nonblocking writes.
+   Note that the return value is either NO_ERROR or GetLastError,
+   unlike CreatePipe, which returns a bool for success or failure.  */
+static int
+create_selectable_pipe (PHANDLE read_pipe_ptr,
+                        PHANDLE write_pipe_ptr,
+                        LPSECURITY_ATTRIBUTES sa_ptr,
+                        DWORD psize)
+{
+  /* Default to error. */
+  *read_pipe_ptr = *write_pipe_ptr = INVALID_HANDLE_VALUE;
+
+  HANDLE read_pipe = INVALID_HANDLE_VALUE, write_pipe = INVALID_HANDLE_VALUE;
+
+  /* Ensure that there is enough pipe buffer space for atomic writes.  */
+  if (psize < PIPE_BUF)
+    psize = PIPE_BUF;
+
+  char pipename[CYG_MAX_PATH];
+
+  /* Retry CreateNamedPipe as long as the pipe name is in use.
+     Retrying will probably never be necessary, but we want
+     to be as robust as possible.  */
+  while (1)
+    {
+      static volatile LONG pipe_unique_id;
+
+      snprintf (pipename, sizeof pipename, "\\\\.\\pipe\\cygwin-%d-%ld",
+                getpid (), InterlockedIncrement ((LONG *)&pipe_unique_id));
+
+      debug_printf ("CreateNamedPipe: name = %s, size = %lu", pipename, psize);
+
+      /* Use CreateNamedPipe instead of CreatePipe, because the latter
+         returns a write handle that does not permit FILE_READ_ATTRIBUTES
+         access, on versions of win32 earlier than WinXP SP2.
+         CreatePipe also stupidly creates a full duplex pipe, which is
+         a waste, since only a single direction is actually used.
+         It's important to only allow a single instance, to ensure that
+         the pipe was not created earlier by some other process, even if
+         the pid has been reused.  We avoid FILE_FLAG_FIRST_PIPE_INSTANCE
+         because that is only available for Win2k SP2 and WinXP.  */
+      read_pipe = CreateNamedPipe (pipename,
+                                   PIPE_ACCESS_INBOUND,
+                                   PIPE_TYPE_BYTE | PIPE_READMODE_BYTE,
+                                   1,       /* max instances */
+                                   psize,   /* output buffer size */
+                                   psize,   /* input buffer size */
+                                   NMPWAIT_USE_DEFAULT_WAIT,
+                                   sa_ptr);
+
+      if (read_pipe != INVALID_HANDLE_VALUE)
+        {
+          debug_printf ("pipe read handle = %p", read_pipe);
+          break;
+        }
+
+      DWORD err = GetLastError ();
+      switch (err)
+        {
+        case ERROR_PIPE_BUSY:
+          /* The pipe is already open with compatible parameters.
+             Pick a new name and retry.  */
+          debug_printf ("pipe busy, retrying");
+          continue;
+        case ERROR_ACCESS_DENIED:
+          /* The pipe is already open with incompatible parameters.
+             Pick a new name and retry.  */
+          debug_printf ("pipe access denied, retrying");
+          continue;
+        case ERROR_CALL_NOT_IMPLEMENTED:
+          /* We are on an older Win9x platform without named pipes.
+             Return an anonymous pipe as the best approximation.  */
+          debug_printf ("CreateNamedPipe not implemented, resorting to "
+                        "CreatePipe: size = %lu", psize);
+          if (CreatePipe (read_pipe_ptr, write_pipe_ptr, sa_ptr, psize))
+            {
+              debug_printf ("pipe read handle = %p", *read_pipe_ptr);
+              debug_printf ("pipe write handle = %p", *write_pipe_ptr);
+              return NO_ERROR;
+            }
+          err = GetLastError ();
+          debug_printf ("CreatePipe failed: %E");
+          return err;
+        default:
+          debug_printf ("CreateNamedPipe failed: %E");
+          return err;
+        }
+      /* NOTREACHED */
+    }
+
+  debug_printf ("CreateFile: name = %s", pipename);
+
+  /* Open the named pipe for writing.
+     Be sure to permit FILE_READ_ATTRIBUTES access.  */
+  write_pipe = CreateFile (pipename,
+                           GENERIC_WRITE | FILE_READ_ATTRIBUTES,
+                           0,       /* share mode */
+                           sa_ptr,
+                           OPEN_EXISTING,
+                           0,       /* flags and attributes */
+                           0);      /* handle to template file */
+
+  if (write_pipe == INVALID_HANDLE_VALUE)
+    {
+      /* Failure. */
+      DWORD err = GetLastError ();
+      debug_printf ("CreateFile failed: %E");
+      CloseHandle (read_pipe);
+      return err;
+    }
+
+  debug_printf ("pipe write handle = %p", write_pipe);
+
+  /* Success. */
+  *read_pipe_ptr = read_pipe;
+  *write_pipe_ptr = write_pipe;
+  return NO_ERROR;
+}
+
 int
 fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode, bool fifo)
 {
   HANDLE r, w;
   SECURITY_ATTRIBUTES *sa = (mode & O_NOINHERIT) ?  &sec_none_nih : &sec_none;
   int res = -1;
+  int ret;
 
-  if (!CreatePipe (&r, &w, sa, psize))
-    __seterrno ();
+  if ((ret = create_selectable_pipe (&r, &w, sa, psize)) != NO_ERROR)
+    __seterrno_from_win_error (ret);
   else
     {
       fhs[0] = (fhandler_pipe *) build_fh_dev (*piper_dev);
@@ -282,12 +410,22 @@ fhandler_pipe::ioctl (unsigned int cmd, 
   return 0;
 }
 
+#define DEFAULT_PIPEBUFSIZE (4*PIPE_BUF)
+
 extern "C" int
 pipe (int filedes[2])
 {
   extern DWORD binmode;
   fhandler_pipe *fhs[2];
-  int res = fhandler_pipe::create (fhs, 16384, (!binmode || binmode == O_BINARY)
+  static unsigned int psize = 0;
+  if (psize == 0)
+    {
+      char buf[80];
+      psize = GetEnvironmentVariable ("CYGWIN_PIPEBUFSIZE", buf, sizeof (buf))
+                ? (unsigned int) atoi (buf) : DEFAULT_PIPEBUFSIZE;
+      debug_printf ("pipe buffer size == %u", psize);
+    }
+  int res = fhandler_pipe::create (fhs, psize, (!binmode || binmode == O_BINARY)
 					       ? O_BINARY : O_TEXT);
   if (res == 0)
     {
Index: select.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/select.cc,v
retrieving revision 1.94
diff -u -p -r1.94 select.cc
--- select.cc	10 Aug 2004 15:05:37 -0000	1.94
+++ select.cc	2 Sep 2004 22:06:12 -0000
@@ -29,6 +29,7 @@ details. */
 #include <netdb.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <limits.h>
 #define USE_SYS_TYPES_FD_SET
 #include <winsock.h>
 #include "select.h"
@@ -42,6 +43,7 @@ details. */
 #include "perthread.h"
 #include "tty.h"
 #include "cygthread.h"
+#include "ntdll.h"
 
 /*
  * All these defines below should be in sys/types.h
@@ -419,7 +421,7 @@ peek_pipe (select_record *s, bool from_s
     {
       if (s->read_ready)
 	{
-	  select_printf ("already ready");
+	  select_printf ("%s, already ready for read", fh->get_name ());
 	  gotone = 1;
 	  goto out;
 	}
@@ -451,7 +453,10 @@ peek_pipe (select_record *s, bool from_s
     }
 
   if (fh->get_device () == FH_PIPEW)
-    /* nothing */;
+    {
+      select_printf ("%s, select for read/except on write end of pipe",
+                     fh->get_name ());
+    }
   else if (!PeekNamedPipe (h, NULL, 0, NULL, (DWORD *) &n, NULL))
     {
       select_printf ("%s, PeekNamedPipe failed, %E", fh->get_name ());
@@ -489,21 +494,84 @@ peek_pipe (select_record *s, bool from_s
     }
   if (n > 0 && s->read_selected)
     {
-      select_printf ("%s, ready for read", fh->get_name ());
+      select_printf ("%s, ready for read: avail = %d", fh->get_name (), n);
       gotone += s->read_ready = true;
     }
   if (!gotone && s->fh->hit_eof ())
     {
       select_printf ("%s, saw EOF", fh->get_name ());
       if (s->except_selected)
-	gotone = s->except_ready = true;
+	gotone += s->except_ready = true;
       if (s->read_selected)
 	gotone += s->read_ready = true;
-      select_printf ("saw eof on '%s'", fh->get_name ());
     }
 
 out:
-  return gotone || s->write_ready;
+  if (s->write_selected)
+    {
+      if (s->write_ready)
+        {
+          select_printf ("%s, already ready for write", fh->get_name ());
+          gotone++;
+        }
+      /* Do we need to do anything about SIGTTOU here? */
+      else if (fh->get_device () == FH_PIPER)
+        {
+          select_printf ("%s, select for write on read end of pipe",
+                         fh->get_name ());
+        }
+      else
+        {
+          /* We don't worry about the guard mutex, because that only applies
+             when from_select is false, and peek_pipe is never called that
+             way for writes.  */
+
+          IO_STATUS_BLOCK iosb = { 0 };
+          FILE_PIPE_LOCAL_INFORMATION fpli = { 0 };
+
+          if (NtQueryInformationFile (h,
+                                      &iosb,
+                                      &fpli,
+                                      sizeof (fpli),
+                                      FilePipeLocalInformation))
+            {
+              /* If NtQueryInformationFile fails, optimistically assume the
+                 pipe is writable.  This could happen on Win9x, because
+                 NtQueryInformationFile is not available, or if we somehow
+                 inherit a pipe that doesn't permit FILE_READ_ATTRIBUTES
+                 access on the write end.  */
+              select_printf ("%s, NtQueryInformationFile failed",
+                             fh->get_name ());
+              gotone += s->write_ready = true;
+            }
+          /* Ensure that enough space is available for atomic writes,
+             as required by POSIX.  Subsequent writes with size > PIPE_BUF
+             can still block, but most (all?) UNIX variants seem to work
+             this way (e.g., BSD, Linux, Solaris).  */
+          else if (fpli.WriteQuotaAvailable >= PIPE_BUF)
+            {
+              select_printf ("%s, ready for write: size = %lu, avail = %lu",
+                             fh->get_name (),
+                             fpli.OutboundQuota,
+                             fpli.WriteQuotaAvailable);
+              gotone += s->write_ready = true;
+            }
+          /* If we somehow inherit a tiny pipe (size < PIPE_BUF), then consider
+             the pipe writable only if it is completely empty, to minimize the
+             probability that a subsequent write will block.  */
+          else if (fpli.OutboundQuota < PIPE_BUF &&
+                   fpli.WriteQuotaAvailable == fpli.OutboundQuota)
+            {
+              select_printf ("%s, tiny pipe: size = %lu, avail = %lu",
+                             fh->get_name (),
+                             fpli.OutboundQuota,
+                             fpli.WriteQuotaAvailable);
+              gotone += s->write_ready = true;
+            }
+        }
+    }
+
+  return gotone;
 }
 
 static int start_thread_pipe (select_record *me, select_stuff *stuff);
@@ -603,9 +671,9 @@ fhandler_pipe::select_read (select_recor
   s->startup = start_thread_pipe;
   s->peek = peek_pipe;
   s->verify = verify_ok;
+  s->cleanup = pipe_cleanup;
   s->read_selected = true;
   s->read_ready = false;
-  s->cleanup = pipe_cleanup;
   return s;
 }
 
@@ -613,14 +681,13 @@ select_record *
 fhandler_pipe::select_write (select_record *s)
 {
   if (!s)
-    {
-      s = new select_record;
-      s->startup = no_startup;
-      s->verify = no_verify;
-    }
+    s = new select_record;
+  s->startup = start_thread_pipe;
   s->peek = peek_pipe;
+  s->verify = verify_ok;
+  s->cleanup = pipe_cleanup;
   s->write_selected = true;
-  s->write_ready = true;
+  s->write_ready = false;
   return s;
 }
 
@@ -628,7 +695,7 @@ select_record *
 fhandler_pipe::select_except (select_record *s)
 {
   if (!s)
-      s = new select_record;
+    s = new select_record;
   s->startup = start_thread_pipe;
   s->peek = peek_pipe;
   s->verify = verify_ok;
