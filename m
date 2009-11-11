Return-Path: <cygwin-patches-return-6827-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29900 invoked by alias); 11 Nov 2009 07:23:35 -0000
Received: (qmail 29840 invoked by uid 22791); 11 Nov 2009 07:23:33 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.146)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 07:23:29 +0000
Received: by qw-out-1920.google.com with SMTP id 4so127952qwk.20         for <cygwin-patches@cygwin.com>; Tue, 10 Nov 2009 23:23:27 -0800 (PST)
Received: by 10.224.66.136 with SMTP id n8mr606662qai.328.1257924206998;         Tue, 10 Nov 2009 23:23:26 -0800 (PST)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 22sm1114583qyk.6.2009.11.10.23.23.25         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 10 Nov 2009 23:23:26 -0800 (PST)
Message-ID: <4AFA6675.6070408@users.sourceforge.net>
Date: Wed, 11 Nov 2009 07:23:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] add get_nprocs, get_nprocs_conf
Content-Type: multipart/mixed;  boundary="------------000409080702060708040007"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00158.txt.bz2

This is a multi-part message in MIME format.
--------------000409080702060708040007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 217

get_nprocs and get_nprocs_conf are GNU extensions which do the same 
thing as sysconf(_SC_NPROCESSORS_CONF/_ONLN).[1]

Patch attached.


Yaakov

[1] http://www.gnu.org/s/libc/manual/html_node/Processor-Resources.html

--------------000409080702060708040007
Content-Type: text/x-patch;
 name="cygwin-get_nprocs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-get_nprocs.patch"
Content-length: 4017

2009-11-11  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* sysconf.cc (get_nprocs, get_nprocs_conf): New functions.
	* cygwin.din: Export them.
	* include/sys/sysinfo.h: New header.
	* include/cygwin/sysinfo.h: New header.
	(get_nprocs, get_nprocs_conf): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* posix.sgml: Mention them as GNU extensions.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.216
diff -u -r1.216 cygwin.din
--- cygwin.din	26 Sep 2009 21:01:10 -0000	1.216
+++ cygwin.din	11 Nov 2009 07:07:51 -0000
@@ -598,6 +598,8 @@
 _gcvt = gcvt SIGFE
 gcvtf SIGFE
 _gcvtf = gcvtf SIGFE
+get_nprocs SIGFE
+get_nprocs_conf SIGFE
 get_osfhandle SIGFE
 _get_osfhandle = get_osfhandle SIGFE
 getaddrinfo = cygwin_getaddrinfo SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.39
diff -u -r1.39 posix.sgml
--- posix.sgml	26 Sep 2009 21:01:10 -0000	1.39
+++ posix.sgml	11 Nov 2009 07:07:52 -0000
@@ -1026,6 +1026,8 @@
     fopencookie
     fremovexattr
     fsetxattr
+    get_nprocs
+    get_nprocs_conf
     getopt_long
     getopt_long_only
     getxattr
Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.52
diff -u -r1.52 sysconf.cc
--- sysconf.cc	7 Apr 2008 18:45:59 -0000	1.52
+++ sysconf.cc	11 Nov 2009 07:07:52 -0000
@@ -292,3 +292,15 @@
   set_errno (EINVAL);
   return 0;
 }
+
+extern "C" int
+get_nprocs_conf (void)
+{
+  return get_nproc_values(_SC_NPROCESSORS_CONF);
+}
+
+extern "C" int
+get_nprocs (void)
+{
+  return get_nproc_values(_SC_NPROCESSORS_ONLN);
+}
Index: include/cygwin/sysinfo.h
===================================================================
RCS file: include/cygwin/sysinfo.h
diff -N include/cygwin/sysinfo.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/cygwin/sysinfo.h	11 Nov 2009 07:07:53 -0000
@@ -0,0 +1,17 @@
+/* cygwin/sysinfo.h
+
+   Copyright 2009 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _CYGWIN_SYSINFO_H
+#define _CYGWIN_SYSINFO_H
+
+int get_nprocs_conf (void);
+int get_nprocs (void);
+
+#endif /* _CYGWIN_SYSINFO_H */
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.302
diff -u -r1.302 version.h
--- include/cygwin/version.h	31 Oct 2009 13:24:06 -0000	1.302
+++ include/cygwin/version.h	11 Nov 2009 07:07:53 -0000
@@ -371,12 +371,13 @@
       215: CW_EXIT_PROCESS added.
       216: CW_SET_EXTERNAL_TOKEN added.
       217: CW_GET_INSTKEY added.
+      218: Export get_nprocs, get_nprocs_conf.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 217
+#define CYGWIN_VERSION_API_MINOR 218
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: include/sys/sysinfo.h
===================================================================
RCS file: include/sys/sysinfo.h
diff -N include/sys/sysinfo.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ include/sys/sysinfo.h	11 Nov 2009 07:07:53 -0000
@@ -0,0 +1,18 @@
+/* sys/sysinfo.h
+
+   Copyright 2009 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+/* sys/sysinfo.h header file for Cygwin.  */
+
+#ifndef _SYS_SYSINFO_H
+#define _SYS_SYSINFO_H
+
+#include <cygwin/sysinfo.h>
+
+#endif /* _SYS_SYSINFO_H */

--------------000409080702060708040007--
