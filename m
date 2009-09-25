Return-Path: <cygwin-patches-return-6635-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24286 invoked by alias); 25 Sep 2009 03:32:02 -0000
Received: (qmail 24272 invoked by uid 22791); 25 Sep 2009 03:32:01 -0000
X-SWARE-Spam-Status: No, hits=-0.7 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_32,J_CHICKENPOX_42,J_CHICKENPOX_55,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta15.emeryville.ca.mail.comcast.net (HELO QMTA15.emeryville.ca.mail.comcast.net) (76.96.27.228)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 03:31:56 +0000
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59]) 	by QMTA15.emeryville.ca.mail.comcast.net with comcast 	id kr0D1c0011GXsucAFrXw5q; Fri, 25 Sep 2009 03:31:56 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA07.emeryville.ca.mail.comcast.net with comcast 	id krXu1c0020Lg2Gw8TrXv5G; Fri, 25 Sep 2009 03:31:55 +0000
Message-ID: <4ABC39A1.1060702@byu.net>
Date: Fri, 25 Sep 2009 03:32:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
References: <4AA52B5E.8060509@byu.net>  <20090907192046.GA12492@calimero.vinschen.de>  <loom.20090909T005422-847@post.gmane.org>  <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>  <20090923140905.GA2527@ednor.casa.cgf.cx>  <20090923160846.GA18954@calimero.vinschen.de> <20090923164127.GB3172@ednor.casa.cgf.cx>
In-Reply-To: <20090923164127.GB3172@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------090602080703080100010607"
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
X-SW-Source: 2009-q3/txt/msg00089.txt.bz2

This is a multi-part message in MIME format.
--------------090602080703080100010607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1649

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 9/23/2009 10:41 AM:
>> Also less risky would be to make changes locally in mkdir, link, and
>> rename for now.

Done - this patch narrows the scope of the changes to just the interfaces
in question.  I've also tested that it made it through the coreutils
testsuite without any regressions.

> 
> I'm not clear if this is a regression or not.  If it isn't a regression,
> I'd opt for leaving it until 1.7.2.

Now that I'm not touching path.cc, these are all much more self-contained,
and make cygwin more consistent with Linux.  For example:

touch a
ln -s c b
link a b/

should fail because b/ is not an existing directory, but without this
patch, it succeeds and creates the regular file c as a link to a.

2009-09-24  Eric Blake  <ebb9@byu.net>

	* syscalls.cc (link): Delete obsolete comment.  Reject directories
	and missing source up front.
	(rename): Use correct errno for trailing '.'.  Allow trailing
	slash to newpath iff oldpath is directory.
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

iEYEARECAAYFAkq8OaEACgkQ84KuGfSFAYAiLACghYLCFaIGmFR4AuzKAmBuQcg/
kFoAoJcX+ufE6YUq7S1AeVRvHtyZ30wc
=4otJ
-----END PGP SIGNATURE-----

--------------090602080703080100010607
Content-Type: text/plain;
 name="cygwin.patch21"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch21"
Content-length: 4718

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index 2b9125f..b7c31e4 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -1,6 +1,7 @@
 /* dir.cc: Posix directory-related routines

-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007,
+   2009 Red Hat, Inc.

 This file is part of Cygwin.

@@ -21,6 +22,7 @@ details. */
 #include "dtable.h"
 #include "cygheap.h"
 #include "cygtls.h"
+#include "tls_pbuf.h"

 extern "C" int
 dirfd (DIR *dir)
@@ -273,11 +275,26 @@ mkdir (const char *dir, mode_t mode)
 {
   int res = -1;
   fhandler_base *fh = NULL;
+  size_t dlen;
+  char *newbuf;
+  tmp_pathbuf tp;

   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;

+  /* POSIX says mkdir("symlink-to-missing/") should create the
+     directory "missing", but Linux rejects it with EEXIST.  Copy
+     Linux behavior for now.  */
+
+  dlen = strlen (dir);
+  if (isdirsep (dir[dlen - 1]))
+    {
+      stpcpy (newbuf = tp.c_get (), dir);
+      while (dlen > 0 && isdirsep (dir[dlen - 1]))
+        newbuf[--dlen] = '\0';
+      dir = newbuf;
+    }
   if (!(fh = build_fh_name (dir, NULL, PC_SYM_NOFOLLOW)))
     goto done;   /* errno already set */;

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index b52d7c2..44311ca 100644
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
index 214be47..4c4b559 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1186,6 +1186,7 @@ fhandler_disk_file::ftruncate (_off64_t length, bool allow_truncate)
 int
 fhandler_disk_file::link (const char *newpath)
 {
+  size_t nlen = strlen (newpath);
   path_conv newpc (newpath, PC_SYM_NOFOLLOW | PC_POSIX, stat_suffixes);
   if (newpc.error)
     {
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
index 542a122..b00404d 100644
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

@@ -1650,13 +1647,13 @@ rename (const char *oldpath, const char *newpath)
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

@@ -1701,6 +1698,11 @@ rename (const char *oldpath, const char *newpath)
   nlen = strlen (newpath);
   if (isdirsep (newpath[nlen - 1]))
     {
+      if (!oldpc.isdir())
+	{
+	  set_errno (ENOTDIR);
+	  goto out;
+	}
       stpcpy (newbuf = tp.c_get (), newpath);
       while (nlen > 0 && isdirsep (newbuf[nlen - 1]))
 	newbuf[--nlen] = '\0';
@@ -1718,7 +1720,7 @@ rename (const char *oldpath, const char *newpath)
       set_errno (EROFS);
       goto out;
     }
-  if (new_dir_requested && !newpc.isdir ())
+  if (new_dir_requested && newpc.exists() && !newpc.isdir ())
     {
       set_errno (ENOTDIR);
       goto out;
-- 
1.6.5.rc1


--------------090602080703080100010607--
