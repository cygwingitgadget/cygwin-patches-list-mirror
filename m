Return-Path: <cygwin-patches-return-4731-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26306 invoked by alias); 8 May 2004 01:05:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26288 invoked from network); 8 May 2004 01:05:08 -0000
Message-Id: <3.0.5.32.20040507210208.008081c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 08 May 2004 01:05:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Improving the anonymous ftp environment.
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q2/txt/msg00083.txt.bz2

The background of this patch is that in order to test the chdir
patch under chroot condition I setup an anonymous ftp account.

I realized that to be able to ls (under anonymous) I had to
copy /bin/ls.exe to /home/ftp/bin, but also the cygwin1.dll and
all other dll's used by ls.exe. That flies in the face of our
recommendation to have only one cygwin1.dll, and it's a pain to
maintain (Sure, we could add smarts to setup).

So it was obvious that the Windows PATH did not contain 
c:\cygwin\bin  (for the uninitiated, the Windows and the Cygwin
environments are not identical).

Looking into it, the Cygwin PATH seen by ls had its standard
pre-chroot value, but the Windows PATH was NULL. The conversion
from Posix paths to Win32 paths fails because some paths are 
outside of the chroot area.

The solution uses the fact that the Posix and Win32 values of PATH
are cached into a win_env structure. It initializes that structure
before changing the root, so that there is no conversion issue. 
Also the NO_COPY attribute of the cache is removed, so that it 
propagates across forks (also avoiding a small memory leak, as it 
points to malloced areas).

There are other solutions, but I couldn't think of anything
simpler.

Pierre

2004-05-08  Pierre Humblet <pierre.humblet@ieee.org>
 
	* syscalls.cc: Include environ.h.
	(chroot): Set errno in case of path error. Call getwinenv.
	* environ.cc: Remove the NO_COPY attribute of conv_envvars.


Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.336
diff -u -p -r1.336 syscalls.cc
--- syscalls.cc	3 May 2004 11:53:07 -0000	1.336
+++ syscalls.cc	8 May 2004 00:46:56 -0000
@@ -61,6 +61,7 @@ details. */
 #include "pwdgrp.h"
 #include "cpuid.h"
 #include "registry.h"
+#include "environ.h"
 
 #undef _close
 #undef _lseek
@@ -2232,21 +2222,16 @@ chroot (const char *newroot)
 {
   path_conv path (newroot, PC_SYM_FOLLOW | PC_FULL | PC_POSIX);
 
-  int ret;
+  int ret = -1;
   if (path.error)
-    ret = -1;
+    __seterrno ();
   else if (!path.exists ())
-    {
-      set_errno (ENOENT);
-      ret = -1;
-    }
+    set_errno (ENOENT);
   else if (!path.isdir ())
-    {
-      set_errno (ENOTDIR);
-      ret = -1;
-    }
+    set_errno (ENOTDIR);
   else
     {
+      getwinenv("PATH="); /* Save the native PATH */
       cygheap->root.set (path.normalized_path, path);
       ret = 0;
     }
Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.97
diff -u -p -r1.97 environ.cc
--- environ.cc	14 Nov 2003 23:40:05 -0000	1.97
+++ environ.cc	8 May 2004 00:46:58 -0000
@@ -54,7 +54,7 @@ static char **lastenviron;
    CreateProcess.  HOME is here because most shells use it and would be
    confused by Windows style path names.  */
 static int return_MAX_PATH (const char *) {return CYG_MAX_PATH;}
-static NO_COPY win_env conv_envvars[] =
+static win_env conv_envvars[] =
   {
     {NL ("PATH="), NULL, NULL, cygwin_win32_to_posix_path_list,
      cygwin_posix_to_win32_path_list,
