Return-Path: <cygwin-patches-return-6629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3217 invoked by alias); 23 Sep 2009 12:59:19 -0000
Received: (qmail 3206 invoked by uid 22791); 23 Sep 2009 12:59:18 -0000
X-SWARE-Spam-Status: No, hits=-0.1 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_32,J_CHICKENPOX_35,J_CHICKENPOX_42,J_CHICKENPOX_55,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta07.emeryville.ca.mail.comcast.net (HELO QMTA07.emeryville.ca.mail.comcast.net) (76.96.30.64)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 23 Sep 2009 12:59:13 +0000
Received: from OMTA07.emeryville.ca.mail.comcast.net ([76.96.30.59]) 	by QMTA07.emeryville.ca.mail.comcast.net with comcast 	id kC7b1c0011GXsucA7CzDa1; Wed, 23 Sep 2009 12:59:13 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA07.emeryville.ca.mail.comcast.net with comcast 	id kCzC1c0020Lg2Gw8TCzCTx; Wed, 23 Sep 2009 12:59:13 +0000
Message-ID: <4ABA1B92.9080406@byu.net>
Date: Wed, 23 Sep 2009 12:59:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
References: <4AA52B5E.8060509@byu.net> <20090907192046.GA12492@calimero.vinschen.de> <loom.20090909T005422-847@post.gmane.org> <loom.20090909T183010-83@post.gmane.org> <loom.20090922T225033-801@post.gmane.org>
In-Reply-To: <loom.20090922T225033-801@post.gmane.org>
Content-Type: multipart/mixed;  boundary="------------090204040107030104000006"
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
X-SW-Source: 2009-q3/txt/msg00083.txt.bz2

This is a multi-part message in MIME format.
--------------090204040107030104000006
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1327

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 9/22/2009 3:02 PM:
> I've got a patch in testing for both of these issues.

Does this look okay to apply?  The fix in path.cc affects more than just
link, hence I had to add a new option to keep mkdir("d/",mode) still
working, while link("file","d/") now fails with the same ENOENT as Linux.
 rename was tricky, as rename("file","d/") must fail whether or not d
exists, while rename("dir","d/") must succeed if d does not exist or
exists and is empty.  I think I got it all, but it can't hurt to
double-check things.

2009-09-23  Eric Blake  <ebb9@byu.net>

	* path.h (PC_MKDIR): New enum value.
	* path.cc (check): Ensure 'a/' resolves to a directory.
	* syscalls.cc (link): Fix comment.
	(rename): Use correct errno for trailing '.'.  Allow trailing
	slash to newpath iff oldpath is directory.
	* dir.cc (mkdir): Allow trailing slash.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq6G5EACgkQ84KuGfSFAYBNZQCgmmW5addUf28is9/4MvAlcaTs
9NsAn3Y8CYG2DdIgFT9I6EzhnhtmuklX
=LtpR
-----END PGP SIGNATURE-----

--------------090204040107030104000006
Content-Type: text/plain;
 name="cygwin.patch21"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch21"
Content-length: 5682

Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.123
diff -u -p -r1.123 dir.cc
--- dir.cc	28 Nov 2008 09:04:35 -0000	1.123
+++ dir.cc	23 Sep 2009 12:58:26 -0000
@@ -1,6 +1,6 @@
 /* dir.cc: Posix directory-related routines
 
-   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2006, 2007, 2009 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -278,7 +278,7 @@ mkdir (const char *dir, mode_t mode)
   if (efault.faulted (EFAULT))
     return -1;
 
-  if (!(fh = build_fh_name (dir, NULL, PC_SYM_NOFOLLOW)))
+  if (!(fh = build_fh_name (dir, NULL, PC_SYM_NOFOLLOW | PC_MKDIR)))
     goto done;   /* errno already set */;
 
   if (fh->error ())
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.565
diff -u -p -r1.565 path.cc
--- path.cc	22 Sep 2009 09:24:30 -0000	1.565
+++ path.cc	23 Sep 2009 12:58:26 -0000
@@ -622,8 +622,8 @@ path_conv::check (const char *src, unsig
   char *tmp_buf = tp.t_get ();
   char *THIS_path = tp.c_get ();
   symlink_info sym;
-  bool need_directory = 0;
-  bool saw_symlinks = 0;
+  bool need_directory = false;
+  bool saw_symlinks = false;
   bool add_ext = false;
   bool is_relpath;
   char *tail, *path_end;
@@ -698,7 +698,7 @@ path_conv::check (const char *src, unsig
 	 into account during processing */
       if (tail > path_copy + 2 && isslash (tail[-1]))
 	{
-	  need_directory = 1;
+	  need_directory = !(opt & PC_MKDIR);
 	  *--tail = '\0';
 	}
       path_end = tail;
@@ -899,7 +899,7 @@ is_virtual_symlink:
 	     these operations again on the newly derived path. */
 	  else if (symlen > 0)
 	    {
-	      saw_symlinks = 1;
+	      saw_symlinks = true;
 	      if (component == 0 && !need_directory && !(opt & PC_SYM_FOLLOW))
 		{
 		  set_symlink (symlen); // last component of path is a symlink.
@@ -914,7 +914,7 @@ is_virtual_symlink:
 	      else
 		break;
 	    }
-	  else if (sym.error && sym.error != ENOENT)
+	  else if (sym.error && (sym.error != ENOENT || need_directory))
 	    {
 	      error = sym.error;
 	      goto out;
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.136
diff -u -p -r1.136 path.h
--- path.h	26 Aug 2009 20:32:35 -0000	1.136
+++ path.h	23 Sep 2009 12:58:26 -0000
@@ -1,7 +1,7 @@
 /* path.h: path data structures
 
    Copyright 1996, 1997, 1998, 2000, 2001, 2002, 2003, 2004, 2005,
-   2006, 2007, 2008 Red Hat, Inc.
+   2006, 2007, 2008, 2009 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -49,15 +49,16 @@ extern suffix_info stat_suffixes[];
 
 enum pathconv_arg
 {
-  PC_SYM_FOLLOW		= 0x0001,
-  PC_SYM_NOFOLLOW	= 0x0002,
-  PC_SYM_CONTENTS	= 0x0008,
-  PC_NOFULL		= 0x0010,
-  PC_NULLEMPTY		= 0x0020,
-  PC_CHECK_EA		= 0x0040,
-  PC_POSIX		= 0x0080,
-  PC_NOWARN		= 0x0100,
-  PC_NO_ACCESS_CHECK	= 0x00800000
+  PC_SYM_FOLLOW		= 0x0001,	/* Resolve all symlinks.  */
+  PC_SYM_NOFOLLOW	= 0x0002,	/* Operate on symlink.  */
+  PC_SYM_CONTENTS	= 0x0008,	/* Perform readlink.  */
+  PC_NOFULL		= 0x0010,	/* Leave relative path short.  */
+  PC_NULLEMPTY		= 0x0020,	/* Reject "" with ENOENT.  */
+  PC_CHECK_EA		= 0x0040,	/* Unused?  */
+  PC_POSIX		= 0x0080,	/* Expect / separator.  */
+  PC_NOWARN		= 0x0100,	/* Don't warn about DOS names.  */
+  PC_MKDIR		= 0x0200,	/* About to be created via mkdir.  */
+  PC_NO_ACCESS_CHECK	= 0x00800000	/* Skip access check on tail.  */
 };
 
 #define PC_NONULLEMPTY -1
Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.533
diff -u -p -r1.533 syscalls.cc
--- syscalls.cc	22 Sep 2009 12:13:53 -0000	1.533
+++ syscalls.cc	23 Sep 2009 12:58:26 -0000
@@ -1124,12 +1124,7 @@ isatty (int fd)
 }
 EXPORT_ALIAS (isatty, _isatty)
 
-/* Under NT, try to make a hard link using backup API.  If that
-   fails or we are Win 95, just copy the file.
-   FIXME: We should actually be checking partition type, not OS.
-   Under NTFS, we should support hard links.  On FAT partitions,
-   we should just copy the file.
-*/
+/* Under NT, try to make a hard link using backup API.  */
 
 extern "C" int
 link (const char *oldpath, const char *newpath)
@@ -1650,13 +1645,13 @@ rename (const char *oldpath, const char 
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
 
@@ -1701,6 +1696,11 @@ rename (const char *oldpath, const char 
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
@@ -1718,7 +1718,7 @@ rename (const char *oldpath, const char 
       set_errno (EROFS);
       goto out;
     }
-  if (new_dir_requested && !newpc.isdir ())
+  if (new_dir_requested && newpc.exists() && !newpc.isdir ())
     {
       set_errno (ENOTDIR);
       goto out;

--------------090204040107030104000006--
