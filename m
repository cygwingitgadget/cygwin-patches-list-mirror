Return-Path: <cygwin-patches-return-6637-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27660 invoked by alias); 25 Sep 2009 03:40:36 -0000
Received: (qmail 27645 invoked by uid 22791); 25 Sep 2009 03:40:35 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_42,J_CHICKENPOX_63,J_CHICKENPOX_82,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta06.emeryville.ca.mail.comcast.net (HELO QMTA06.emeryville.ca.mail.comcast.net) (76.96.30.56)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 25 Sep 2009 03:40:29 +0000
Received: from OMTA22.emeryville.ca.mail.comcast.net ([76.96.30.89]) 	by QMTA06.emeryville.ca.mail.comcast.net with comcast 	id kqrq1c0041vN32cA6rgVYf; Fri, 25 Sep 2009 03:40:29 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA22.emeryville.ca.mail.comcast.net with comcast 	id krmC1c00N0Lg2Gw8irmDAg; Fri, 25 Sep 2009 03:46:14 +0000
Message-ID: <4ABC3BA2.9000109@byu.net>
Date: Fri, 25 Sep 2009 03:40:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: new exports
Content-Type: multipart/mixed;  boundary="------------000608030704070505010809"
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
X-SW-Source: 2009-q3/txt/msg00091.txt.bz2

This is a multi-part message in MIME format.
--------------000608030704070505010809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1346

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Followup to my faccessat patch.  Here's several functions exported by
Linux which are trivial to support in cygwin, and which coreutils would
like to use.  POSIX allows us to copy Linux' behavior about refusing to
implement fchmodat(,AT_SYMLINK_NOFOLLOW) (aka BSD lchmod), so if/until we
implement lchmod, we should not mistakenly change the permissions on the
file the symlink is pointing to.  I've also posted a newlib patch to
declare e[uid]access.

2009-09-24  Eric Blake  <ebb9@byu.net>

	* syscalls.cc (fchownat): lchmod is not yet implemented.
	(euidaccess): New function.
	* path.cc (realpath): Update comment.
	(canonicalize_file_name): New function.
	* include/cygwin/stdlib.h (canonicalize_file_name): Declare it.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* cygwin.din: Export canonicalize_file_name, eaccess, euidaccess.
	* posix.sgml: Mention them.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkq8O6IACgkQ84KuGfSFAYB11wCgy5ADpe5rlOnToWh5Bk3hnWPy
4VQAoJsj1B8+44ROO6G8AoljMUhEbBeu
=YnUu
-----END PGP SIGNATURE-----

--------------000608030704070505010809
Content-Type: text/plain;
 name="cygwin.patch23"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch23"
Content-length: 5952

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index 52cd362..bee9cd1 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -165,6 +165,7 @@ cabsf NOSIGFE
 _cabsf = cabsf NOSIGFE
 calloc SIGFE
 _calloc = calloc SIGFE
+canonicalize_file_name SIGFE
 cbrt NOSIGFE
 _cbrt = cbrt NOSIGFE
 cbrtf NOSIGFE
@@ -296,6 +297,7 @@ dup SIGFE
 _dup = dup SIGFE
 dup2 SIGFE
 _dup2 = dup2 SIGFE
+eaccess = euidaccess SIGFE
 ecvt SIGFE
 _ecvt = ecvt SIGFE
 ecvtbuf SIGFE
@@ -341,6 +343,7 @@ _erff = erff NOSIGFE
 err SIGFE
 __errno NOSIGFE
 errx SIGFE
+euidaccess SIGFE
 execl SIGFE
 _execl = execl SIGFE
 execle SIGFE
diff --git a/winsup/cygwin/include/cygwin/stdlib.h b/winsup/cygwin/include/cygwin/stdlib.h
index d16e4bb..61be07d 100644
--- a/winsup/cygwin/include/cygwin/stdlib.h
+++ b/winsup/cygwin/include/cygwin/stdlib.h
@@ -1,6 +1,6 @@
 /* stdlib.h

-   Copyright 2005, 2006, 2007 Red Hat Inc.
+   Copyright 2005, 2006, 2007, 2009 Red Hat Inc.

 This file is part of Cygwin.

@@ -23,6 +23,7 @@ void	setprogname (const char *);

 #ifndef __STRICT_ANSI__
 char *realpath (const char *, char *);
+char *canonicalize_file_name (const char *);
 int unsetenv (const char *);
 char *initstate (unsigned seed, char *state, size_t size);
 long random (void);
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index cf0a116..bd05103 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -366,12 +366,13 @@ details. */
       210: New ctype layout using variable ctype pointer.  Export __ctype_ptr__.
       211: Export fpurge, mkstemps.
       212: Add and export libstdc++ malloc wrappers.
+      213: Export canonicalize_file_name, eaccess, euidaccess.
      */

      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */

 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 212
+#define CYGWIN_VERSION_API_MINOR 213

      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 89552d9..e543dd4 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -2845,7 +2845,7 @@ cygwin_conv_to_full_posix_path (const char *path, char *posix_path)
 			   MAX_PATH);
 }

-/* The realpath function is supported on some UNIX systems.  */
+/* The realpath function is required by POSIX:2008.  */

 extern "C" char *
 realpath (const char *path, char *resolved)
@@ -2876,11 +2876,9 @@ realpath (const char *path, char *resolved)
   path_conv real_path (tpath, PC_SYM_FOLLOW | PC_POSIX, stat_suffixes);


-  /* Linux has this funny non-standard extension.  If "resolved" is NULL,
-     realpath mallocs the space by itself and returns it to the application.
-     The application is responsible for calling free() then.  This extension
-     is backed by POSIX, which allows implementation-defined behaviour if
-     "resolved" is NULL.  That's good enough for us to do the same here. */
+  /* POSIX 2008 requires malloc'ing if resolved is NULL, and states
+     that using non-NULL resolved is asking for portability
+     problems.  */

   if (!real_path.error && real_path.exists ())
     {
@@ -2894,14 +2892,24 @@ realpath (const char *path, char *resolved)
       return resolved;
     }

-  /* FIXME: on error, we are supposed to put the name of the path
-     component which could not be resolved into RESOLVED.  */
+  /* FIXME: on error, Linux puts the name of the path
+     component which could not be resolved into RESOLVED, but POSIX
+     does not require this.  */
   if (resolved)
     resolved[0] = '\0';
   set_errno (real_path.error ?: ENOENT);
   return NULL;
 }

+/* Linux provides this extension.  Since the only portable use of
+   realpath requires a NULL second argument, we might as well have a
+   one-argument wrapper.  */
+extern "C" char *
+canonicalize_file_name (const char *path)
+{
+  return realpath (path, NULL);
+}
+
 /* Return non-zero if path is a POSIX path list.
    This is exported to the world as cygwin_foo by cygwin.din.

diff --git a/winsup/cygwin/posix.sgml b/winsup/cygwin/posix.sgml
index 1b9d825..48dce6c 100644
--- a/winsup/cygwin/posix.sgml
+++ b/winsup/cygwin/posix.sgml
@@ -890,6 +890,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     dn_expand
     dn_skipname
     drem
+    eaccess
     endusershell
     err
     errx
@@ -1005,6 +1006,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     asnprintf
     asprintf
     asprintf_r
+    canonicalize_file_name
     dremf
     envz_add
     envz_entry
@@ -1012,6 +1014,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     envz_merge
     envz_remove
     envz_strip
+    euidaccess
     exp10
     exp10f
     fcloseall
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 15dbc87..bd24adc 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3873,6 +3873,14 @@ faccessat (int dirfd, const char *pathname, int mode, int flags)
   return res;
 }

+/* Linux provides this extension.  */
+extern "C" int
+euidaccess (const char *pathname, int mode)
+{
+  return faccessat (AT_FDCWD, pathname, mode, AT_EACCESS);
+}
+
+
 extern "C" int
 fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
 {
@@ -3880,9 +3888,13 @@ fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
   myfault efault;
   if (efault.faulted (EFAULT))
     return -1;
-  if (flags & ~AT_SYMLINK_NOFOLLOW)
+  if (flags)
     {
-      set_errno (EINVAL);
+      /* BSD has lchmod, but Linux does not.  POSIX says
+	 AT_SYMLINK_NOFOLLOW is allowed to fail with EOPNOTSUPP, but
+	 only if pathname was a symlink; but Linux blindly fails with
+	 ENOTSUP even for non-symlinks.  */
+      set_errno ((flags & ~AT_SYMLINK_NOFOLLOW) ? EINVAL : ENOTSUP);
       return -1;
     }
   char *path = tp.c_get ();
-- 
1.6.5.rc1


--------------000608030704070505010809--
