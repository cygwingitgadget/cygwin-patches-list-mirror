Return-Path: <cygwin-patches-return-6611-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31335 invoked by alias); 3 Sep 2009 19:09:06 -0000
Received: (qmail 31321 invoked by uid 22791); 3 Sep 2009 19:09:05 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO QMTA05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 03 Sep 2009 19:08:59 +0000
Received: from OMTA16.emeryville.ca.mail.comcast.net ([76.96.30.72]) 	by QMTA05.emeryville.ca.mail.comcast.net with comcast 	id cJ8w1c0041ZMdJ4A5K8yiX; Thu, 03 Sep 2009 19:08:58 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA16.emeryville.ca.mail.comcast.net with comcast 	id cKE81c0030Lg2Gw8cKEEtS; Thu, 03 Sep 2009 19:14:14 +0000
Message-ID: <4AA01449.6060707@byu.net>
Date: Thu, 03 Sep 2009 19:09:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
References: <loom.20090903T175736-252@post.gmane.org>
In-Reply-To: <loom.20090903T175736-252@post.gmane.org>
Content-Type: multipart/mixed;  boundary="------------010406070105080904050807"
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
X-SW-Source: 2009-q3/txt/msg00065.txt.bz2

This is a multi-part message in MIME format.
--------------010406070105080904050807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 872

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 9/3/2009 9:58 AM:
> faccessat has at least two, and probably three bugs.

Here's a fix for 1 (typo) and 3 (check for EINVAL in more places), but not
for 2 (euidaccess, and the followup request of lchmod).

2009-09-03  Eric Blake  <ebb9@byu.net>

	* syscalls.cc (faccessat): Fix typo, reject bad flags.
	(fchmodat, fchownat, fstatat, utimensat, linkat, unlinkat): Reject
	bad flags.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkqgFEkACgkQ84KuGfSFAYBE9ACfYroQbQizKsx4/tSYwB8EYoMf
qvEAnizvKp4IlNCOJcuESiy+X+/CwcK/
=86aK
-----END PGP SIGNATURE-----

--------------010406070105080904050807
Content-Type: text/plain;
 name="cygwin.patch19"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch19"
Content-length: 2631

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 3798587..6dee7d3 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3825,7 +3825,8 @@ faccessat (int dirfd, const char *pathname, int mode, int flags)
   char *path = tp.c_get ();
   if (!gen_full_path_at (path, dirfd, pathname))
     {
-      if (flags & ~(F_OK|R_OK|W_OK|X_OK))
+      if ((mode & ~(F_OK|R_OK|W_OK|X_OK))
+	  || (flags & ~(AT_SYMLINK_NOFOLLOW|AT_EACCESS)))
 	set_errno (EINVAL);
       else
 	{
@@ -3851,6 +3852,11 @@ fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
+  if (flags & ~AT_SYMLINK_NOFOLLOW)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   char *path = tp.c_get ();
   if (gen_full_path_at (path, dirfd, pathname))
     return -1;
@@ -3865,6 +3871,11 @@ fchownat (int dirfd, const char *pathname, __uid32_t uid, __gid32_t gid,
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
+  if (flags & ~AT_SYMLINK_NOFOLLOW)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   char *path = tp.c_get ();
   if (gen_full_path_at (path, dirfd, pathname))
     return -1;
@@ -3879,6 +3890,11 @@ fstatat (int dirfd, const char *pathname, struct __stat64 *st, int flags)
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
+  if (flags & ~AT_SYMLINK_NOFOLLOW)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   char *path = tp.c_get ();
   if (gen_full_path_at (path, dirfd, pathname))
     return -1;
@@ -3896,6 +3912,11 @@ utimensat (int dirfd, const char *pathname, const struct timespec *times,
   if (efault.faulted (EFAULT))
     return -1;
   char *path = tp.c_get ();
+  if (flags & ~AT_SYMLINK_NOFOLLOW)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   if (gen_full_path_at (path, dirfd, pathname))
     return -1;
   path_conv win32 (path, PC_POSIX | ((flags & AT_SYMLINK_NOFOLLOW)
@@ -3926,6 +3947,11 @@ linkat (int olddirfd, const char *oldpathname,
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
+  if (flags & ~AT_SYMLINK_FOLLOW)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   char *oldpath = tp.c_get ();
   if (gen_full_path_at (oldpath, olddirfd, oldpathname))
     return -1;
@@ -4034,6 +4060,11 @@ unlinkat (int dirfd, const char *pathname, int flags)
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
+  if (flags & ~AT_REMOVEDIR)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
   char *path = tp.c_get ();
   if (gen_full_path_at (path, dirfd, pathname))
     return -1;

--------------010406070105080904050807--
