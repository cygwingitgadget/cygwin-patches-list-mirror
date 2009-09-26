Return-Path: <cygwin-patches-return-6651-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30270 invoked by alias); 26 Sep 2009 20:18:09 -0000
Received: (qmail 30256 invoked by uid 22791); 26 Sep 2009 20:18:08 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta04.emeryville.ca.mail.comcast.net (HELO QMTA04.emeryville.ca.mail.comcast.net) (76.96.30.40)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Sep 2009 20:18:03 +0000
Received: from OMTA19.emeryville.ca.mail.comcast.net ([76.96.30.76]) 	by QMTA04.emeryville.ca.mail.comcast.net with comcast 	id lXpb1c0021eYJf8A4YJ2Tf; Sat, 26 Sep 2009 20:18:02 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA19.emeryville.ca.mail.comcast.net with comcast 	id lYJ11c0030Lg2Gw01YJ20C; Sat, 26 Sep 2009 20:18:02 +0000
Message-ID: <4ABE76F8.1050601@byu.net>
Date: Sat, 26 Sep 2009 20:18:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: fexecve, execvpe
Content-Type: multipart/mixed;  boundary="------------050805090001010407000802"
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
X-SW-Source: 2009-q3/txt/msg00105.txt.bz2

This is a multi-part message in MIME format.
--------------050805090001010407000802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1080

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

POSIX requires fexecve, and we had all the pieces ready to go.  And to my
surprise, we've had execvpe in the sources for a long time, but just
failed to export it (glibc just added execvpe in 2.10).  OK to apply,
along with the corresponding patch to new-features.sgml and tweaking
unistd.h in newlib?

P.S Any reason that "dtable.h" and "cygheap.h" aren't self-contained?

2009-09-26  Eric Blake  <ebb9@byu.net>

	* exec.cc (fexecve): New function.
	* cygwin.din (execvpe, fexecve): Export new fexecve and existing
	execvpe.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* posix.sgml: Mention them.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAkq+dvgACgkQ84KuGfSFAYAw3wCePP334FcS28GEkjMge4yz1IOq
4XkAl23iWbcAlOna9F2TmlU65qQ5Zag=
=eR4E
-----END PGP SIGNATURE-----

--------------050805090001010407000802
Content-Type: text/plain;
 name="cygwin.patch26"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch26"
Content-length: 2989

diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index bee9cd1..a10d18c 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -356,6 +356,7 @@ execve SIGFE
 _execve = execve SIGFE
 execvp SIGFE
 _execvp = execvp SIGFE
+execvpe SIGFE
 exit = cygwin_exit SIGFE
 _exit SIGFE
 exp NOSIGFE
@@ -454,6 +455,7 @@ feof SIGFE
 _feof = feof SIGFE
 ferror SIGFE
 _ferror = ferror SIGFE
+fexecve SIGFE
 fflush SIGFE
 _fflush = fflush SIGFE
 ffs NOSIGFE
diff --git a/winsup/cygwin/exec.cc b/winsup/cygwin/exec.cc
index ee0709c..131439f 100644
--- a/winsup/cygwin/exec.cc
+++ b/winsup/cygwin/exec.cc
@@ -1,6 +1,6 @@
 /* exec.cc: exec system call support.

-   Copyright 1996, 1997, 1998, 2000, 2001, 2002 Red Hat, Inc.
+   Copyright 1996, 1997, 1998, 2000, 2001, 2002, 2009 Red Hat, Inc.

 This file is part of Cygwin.

@@ -14,6 +14,10 @@ details. */
 #include "cygerrno.h"
 #include "path.h"
 #include "environ.h"
+#include "sync.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
 #undef _execve

 /* This is called _execve and not execve because the real execve is defined
@@ -91,3 +95,15 @@ execvpe (const char *path, char * const *argv, char *const *envp)
   path_conv buf;
   return  execve (find_exec (path, buf), argv, envp);
 }
+
+extern "C" int
+fexecve (int fd, char * const *argv, char *const *envp)
+{
+  cygheap_fdget cfd (fd);
+  if (cfd < 0)
+    {
+      syscall_printf ("-1 = fexecve (%d, %p, %p)", fd, argv, envp);
+      return -1;
+    }
+  return execve (cfd->pc.get_win32 (), argv, envp);
+}
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index bd05103..a396b1f 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -367,12 +367,13 @@ details. */
       211: Export fpurge, mkstemps.
       212: Add and export libstdc++ malloc wrappers.
       213: Export canonicalize_file_name, eaccess, euidaccess.
+      214: Export execvpe, fexecve.
      */

      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */

 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 213
+#define CYGWIN_VERSION_API_MINOR 214

      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff --git a/winsup/cygwin/posix.sgml b/winsup/cygwin/posix.sgml
index 48dce6c..06e49d2 100644
--- a/winsup/cygwin/posix.sgml
+++ b/winsup/cygwin/posix.sgml
@@ -152,6 +152,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     fdopendir
     feof
     ferror
+    fexecve
     fflush
     ffs
     fgetc
@@ -1015,6 +1016,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     envz_remove
     envz_strip
     euidaccess
+    execvpe
     exp10
     exp10f
     fcloseall
@@ -1227,7 +1229,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     fesetround
     fetestexcept
     feupdateenv
-    fexecve
     floorl
     fmal
     fmaxl
-- 
1.6.5.rc1


--------------050805090001010407000802--
