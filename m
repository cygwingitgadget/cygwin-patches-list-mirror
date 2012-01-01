Return-Path: <cygwin-patches-return-7577-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19549 invoked by alias); 1 Jan 2012 02:45:24 -0000
Received: (qmail 19539 invoked by uid 22791); 1 Jan 2012 02:45:22 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP,TW_SF,TW_TW,TW_VP,TW_VT
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f171.google.com (HELO mail-qy0-f171.google.com) (209.85.216.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 01 Jan 2012 02:45:08 +0000
Received: by qcsc20 with SMTP id c20so9444379qcs.2        for <cygwin-patches@cygwin.com>; Sat, 31 Dec 2011 18:45:07 -0800 (PST)
Received: by 10.229.76.139 with SMTP id c11mr16163460qck.122.1325385906902;        Sat, 31 Dec 2011 18:45:06 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id gw5sm55403621qab.11.2011.12.31.18.45.05        (version=SSLv3 cipher=OTHER);        Sat, 31 Dec 2011 18:45:06 -0800 (PST)
Message-ID: <1325385907.4064.7.camel@YAAKOV04>
Subject: [PATCH] Add get_current_dir_name(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Sun, 01 Jan 2012 02:45:00 -0000
Content-Type: multipart/mixed; boundary="=-tA4L4zmKZqcInz4xTZDP"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00000.txt.bz2


--=-tA4L4zmKZqcInz4xTZDP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 883

This patchset adds get_current_dir_name(3), a GNU extension:

http://www.gnu.org/software/libc/manual/html_node/Working-Directory.html
http://www.kernel.org/doc/man-pages/online/pages/man3/getcwd.3.html

The test code will show the difference between get_current_dir_name()
and getcwd(NULL, 0) when you cd into a directory via a symlink:

$ gcc -Wall -o test-get_current_dir_name.exe test-get_current_dir_name.c
$ mkdir /tmp/real
$ ln -s real /tmp/symlink
$ cd /tmp/symlink
$ /path/to/test-get_current_dir_name.exe
                  PWD: /tmp/symlink
               getcwd: /tmp/real
 get_current_dir_name: /tmp/symlink

: now try spoofing PWD
$ PWD=$HOME /path/to/test-get_current_dir_name.exe
                  PWD: /home/Yaakov
               getcwd: /tmp/real
 get_current_dir_name: /tmp/real

Patches for newlib, winsup/cygwin, and winsup/doc, plus the STC,
attached.


Yaakov


--=-tA4L4zmKZqcInz4xTZDP
Content-Disposition: attachment; filename="cygwin-get_current_dir_name.patch"
Content-Type: text/x-patch; name="cygwin-get_current_dir_name.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2936

2011-12-31  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (get_current_dir_name): Export.
	* path.cc (get_current_dir_name): New function.
	* posix.sgml (std-gnu): Add get_current_dir_name.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.249
diff -u -p -r1.249 cygwin.din
--- cygwin.din	7 Nov 2011 20:05:48 -0000	1.249
+++ cygwin.din	27 Dec 2011 11:28:05 -0000
@@ -672,6 +672,7 @@ _gcvt = gcvt SIGFE
 gcvtf SIGFE
 _gcvtf = gcvtf SIGFE
 get_avphys_pages SIGFE
+get_current_dir_name SIGFE
 get_nprocs SIGFE
 get_nprocs_conf SIGFE
 get_osfhandle SIGFE
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.644
diff -u -p -r1.644 path.cc
--- path.cc	24 Dec 2011 13:11:34 -0000	1.644
+++ path.cc	27 Dec 2011 11:28:06 -0000
@@ -2855,6 +2855,27 @@ getwd (char *buf)
   return getcwd (buf, PATH_MAX + 1);  /*Per SuSv3!*/
 }
 
+extern "C" char *
+get_current_dir_name (void)
+{
+  char *pwd = getenv ("PWD");
+  char *cwd = getcwd (NULL, 0);
+
+  if (pwd)
+    {
+      struct __stat64 pwdbuf, cwdbuf;
+      stat64 (pwd, &pwdbuf);
+      stat64 (cwd, &cwdbuf);
+      if (pwdbuf.st_ino == cwdbuf.st_ino)
+        {
+          cwd = (char *) malloc (strlen (pwd) + 1);
+          strcpy (cwd, pwd);
+        }
+    }
+
+  return cwd;
+}
+
 /* chdir: POSIX 5.2.1.1 */
 extern "C" int
 chdir (const char *in_dir)
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.72
diff -u -p -r1.72 posix.sgml
--- posix.sgml	8 Nov 2011 09:24:58 -0000	1.72
+++ posix.sgml	27 Dec 2011 11:28:06 -0000
@@ -1111,6 +1111,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     fremovexattr
     fsetxattr
     get_avphys_pages
+    get_current_dir_name
     get_phys_pages
     get_nprocs
     get_nprocs_conf
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.357
diff -u -p -r1.357 version.h
--- include/cygwin/version.h	22 Dec 2011 12:25:10 -0000	1.357
+++ include/cygwin/version.h	27 Dec 2011 11:28:06 -0000
@@ -426,12 +426,13 @@ details. */
       255: Export ptsname_r.
       256: Add CW_ALLOC_DRIVE_MAP, CW_MAP_DRIVE_MAP, CW_FREE_DRIVE_MAP.
       257: Export getpt.
+      258: Export get_current_dir_name.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 257
+#define CYGWIN_VERSION_API_MINOR 258
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-tA4L4zmKZqcInz4xTZDP
Content-Disposition: attachment; filename="doc-get_current_dir_name.patch"
Content-Type: text/x-patch; name="doc-get_current_dir_name.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 878

2011-12-31  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document get_current_dir_name.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.95
diff -u -p -r1.95 new-features.sgml
--- new-features.sgml	30 Dec 2011 20:24:18 -0000	1.95
+++ new-features.sgml	1 Jan 2012 02:27:44 -0000
@@ -101,8 +101,9 @@ dlopen now supports the Glibc-specific R
 </para></listitem>
 
 <listitem><para>
-Other new API: clock_settime, __fpurge, getgrouplist, getpt, ppoll, psiginfo,
-psignal, ptsname_r, sys_siglist, pthread_setschedprio, sysinfo.
+Other new API: clock_settime, __fpurge, getgrouplist, get_current_dir_name,
+getpt, ppoll, psiginfo, psignal, ptsname_r, sys_siglist, pthread_setschedprio,
+sysinfo.
 </para></listitem>
 
 </itemizedlist>

--=-tA4L4zmKZqcInz4xTZDP
Content-Disposition: attachment; filename="newlib-get_current_dir_name.patch"
Content-Type: text/x-patch; name="newlib-get_current_dir_name.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 851

2011-12-31  Yaakov Selkowitz  <yselkowitz@...>

	* libc/include/sys/unistd.h [__CYGWIN__] (get_current_dir_name):
	Declare.

Index: libc/include/sys/unistd.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/unistd.h,v
retrieving revision 1.79
diff -u -p -r1.79 unistd.h
--- libc/include/sys/unistd.h	19 Aug 2011 14:29:34 -0000	1.79
+++ libc/include/sys/unistd.h	27 Dec 2011 11:30:24 -0000
@@ -71,6 +71,9 @@ pid_t   _EXFUN(fork, (void ));
 long    _EXFUN(fpathconf, (int __fd, int __name ));
 int     _EXFUN(fsync, (int __fd));
 int     _EXFUN(fdatasync, (int __fd));
+#if defined(__CYGWIN__)
+char *	_EXFUN(get_current_dir_name, (void));
+#endif
 char *  _EXFUN(getcwd, (char *__buf, size_t __size ));
 #if defined(__CYGWIN__)
 int	_EXFUN(getdomainname ,(char *__name, size_t __len));

--=-tA4L4zmKZqcInz4xTZDP
Content-Disposition: attachment; filename="test-get_current_dir_name.c"
Content-Type: text/x-csrc; name="test-get_current_dir_name.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 692

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#ifdef __CYGWIN__
#include <dlfcn.h>
#include <cygwin/version.h>
#endif

int
main (void)
{
#if defined(__CYGWIN__) && CYGWIN_VERSION_API_MINOR < 258
  char *(*get_current_dir_name) (void);
  get_current_dir_name = dlsym (dlopen ("cygwin1.dll", 0), "get_current_dir_name");
#endif

  char *pwd = getenv ("PWD");
  char *cwd = getcwd (NULL, 0);
  char *gcdn = get_current_dir_name ();

  printf ("                  PWD: %s\n", pwd);
  printf ("               getcwd: %s\n", cwd);
  printf (" get_current_dir_name: %s\n", gcdn);

  free (cwd);
  free (gcdn);

  return 0;
}

--=-tA4L4zmKZqcInz4xTZDP--
