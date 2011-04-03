Return-Path: <cygwin-patches-return-7246-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7351 invoked by alias); 3 Apr 2011 23:58:50 -0000
Received: (qmail 7340 invoked by uid 22791); 3 Apr 2011 23:58:49 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP,TW_FP,TW_UF
X-Spam-Check-By: sourceware.org
Received: from mail-gy0-f171.google.com (HELO mail-gy0-f171.google.com) (209.85.160.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 03 Apr 2011 23:58:45 +0000
Received: by gye5 with SMTP id 5so2485710gye.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 16:58:44 -0700 (PDT)
Received: by 10.100.238.5 with SMTP id l5mr4651374anh.145.1301875124312;        Sun, 03 Apr 2011 16:58:44 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id t23sm4777014ano.51.2011.04.03.16.58.43        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 16:58:43 -0700 (PDT)
Subject: [PATCH] add information to /proc/version
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-vTRaoZJ8ACADMliXMkFG"
Date: Sun, 03 Apr 2011 23:58:00 -0000
Message-ID: <1301875126.3104.30.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00012.txt.bz2


--=-vTRaoZJ8ACADMliXMkFG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 455

On Linux, /proc/version also displays the username of the kernel
compiler and the version of gcc used to compile[1].  This patch does the
same for Cygwin:

$ cat /proc/version
CYGWIN_NT-6.1-WOW64 version 1.7.10(0.238/5/3) (Yaakov@YAAKOV04) (gcc
version 4.5.2 (GCC) ) 2011-03-30 18:56

Patches for winsup/cygwin and winsup/doc attached.


Yaakov

[1] http://docs.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6/html/Deployment_Guide/s2-proc-version.html


--=-vTRaoZJ8ACADMliXMkFG
Content-Disposition: attachment; filename="doc-proc-version.patch"
Content-Type: text/x-patch; name="doc-proc-version.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 713

2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* new-features.sgml (ov-new1.7.10): Document additional information
	in /proc/version.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.71
diff -u -r1.71 new-features.sgml
--- new-features.sgml	1 Apr 2011 19:49:16 -0000	1.71
+++ new-features.sgml	3 Apr 2011 23:55:49 -0000
@@ -20,6 +20,15 @@
 shared memory.
 </para></listitem>
 
+<listitem><para>
+/proc/version now shows the username of whomever compiled the Cygwin DLL
+as well as the version of GCC used when compiling.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--=-vTRaoZJ8ACADMliXMkFG
Content-Disposition: attachment; filename="proc-version.patch"
Content-Type: text/x-patch; name="proc-version.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1967

2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* Makefile.in (fhandler_proc_CFLAGS): Define USERNAME, HOSTNAME,
	and GCC_VERSION.
	* fhandler_proc.cc (format_proc_version):  Add build machine and GCC
	version information as on Linux.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.243
diff -u -r1.243 Makefile.in
--- Makefile.in	1 Apr 2011 19:48:19 -0000	1.243
+++ Makefile.in	3 Apr 2011 23:38:41 -0000
@@ -287,6 +287,9 @@
 uinfo_CFLAGS:=-fomit-frame-pointer
 endif
 
+fhandler_proc_CFLAGS+=-DUSERNAME="\"$(USER)\"" -DHOSTNAME="\"$(HOSTNAME)\""
+fhandler_proc_CFLAGS+=-DGCC_VERSION="\"`$(CC) -v 2>&1 | tail -n 1`\""
+
 _cygwin_crt0_common_STDINCFLAGS:=yes
 libstdcxx_wrapper_STDINCFLAGS:=yes
 cxx_STDINCFLAGS:=yes
Index: fhandler_proc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_proc.cc,v
retrieving revision 1.98
diff -u -r1.98 fhandler_proc.cc
--- fhandler_proc.cc	2 Apr 2011 11:32:55 -0000	1.98
+++ fhandler_proc.cc	3 Apr 2011 23:38:41 -0000
@@ -361,15 +361,19 @@
 static _off64_t
 format_proc_version (void *, char *&destbuf)
 {
+  tmp_pathbuf tp;
+  char *buf = tp.c_get ();
+  char *bufptr = buf;
   struct utsname uts_name;
 
   uname (&uts_name);
-  destbuf = (char *) crealloc_abort (destbuf, strlen (uts_name.sysname)
-					      + strlen (uts_name.release)
-					      + strlen (uts_name.version)
-					      + 4);
-  return __small_sprintf (destbuf, "%s %s %s\n",
-			  uts_name.sysname, uts_name.release, uts_name.version);
+  bufptr += __small_sprintf (bufptr, "%s version %s (%s@%s) (%s) %s\n",
+			  uts_name.sysname, uts_name.release, USERNAME, HOSTNAME,
+			  GCC_VERSION, uts_name.version);
+
+  destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
+  memcpy (destbuf, buf, bufptr - buf);
+  return bufptr - buf;
 }
 
 static _off64_t

--=-vTRaoZJ8ACADMliXMkFG--
