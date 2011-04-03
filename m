Return-Path: <cygwin-patches-return-7244-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4325 invoked by alias); 3 Apr 2011 23:37:32 -0000
Received: (qmail 4315 invoked by uid 22791); 3 Apr 2011 23:37:30 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 03 Apr 2011 23:37:23 +0000
Received: by gxk22 with SMTP id 22so2479443gxk.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 16:37:23 -0700 (PDT)
Received: by 10.100.249.3 with SMTP id w3mr4775340anh.40.1301873842980;        Sun, 03 Apr 2011 16:37:22 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id w39sm4760610ana.39.2011.04.03.16.37.21        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 16:37:22 -0700 (PDT)
Subject: [PATCH] make <sys/sysmacros.h> compatible with glibc
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-Y3jNFDbHHa9UGACRDt9a"
Date: Sun, 03 Apr 2011 23:37:00 -0000
Message-ID: <1301873845.3104.26.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00010.txt.bz2


--=-Y3jNFDbHHa9UGACRDt9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 933

When building Qt Creator, I encountered a compile error because its code
uses 'major' and 'minor' as variable names.  Looking at the current
<sys/sysmacros.h>, which is pulled in automatically by <sys/types.h>,
makes it obvious why that doesn't work.

Since this code obviously compiles on Linux, I investigated further,
starting with:

http://www.kernel.org/doc/man-pages/online/pages/man3/minor.3.html

and running some tests on a Linux system.  In short, with glibc:

1) these are indeed macros, but;
2) the [name] macros point to gnu_dev_[name] functions;
3) the latter are defined as inline functions in <sys/sysmacros.h>;
4) the inline functions are used only if optimization is on.

Based on this, I refactored our existing macros into both inline and
normal functions.  An additional benefit is type-checking in the
arguments and return types of these functions.

Patches for winsup/cygwin and winsup/doc attached.


Yaakov


--=-Y3jNFDbHHa9UGACRDt9a
Content-Disposition: attachment; filename="sysmacros-inline.patch"
Content-Type: text/x-patch; name="sysmacros-inline.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 5683

2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/cygwin/types.h: Move #include <sys/sysmacros.h> to
	end of header so the latter get the dev_t typedef.
	* include/sys/sysmacros.h (gnu_dev_major, gnu_dev_minor,
	gnu_dev_makedev): Prototype and define as inline functions.
	(major, minor, makedev): Redefine in terms of gnu_dev_*.
	* miscfuncs.cc (gnu_dev_major, gnu_dev_minor, gnu_dev_makedev):
	New functions.
	* cygwin.din (gnu_dev_major, gnu_dev_minor, gnu_dev_makedev): Export.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* posix.sgml (std-gnu): Add gnu_dev_major, gnu_dev_minor, gnu_dev_makedev.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.234
diff -u -r1.234 cygwin.din
--- cygwin.din	29 Mar 2011 10:32:40 -0000	1.234
+++ cygwin.din	3 Apr 2011 20:43:11 -0000
@@ -802,6 +802,9 @@
 _gmtime = gmtime SIGFE
 gmtime_r SIGFE
 _gmtime_r = gmtime_r SIGFE
+gnu_dev_major NOSIGFE
+gnu_dev_makedev NOSIGFE
+gnu_dev_minor NOSIGFE
 grantpt NOSIGFE
 hcreate SIGFE
 hcreate_r SIGFE
Index: miscfuncs.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.58
diff -u -r1.58 miscfuncs.cc
--- miscfuncs.cc	12 Mar 2010 23:13:47 -0000	1.58
+++ miscfuncs.cc	3 Apr 2011 20:43:20 -0000
@@ -1,7 +1,7 @@
 /* miscfuncs.cc: misc funcs that don't belong anywhere else
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-   2005, 2006, 2007, 2008 Red Hat, Inc.
+   2005, 2006, 2007, 2008, 2010, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -9,6 +9,7 @@
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+#define __INSIDE_CYGWIN_GNU_DEV__
 #include "winsup.h"
 #include "miscfuncs.h"
 #include <sys/uio.h>
@@ -380,3 +381,21 @@
     *dst++ = '/';
   *dst++ = 0;
 }
+
+extern "C" int
+gnu_dev_major(dev_t dev)
+{
+	return (int)(((dev) >> 16) & 0xffff);
+}
+
+extern "C" int
+gnu_dev_minor(dev_t dev)
+{
+	return (int)((dev) & 0xffff);
+}
+
+extern "C" dev_t
+gnu_dev_makedev(int maj, int min)
+{
+	return (((maj) << 16) | ((min) & 0xffff));
+}
Index: include/cygwin/types.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/types.h,v
retrieving revision 1.33
diff -u -r1.33 types.h
--- include/cygwin/types.h	29 Mar 2011 10:32:40 -0000	1.33
+++ include/cygwin/types.h	3 Apr 2011 20:43:20 -0000
@@ -17,7 +17,6 @@
 #ifndef _CYGWIN_TYPES_H
 #define _CYGWIN_TYPES_H
 
-#include <sys/sysmacros.h>
 #include <stdint.h>
 #include <endian.h>
 
@@ -220,6 +219,8 @@
 #endif /* __INSIDE_CYGWIN__ */
 #endif /* _CYGWIN_TYPES_H */
 
+#include <sys/sysmacros.h>
+
 #ifdef __cplusplus
 }
 #endif
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.339
diff -u -r1.339 version.h
--- include/cygwin/version.h	29 Mar 2011 10:32:40 -0000	1.339
+++ include/cygwin/version.h	3 Apr 2011 20:43:20 -0000
@@ -403,12 +403,13 @@
       237: Export strchrnul.
       238: Export pthread_spin_destroy, pthread_spin_init, pthread_spin_lock,
 	   pthread_spin_trylock, pthread_spin_unlock.
+      239: Export gnu_dev_major, gnu_dev_minor, gnu_dev_makedev.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 238
+#define CYGWIN_VERSION_API_MINOR 239
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: include/sys/sysmacros.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/sysmacros.h,v
retrieving revision 1.4
diff -u -r1.4 sysmacros.h
--- include/sys/sysmacros.h	26 Feb 2010 09:36:21 -0000	1.4
+++ include/sys/sysmacros.h	3 Apr 2011 20:43:20 -0000
@@ -1,6 +1,6 @@
 /* sys/sysmacros.h
 
-   Copyright 1998, 2001, 2010 Red Hat, Inc.
+   Copyright 1998, 2001, 2010, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -11,8 +11,34 @@
 #ifndef _SYS_SYSMACROS_H
 #define _SYS_SYSMACROS_H
 
-#define major(dev) ((int)(((dev) >> 16) & 0xffff))
-#define minor(dev) ((int)((dev) & 0xffff))
-#define makedev(major, minor) (((major) << 16) | ((minor) & 0xffff))
+extern int gnu_dev_major(dev_t);
+extern int gnu_dev_minor(dev_t);
+extern dev_t gnu_dev_makedev(int, int);
+
+#if defined (__OPTIMIZE__) && !defined (__NO_INLINE__) && !defined (__INSIDE_CYGWIN_GNU_DEV__)
+
+_ELIDABLE_INLINE int
+gnu_dev_major(dev_t dev)
+{
+	return (int)(((dev) >> 16) & 0xffff);
+}
+
+_ELIDABLE_INLINE int
+gnu_dev_minor(dev_t dev)
+{
+	return (int)((dev) & 0xffff);
+}
+
+_ELIDABLE_INLINE dev_t
+gnu_dev_makedev(int maj, int min)
+{
+	return (((maj) << 16) | ((min) & 0xffff));
+}
+
+#endif /* __OPTIMIZE__ && !__NO_INLINE__ && !__INSIDE_CYGWIN_GNU_DEV__ */
+
+#define major(dev) gnu_dev_major(dev)
+#define minor(dev) gnu_dev_minor(dev)
+#define makedev(maj, min) gnu_dev_makedev(maj, min)
 
 #endif /* _SYS_SYSMACROS_H */
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.55
diff -u -r1.55 posix.sgml
--- posix.sgml	29 Mar 2011 10:32:40 -0000	1.55
+++ posix.sgml	3 Apr 2011 20:48:15 -0000
@@ -1103,6 +1103,9 @@
     getopt_long
     getopt_long_only
     getxattr
+    gnu_dev_major
+    gnu_dev_makedev
+    gnu_dev_minor
     lgetxattr
     listxattr
     llistxattr

--=-Y3jNFDbHHa9UGACRDt9a
Content-Disposition: attachment; filename="doc-sysmacros.patch"
Content-Type: text/x-patch; name="doc-sysmacros.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 621

2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

    * new-features.sgml (ov-new1.7.10): Add "new API" paragraph.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.71
diff -u -r1.71 new-features.sgml
--- new-features.sgml	1 Apr 2011 19:49:16 -0000	1.71
+++ new-features.sgml	3 Apr 2011 22:18:41 -0000
@@ -20,6 +20,10 @@
 shared memory.
 </para></listitem>
 
+<listitem><para>
+New API: gnu_dev_major, gnu_dev_minor, gnu_dev_makedev.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--=-Y3jNFDbHHa9UGACRDt9a--
