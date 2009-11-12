Return-Path: <cygwin-patches-return-6837-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14207 invoked by alias); 12 Nov 2009 10:10:38 -0000
Received: (qmail 14191 invoked by uid 22791); 12 Nov 2009 10:10:35 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from qw-out-1920.google.com (HELO qw-out-1920.google.com) (74.125.92.150)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Nov 2009 10:10:28 +0000
Received: by qw-out-1920.google.com with SMTP id 4so308565qwk.20         for <cygwin-patches@cygwin.com>; Thu, 12 Nov 2009 02:10:26 -0800 (PST)
Received: by 10.224.46.79 with SMTP id i15mr1462528qaf.58.1258020626449;         Thu, 12 Nov 2009 02:10:26 -0800 (PST)
Received: from ?192.168.0.101? (S010600112f237275.wp.shawcable.net [24.76.241.98])         by mx.google.com with ESMTPS id 21sm1941516qyk.0.2009.11.12.02.10.24         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Thu, 12 Nov 2009 02:10:25 -0800 (PST)
Message-ID: <4AFBDF1A.9020606@users.sourceforge.net>
Date: Thu, 12 Nov 2009 10:10:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.4pre) Gecko/20090915 Thunderbird/3.0b4
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>  <4AFB0042.90602@users.sourceforge.net>  <20091111202106.GA17519@ednor.casa.cgf.cx> <20091112094424.GA12637@calimero.vinschen.de>
In-Reply-To: <20091112094424.GA12637@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------010601020401050908050705"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00168.txt.bz2

This is a multi-part message in MIME format.
--------------010601020401050908050705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 307

On 12/11/2009 03:44, Corinna Vinschen wrote:
> In this case I'm rather surprised that these very GNU/Linux specific
> things are *not* in a linux/sysinfo.h file.  But it doesn't hurt to keep
> that in line with Linux, right?

In that case, here is a patch which declares directly in sys/sysinfo.h.


Yaakov

--------------010601020401050908050705
Content-Type: text/x-patch;
 name="cygwin-get_nprocs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-get_nprocs.patch"
Content-length: 3339

2009-11-12  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* sysconf.cc (get_nprocs, get_nprocs_conf): New functions.
	* cygwin.din: Export them.
	* include/sys/sysinfo.h: New header.
	(get_nprocs, get_nprocs_conf): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
	* posix.sgml: Mention them as GNU extensions.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.216
diff -u -r1.216 cygwin.din
--- cygwin.din	26 Sep 2009 21:01:10 -0000	1.216
+++ cygwin.din	12 Nov 2009 10:06:45 -0000
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
+++ posix.sgml	12 Nov 2009 10:06:47 -0000
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
+++ sysconf.cc	12 Nov 2009 10:06:48 -0000
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
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.302
diff -u -r1.302 version.h
--- include/cygwin/version.h	31 Oct 2009 13:24:06 -0000	1.302
+++ include/cygwin/version.h	12 Nov 2009 10:06:48 -0000
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
+++ include/sys/sysinfo.h	12 Nov 2009 10:06:48 -0000
@@ -0,0 +1,19 @@
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
+int get_nprocs_conf (void);
+int get_nprocs (void);
+
+#endif /* _SYS_SYSINFO_H */

--------------010601020401050908050705--
