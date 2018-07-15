Return-Path: <cygwin-patches-return-9116-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52088 invoked by alias); 15 Jul 2018 08:20:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52050 invoked by uid 89); 15 Jul 2018 08:20:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-23.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=attr, AIO, aio, wired
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Jul 2018 08:20:52 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6F8KowJ071066;	Sun, 15 Jul 2018 01:20:50 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdL3f6HG; Sun Jul 15 01:20:45 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3 2/3] POSIX Asynchronous I/O support: fhandler files
Date: Sun, 15 Jul 2018 08:20:00 -0000
Message-Id: <20180715082025.4920-3-mark@maxrnd.com>
In-Reply-To: <20180715082025.4920-1-mark@maxrnd.com>
References: <20180715082025.4920-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00011.txt.bz2

This code is where the AIO implementation is wired into existing Cygwin
mechanisms for file and device I/O: the fhandler* functions.  It makes
use of an existing internal routine prw_open to supply a "shadow fd"
that permits asynchronous operations on a file the user app accesses
via its own fd.  This allows AIO to read or write at arbitrary locations
within a file without disturbing the app's file pointer.  (This was
already the case with normal pread|pwrite; we're just adding "async"
to the mix.)
---
 winsup/cygwin/fhandler.cc           |   4 +-
 winsup/cygwin/fhandler.h            |  11 +--
 winsup/cygwin/fhandler_disk_file.cc | 115 +++++++++++++++++++++-------
 winsup/cygwin/fhandler_tty.cc       |   2 +-
 4 files changed, 95 insertions(+), 37 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 45ae1ad97..ded12cc44 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1097,14 +1097,14 @@ fhandler_base::lseek (off_t offset, int whence)
 }
 
 ssize_t __reg3
-fhandler_base::pread (void *, size_t, off_t)
+fhandler_base::pread (void *, size_t, off_t, void *)
 {
   set_errno (ESPIPE);
   return -1;
 }
 
 ssize_t __reg3
-fhandler_base::pwrite (void *, size_t, off_t)
+fhandler_base::pwrite (void *, size_t, off_t, void *)
 {
   set_errno (ESPIPE);
   return -1;
diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 88653b6e9..b946dddf4 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -380,8 +380,8 @@ public:
   virtual ssize_t __stdcall write (const void *ptr, size_t len);
   virtual ssize_t __stdcall readv (const struct iovec *, int iovcnt, ssize_t tot = -1);
   virtual ssize_t __stdcall writev (const struct iovec *, int iovcnt, ssize_t tot = -1);
-  virtual ssize_t __reg3 pread (void *, size_t, off_t);
-  virtual ssize_t __reg3 pwrite (void *, size_t, off_t);
+  virtual ssize_t __reg3 pread (void *, size_t, off_t, void *aio = NULL);
+  virtual ssize_t __reg3 pwrite (void *, size_t, off_t, void *aio = NULL);
   virtual off_t lseek (off_t offset, int whence);
   virtual int lock (int, struct flock *);
   virtual int mand_lock (int, struct flock *);
@@ -1430,9 +1430,10 @@ class fhandler_dev_tape: public fhandler_dev_raw
 class fhandler_disk_file: public fhandler_base
 {
   HANDLE prw_handle;
+  bool prw_handle_isasync;
   int __reg3 readdir_helper (DIR *, dirent *, DWORD, DWORD, PUNICODE_STRING fname);
 
-  int prw_open (bool);
+  int prw_open (bool, void *);
 
  public:
   fhandler_disk_file ();
@@ -1473,8 +1474,8 @@ class fhandler_disk_file: public fhandler_base
   void rewinddir (DIR *);
   int closedir (DIR *);
 
-  ssize_t __reg3 pread (void *, size_t, off_t);
-  ssize_t __reg3 pwrite (void *, size_t, off_t);
+  ssize_t __reg3 pread (void *, size_t, off_t, void *aio = NULL);
+  ssize_t __reg3 pwrite (void *, size_t, off_t, void *aio = NULL);
 
   fhandler_disk_file (void *) {}
   dev_t get_dev () { return pc.fs_serial_number (); }
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index fc87d91c1..ebd83f8ae 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -24,6 +24,7 @@ details. */
 #include "tls_pbuf.h"
 #include "devices.h"
 #include "ldap.h"
+#include <aio.h>
 
 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -1511,39 +1512,48 @@ fhandler_base::open_fs (int flags, mode_t mode)
    parameter to the latter. */
 
 int
-fhandler_disk_file::prw_open (bool write)
+fhandler_disk_file::prw_open (bool write, void *aio)
 {
   NTSTATUS status;
   IO_STATUS_BLOCK io;
   OBJECT_ATTRIBUTES attr;
+  ULONG options = get_options ();
+
+  /* If async i/o is intended, turn off the default synchronous operation */
+  if (aio)
+    options &= ~FILE_SYNCHRONOUS_IO_NONALERT;
 
   /* First try to open with the original access mask */
   ACCESS_MASK access = get_access ();
   status = NtOpenFile (&prw_handle, access,
 		       pc.init_reopen_attr (attr, get_handle ()), &io,
-		       FILE_SHARE_VALID_FLAGS, get_options ());
+		       FILE_SHARE_VALID_FLAGS, options);
   if (status == STATUS_ACCESS_DENIED)
     {
       /* If we get an access denied, chmod has been called.  Try again
 	 with just the required rights to perform the called function. */
       access &= write ? ~GENERIC_READ : ~GENERIC_WRITE;
       status = NtOpenFile (&prw_handle, access, &attr, &io,
-			   FILE_SHARE_VALID_FLAGS, get_options ());
+			   FILE_SHARE_VALID_FLAGS, options);
     }
   debug_printf ("%y = NtOpenFile (%p, %y, %S, io, %y, %y)",
 		status, prw_handle, access, pc.get_nt_native_path (),
-		FILE_SHARE_VALID_FLAGS, get_options ());
+		FILE_SHARE_VALID_FLAGS, options);
   if (!NT_SUCCESS (status))
     {
       __seterrno_from_nt_status (status);
       return -1;
     }
+
+  /* record prw_handle's asyncness for subsequent pread/pwrite operations */
+  prw_handle_isasync = !!aio;
   return 0;
 }
 
 ssize_t __reg3
-fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
+fhandler_disk_file::pread (void *buf, size_t count, off_t offset, void *aio)
 {
+  struct aiocb *aiocb = (struct aiocb *) aio;
   ssize_t res;
 
   if ((get_flags () & O_ACCMODE) == O_WRONLY)
@@ -1561,10 +1571,18 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
       IO_STATUS_BLOCK io;
       LARGE_INTEGER off = { QuadPart:offset };
 
-      if (!prw_handle && prw_open (false))
+      /* If existing prw_handle asyncness doesn't match this call's, re-open */
+      if (prw_handle && (prw_handle_isasync != !!aio))
+	NtClose (prw_handle), prw_handle = NULL;
+
+      if (!prw_handle && prw_open (false, aio))
 	goto non_atomic;
-      status = NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,
-			   &off, NULL);
+      if (aio)
+	status = NtReadFile (prw_handle, aiocb->aio_win_event, NULL, NULL,
+			     &aiocb->aio_win_iosb, buf, count, &off, NULL);
+      else
+	status = NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,
+			     &off, NULL);
       if (status == STATUS_END_OF_FILE)
 	res = 0;
       else if (!NT_SUCCESS (status))
@@ -1584,11 +1602,17 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
 	      switch (mmap_is_attached_or_noreserve (buf, count))
 		{
 		case MMAP_NORESERVE_COMMITED:
-		  status = NtReadFile (prw_handle, NULL, NULL, NULL, &io,
-				       buf, count, &off, NULL);
+		  if (aio)
+		    status = NtReadFile (prw_handle, aiocb->aio_win_event,
+					 NULL, NULL, &aiocb->aio_win_iosb,
+					 buf, count, &off, NULL);
+		  else
+		    status = NtReadFile (prw_handle, NULL, NULL, NULL, &io,
+					 buf, count, &off, NULL);
 		  if (NT_SUCCESS (status))
 		    {
-		      res = io.Information;
+		      res = aio ? aiocb->aio_win_iosb.Information
+				: io.Information;
 		      goto out;
 		    }
 		  break;
@@ -1602,7 +1626,10 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
 	  return -1;
 	}
       else
-	res = io.Information;
+	{
+	  res = aio ? aiocb->aio_win_iosb.Information : io.Information;
+	  goto out;
+	}
     }
   else
     {
@@ -1620,15 +1647,26 @@ non_atomic:
 	  else
 	    res = -1;
 	}
+
+      /* If this was a disallowed async request, simulate its conclusion */
+      if (aio)
+	{
+	  aiocb->aio_rbytes = res;
+	  aiocb->aio_errno = res == -1 ? get_errno () : 0;
+	  SetEvent (aiocb->aio_win_event);
+	}
     }
 out:
-  debug_printf ("%d = pread(%p, %ld, %D)\n", res, buf, count, offset);
+  debug_printf ("%d = pread(%p, %ld, %D, %p)\n", res, buf, count, offset, aio);
   return res;
 }
 
 ssize_t __reg3
-fhandler_disk_file::pwrite (void *buf, size_t count, off_t offset)
+fhandler_disk_file::pwrite (void *buf, size_t count, off_t offset, void *aio)
 {
+  struct aiocb *aiocb = (struct aiocb *) aio;
+  ssize_t res;
+
   if ((get_flags () & O_ACCMODE) == O_RDONLY)
     {
       set_errno (EBADF);
@@ -1643,31 +1681,50 @@ fhandler_disk_file::pwrite (void *buf, size_t count, off_t offset)
       IO_STATUS_BLOCK io;
       LARGE_INTEGER off = { QuadPart:offset };
 
-      if (!prw_handle && prw_open (true))
+      /* If existing prw_handle asyncness doesn't match this call's, re-open */
+      if (prw_handle && (prw_handle_isasync != !!aio))
+        NtClose (prw_handle), prw_handle = NULL;
+
+      if (!prw_handle && prw_open (true, aio))
 	goto non_atomic;
-      status = NtWriteFile (prw_handle, NULL, NULL, NULL, &io, buf, count,
-			    &off, NULL);
+      if (aio)
+	status = NtWriteFile (prw_handle, aiocb->aio_win_event, NULL, NULL,
+			      &aiocb->aio_win_iosb, buf, count, &off, NULL);
+      else
+        status = NtWriteFile (prw_handle, NULL, NULL, NULL, &io, buf, count,
+			      &off, NULL);
       if (!NT_SUCCESS (status))
 	{
 	  __seterrno_from_nt_status (status);
 	  return -1;
 	}
-      return io.Information;
+      res = aio ? aiocb->aio_win_iosb.Information : io.Information;
+      goto out;
     }
-
-non_atomic:
-  /* Text mode stays slow and non-atomic. */
-  int res;
-  off_t curpos = lseek (0, SEEK_CUR);
-  if (curpos < 0 || lseek (offset, SEEK_SET) < 0)
-    res = curpos;
   else
     {
-      res = (ssize_t) write (buf, count);
-      if (lseek (curpos, SEEK_SET) < 0)
-	res = -1;
+non_atomic:
+      /* Text mode stays slow and non-atomic. */
+      off_t curpos = lseek (0, SEEK_CUR);
+      if (curpos < 0 || lseek (offset, SEEK_SET) < 0)
+	res = curpos;
+      else
+	{
+	  res = (ssize_t) write (buf, count);
+	  if (lseek (curpos, SEEK_SET) < 0)
+	    res = -1;
+	}
+
+      /* If this was a disallowed async request, simulate its conclusion */
+      if (aio)
+	{
+	  aiocb->aio_rbytes = res;
+	  aiocb->aio_errno = res == -1 ? get_errno () : 0;
+	  SetEvent (aiocb->aio_win_event);
+	}
     }
-  debug_printf ("%d = pwrite(%p, %ld, %D)\n", res, buf, count, offset);
+out:
+  debug_printf ("%d = pwrite(%p, %ld, %D, %p)\n", res, buf, count, offset, aio);
   return res;
 }
 
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 0b8185d90..7fe46ebef 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -859,7 +859,7 @@ fhandler_pty_slave::read (void *ptr, size_t& len)
 	break;
     }
 out:
-  termios_printf ("%d=read(%p, %lu)", totalread, ptr, len);
+  termios_printf ("%d = read(%p, %lu)", totalread, ptr, len);
   len = (size_t) totalread;
 }
 
-- 
2.17.0
