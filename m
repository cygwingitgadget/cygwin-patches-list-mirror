Return-Path: <cygwin-patches-return-6649-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5861 invoked by alias); 26 Sep 2009 00:03:37 -0000
Received: (qmail 5394 invoked by uid 22791); 26 Sep 2009 00:03:35 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_32,J_CHICKENPOX_55,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta12.emeryville.ca.mail.comcast.net (HELO QMTA12.emeryville.ca.mail.comcast.net) (76.96.27.227)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Sep 2009 00:03:30 +0000
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52]) 	by QMTA12.emeryville.ca.mail.comcast.net with comcast 	id lAfR1c00C17UAYkACC3WxW; Sat, 26 Sep 2009 00:03:30 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA13.emeryville.ca.mail.comcast.net with comcast 	id lC3U1c0010Lg2Gw8ZC3V2F; Sat, 26 Sep 2009 00:03:29 +0000
Message-ID: <4ABD5A4A.9060603@byu.net>
Date: Sat, 26 Sep 2009 00:03:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
References: <20090907192046.GA12492@calimero.vinschen.de>  <loom.20090909T005422-847@post.gmane.org>  <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>  <20090923140905.GA2527@ednor.casa.cgf.cx>  <20090923160846.GA18954@calimero.vinschen.de>  <20090923164127.GB3172@ednor.casa.cgf.cx>  <4ABC39A1.1060702@byu.net> <20090925151114.GA23857@ednor.casa.cgf.cx>
In-Reply-To: <20090925151114.GA23857@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------030107050002020901050308"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00103.txt.bz2

This is a multi-part message in MIME format.
--------------030107050002020901050308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2002

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/25/2009 9:11 AM:
>> >+  /* POSIX says mkdir("symlink-to-missing/") should create the
>> >+     directory "missing", but Linux rejects it with EEXIST.  Copy
>> >+     Linux behavior for now.  */
>> >+
>> >+  dlen = strlen (dir);
>> >+  if (isdirsep (dir[dlen - 1]))
> 
> Couldn't this index negatively if dir is zero length?

Yep, and so could rename, where this was copied from.  Fixed in the respin
below.

> 
>> >+    {
>> >+      stpcpy (newbuf = tp.c_get (), dir);
> 
> Since stpcpy returns a pointer to the end of the buffer couldn't we use that
> and do pointer arithmetic rather than index arithmetic?

Theoretically, a good compiler can do just as well with either.  But how
does it look now?

>> >-  char new_buf[strlen (newpath) + 5];
>> >+  if (isdirsep (newpath[nlen - 1]) || has_dot_last_component (newpath, false))
> 
> Same observation:  Couldn't newpath be zero length?

Also fixed below; actually this one is fixed by using PC_NULLEMPTY, which
guarantees newpc.error will be set to ENOENT and skip this line of code.

2009-09-25  Eric Blake  <ebb9@byu.net>

	* syscalls.cc (link): Delete obsolete comment.  Reject directories
	and missing source up front.
	(rename): Use correct errno for trailing '.'.  Detect empty
	strings.  Allow trailing slash to newpath iff oldpath is
	directory.
	* dir.cc (mkdir): Reject dangling symlink with trailing slash.
	* fhandler_disk_file.cc (fhandler_disk_file::link): Reject
	trailing slash.
	* fhandler.cc (fhandler_base::link): Match Linux errno.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq9WkoACgkQ84KuGfSFAYBPqwCbBpmB5/wvDfq1I6gKTPGILjpe
VcMAoLyrCfwt0kHJLSLDI8nQ9nWethku
=TgSy
-----END PGP SIGNATURE-----

--------------030107050002020901050308
Content-Type: text/plain;
 name="cygwin.patch25"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch25"
Content-length: 8437

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index 2b9125f..4bca40c 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -1,6 +1,7 @@
 /* dir.cc: Posix directory-related routines

-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007,
+   2008, 2009 Red Hat, Inc.

 This file is part of Cygwin.

@@ -21,6 +22,7 @@ details. */
 #include "dtable.h"
 #include "cygheap.h"
 #include "cygtls.h"
+#include "tls_pbuf.h"

 extern "C" int
 dirfd (DIR *dir)
@@ -273,11 +275,30 @@ mkdir (const char *dir, mode_t mode)
 {
   int res = -1;
   fhandler_base *fh = NULL;
+  tmp_pathbuf tp;

   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;

+  /* POSIX says mkdir("symlink-to-missing/") should create the
+     directory "missing", but Linux rejects it with EEXIST.  Copy
+     Linux behavior for now.  */
+
+  if (!*dir)
+    {
+      set_errno (ENOENT);
+      goto done;
+    }
+  if (isdirsep (dir[strlen (dir) - 1]))
+    {
+      /* This converts // to /, but since both give EEXIST, we're okay.  */
+      char *buf;
+      char *p = stpcpy (buf = tp.c_get (), dir) - 1;
+      dir = buf;
+      while (p > dir && isdirsep (*p))
+        *p-- = '\0';
+    }
   if (!(fh = build_fh_name (dir, NULL, PC_SYM_NOFOLLOW)))
     goto done;   /* errno already set */;

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index 5f501a7..7a7d801 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1541,7 +1541,7 @@ fhandler_base::ftruncate (_off64_t length, bool allow_truncate)
 int
 fhandler_base::link (const char *newpath)
 {
-  set_errno (EINVAL);
+  set_errno (EPERM);
   return -1;
 }

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 214be47..99bbf8b 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1186,7 +1186,8 @@ fhandler_disk_file::ftruncate (_off64_t length, bool allow_truncate)
 int
 fhandler_disk_file::link (const char *newpath)
 {
-  path_conv newpc (newpath, PC_SYM_NOFOLLOW | PC_POSIX, stat_suffixes);
+  size_t nlen = strlen (newpath);
+  path_conv newpc (newpath, PC_SYM_NOFOLLOW | PC_POSIX | PC_NULLEMPTY, stat_suffixes);
   if (newpc.error)
     {
       set_errno (newpc.error);
@@ -1200,7 +1201,13 @@ fhandler_disk_file::link (const char *newpath)
       return -1;
     }

-  char new_buf[strlen (newpath) + 5];
+  if (isdirsep (newpath[nlen - 1]) || has_dot_last_component (newpath, false))
+    {
+      set_errno (ENOENT);
+      return -1;
+    }
+
+  char new_buf[nlen + 5];
   if (!newpc.error)
     {
       if (pc.is_lnk_special ())
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index da9cda5..94410fe 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1124,13 +1124,6 @@ isatty (int fd)
 }
 EXPORT_ALIAS (isatty, _isatty)

-/* Under NT, try to make a hard link using backup API.  If that
-   fails or we are Win 95, just copy the file.
-   FIXME: We should actually be checking partition type, not OS.
-   Under NTFS, we should support hard links.  On FAT partitions,
-   we should just copy the file.
-*/
-
 extern "C" int
 link (const char *oldpath, const char *newpath)
 {
@@ -1145,6 +1138,10 @@ link (const char *oldpath, const char *newpath)
       debug_printf ("got %d error from build_fh_name", fh->error ());
       set_errno (fh->error ());
     }
+  else if (fh->pc.isdir ())
+    set_errno (EPERM); /* We do not permit linking directories.  */
+  else if (!fh->pc.exists ())
+    set_errno (ENOENT);
   else
     res = fh->link (newpath);

@@ -1651,7 +1648,6 @@ rename (const char *oldpath, const char *newpath)
 {
   tmp_pathbuf tp;
   int res = -1;
-  char *oldbuf, *newbuf;
   path_conv oldpc, newpc, new2pc, *dstpc, *removepc = NULL;
   bool old_dir_requested = false, new_dir_requested = false;
   bool old_explicit_suffix = false, new_explicit_suffix = false;
@@ -1670,16 +1666,21 @@ rename (const char *oldpath, const char *newpath)
   if (efault.faulted (EFAULT))
     return -1;

+  if (!*oldpath || !*newpath)
+    {
+      set_errno (ENOENT);
+      goto out;
+    }
   if (has_dot_last_component (oldpath, true))
     {
       oldpc.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
-      set_errno (oldpc.isdir () ? EBUSY : ENOTDIR);
+      set_errno (oldpc.isdir () ? EINVAL : ENOTDIR);
       goto out;
     }
   if (has_dot_last_component (newpath, true))
     {
       newpc.check (newpath, PC_SYM_NOFOLLOW, stat_suffixes);
-      set_errno (!newpc.exists () ? ENOENT : newpc.isdir () ? EBUSY : ENOTDIR);
+      set_errno (!newpc.exists () ? ENOENT : newpc.isdir () ? EINVAL : ENOTDIR);
       goto out;
     }

@@ -1689,10 +1690,20 @@ rename (const char *oldpath, const char *newpath)
   olen = strlen (oldpath);
   if (isdirsep (oldpath[olen - 1]))
     {
-      stpcpy (oldbuf = tp.c_get (), oldpath);
-      while (olen > 0 && isdirsep (oldbuf[olen - 1]))
-	oldbuf[--olen] = '\0';
-      oldpath = oldbuf;
+      char *buf;
+      char *p = stpcpy (buf = tp.c_get (), oldpath) - 1;
+      oldpath = buf;
+      while (p >= oldpath && isdirsep (*p))
+        *p-- = '\0';
+      olen = p + 1 - oldpath;
+      if (!olen)
+        {
+          /* The root directory cannot be renamed.  This also rejects
+             the corner case of rename("/","/"), even though it is the
+             same file.  */
+          set_errno (EINVAL);
+          goto out;
+        }
       old_dir_requested = true;
     }
   oldpc.check (oldpath, PC_SYM_NOFOLLOW, stat_suffixes);
@@ -1724,10 +1735,17 @@ rename (const char *oldpath, const char *newpath)
   nlen = strlen (newpath);
   if (isdirsep (newpath[nlen - 1]))
     {
-      stpcpy (newbuf = tp.c_get (), newpath);
-      while (nlen > 0 && isdirsep (newbuf[nlen - 1]))
-	newbuf[--nlen] = '\0';
-      newpath = newbuf;
+      char *buf;
+      char *p = stpcpy (buf = tp.c_get (), newpath) - 1;
+      newpath = buf;
+      while (p >= newpath && isdirsep (*p))
+        *p-- = '\0';
+      nlen = p + 1 - newpath;
+      if (!nlen) /* The root directory is never empty.  */
+        {
+          set_errno (ENOTEMPTY);
+          goto out;
+        }
       new_dir_requested = true;
     }
   newpc.check (newpath, PC_SYM_NOFOLLOW, stat_suffixes);
@@ -1741,9 +1759,22 @@ rename (const char *oldpath, const char *newpath)
       set_errno (EROFS);
       goto out;
     }
-  if (new_dir_requested && !newpc.isdir ())
+  if (new_dir_requested)
     {
-      set_errno (ENOTDIR);
+      if (!newpc.exists())
+        {
+          set_errno (ENOENT);
+          goto out;
+        }
+      if (!newpc.isdir ())
+        {
+          set_errno (ENOTDIR);
+          goto out;
+        }
+    }
+  if (newpc.exists () && (oldpc.isdir () ? !newpc.isdir () : newpc.isdir ()))
+    {
+      set_errno (newpc.isdir () ? EISDIR : ENOTDIR);
       goto out;
     }
   if (newpc.known_suffix
@@ -1774,22 +1805,23 @@ rename (const char *oldpath, const char *newpath)
     }
   else if (oldpc.isdir ())
     {
-      if (newpc.exists () && !newpc.isdir ())
-	{
-	  set_errno (ENOTDIR);
-	  goto out;
-	}
-      /* Check for newpath being a subdir of oldpath. */
+      /* Check for newpath being identical or a subdir of oldpath. */
       if (RtlPrefixUnicodeString (oldpc.get_nt_native_path (),
 				  newpc.get_nt_native_path (),
-				  TRUE)
-	  && newpc.get_nt_native_path ()->Length >
-	     oldpc.get_nt_native_path ()->Length
-	  && *(PWCHAR) ((PBYTE) newpc.get_nt_native_path ()->Buffer
-			+ oldpc.get_nt_native_path ()->Length) == L'\\')
+				  TRUE))
 	{
-	  set_errno (EINVAL);
-	  goto out;
+	  if (newpc.get_nt_native_path ()->Length
+	      == oldpc.get_nt_native_path ()->Length)
+	    {
+	      res = 0;
+	      goto out;
+	    }
+	  if (*(PWCHAR) ((PBYTE) newpc.get_nt_native_path ()->Buffer
+			 + oldpc.get_nt_native_path ()->Length) == L'\\')
+	    {
+	      set_errno (EINVAL);
+	      goto out;
+	    }
 	}
     }
   else if (!newpc.exists ())
@@ -1816,11 +1848,6 @@ rename (const char *oldpath, const char *newpath)
 	   .exe suffix must be given explicitly in oldpath. */
 	rename_append_suffix (newpc, newpath, nlen, ".exe");
     }
-  else if (newpc.isdir ())
-    {
-      set_errno (EISDIR);
-      goto out;
-    }
   else
     {
       if (equal_path && old_explicit_suffix != new_explicit_suffix)
-- 
1.6.5.rc1


--------------030107050002020901050308--
