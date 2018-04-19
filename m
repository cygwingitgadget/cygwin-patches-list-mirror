Return-Path: <cygwin-patches-return-9051-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102323 invoked by alias); 19 Apr 2018 08:04:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102042 invoked by uid 89); 19 Apr 2018 08:04:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=tot, persist, rights, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Apr 2018 08:04:44 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w3J84bWV056873;	Thu, 19 Apr 2018 01:04:37 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdg2Y9Vn; Thu Apr 19 01:04:34 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2 1/2] Posix asynchronous I/O support: fhandler files
Date: Thu, 19 Apr 2018 08:04:00 -0000
Message-Id: <20180419080402.10932-3-mark@maxrnd.com>
In-Reply-To: <20180419080402.10932-1-mark@maxrnd.com>
References: <20180419080402.10932-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00008.txt.bz2

This code is where the AIO implementation is wired into existing Cygwin
mechanisms for file and device I/O: the fhandler* functions.  It makes
use of an existing internal routine prw_open to supply a "shadow fd"
that permits asynchronous operations on a file the user app accesses
via its own fd.  This allows AIO to read or write at arbitrary locations
within a file without disturbing the app's file pointer.  (This was
already the case with normal pread|pwrite; we're just adding "async"
to the mix.)

This is the 2nd WIP patch set for AIO.  The string XXX marks issues
I'm specifically requesting comments on, but feel free to comment or
suggest changes on any of this code.
---
 winsup/cygwin/fhandler.cc           |  4 +-
 winsup/cygwin/fhandler.h            | 10 ++---
 winsup/cygwin/fhandler_disk_file.cc | 89 +++++++++++++++++++++++++------------
 3 files changed, 67 insertions(+), 36 deletions(-)

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
index 2ec460a37..b092f1d15 100644
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
@@ -1426,7 +1426,7 @@ class fhandler_disk_file: public fhandler_base
   HANDLE prw_handle;
   int __reg3 readdir_helper (DIR *, dirent *, DWORD, DWORD, PUNICODE_STRING fname);
 
-  int prw_open (bool);
+  int prw_open (bool, void *);
 
  public:
   fhandler_disk_file ();
@@ -1467,8 +1467,8 @@ class fhandler_disk_file: public fhandler_base
   void rewinddir (DIR *);
   int closedir (DIR *);
 
-  ssize_t __reg3 pread (void *, size_t, off_t);
-  ssize_t __reg3 pwrite (void *, size_t, off_t);
+  ssize_t __reg3 pread (void *, size_t, off_t, void *aio = NULL);
+  ssize_t __reg3 pwrite (void *, size_t, off_t, void *aio = NULL);
 
   fhandler_disk_file (void *) {}
   dev_t get_dev () { return pc.fs_serial_number (); }
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index fc87d91c1..c9b231a31 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -24,6 +24,7 @@ details. */
 #include "tls_pbuf.h"
 #include "devices.h"
 #include "ldap.h"
+#include <aio.h>
 
 #define _COMPILING_NEWLIB
 #include <dirent.h>
@@ -1511,28 +1512,34 @@ fhandler_base::open_fs (int flags, mode_t mode)
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
+  /* If async i/o is intended, turn off default synchronous operation option */
+  //XXX prw_open() only called for first pread|pwrite on an fd. options persist!
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
@@ -1542,8 +1549,9 @@ fhandler_disk_file::prw_open (bool write)
 }
 
 ssize_t __reg3
-fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
+fhandler_disk_file::pread (void *buf, size_t count, off_t offset, void *aio)
 {
+  struct aiocb *aiocb = (struct aiocb *) aio;
   ssize_t res;
 
   if ((get_flags () & O_ACCMODE) == O_WRONLY)
@@ -1561,10 +1569,14 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
       IO_STATUS_BLOCK io;
       LARGE_INTEGER off = { QuadPart:offset };
 
-      if (!prw_handle && prw_open (false))
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
@@ -1584,11 +1596,17 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
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
@@ -1602,7 +1620,10 @@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)
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
@@ -1622,13 +1643,16 @@ non_atomic:
 	}
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
@@ -1643,31 +1667,38 @@ fhandler_disk_file::pwrite (void *buf, size_t count, off_t offset)
       IO_STATUS_BLOCK io;
       LARGE_INTEGER off = { QuadPart:offset };
 
-      if (!prw_handle && prw_open (true))
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
     }
-  debug_printf ("%d = pwrite(%p, %ld, %D)\n", res, buf, count, offset);
+out:
+  debug_printf ("%d = pwrite(%p, %ld, %D, %p)\n", res, buf, count, offset, aio);
   return res;
 }
 
-- 
2.16.2
