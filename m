Return-Path: <cygwin-patches-return-8041-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19219 invoked by alias); 18 Dec 2014 16:13:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 19195 invoked by uid 89); 18 Dec 2014 16:13:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 18 Dec 2014 16:13:10 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBIGD8q3031979	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2014 11:13:08 -0500
Received: from [10.10.116.25] ([10.10.116.25])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sBIGD5LX032535	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2014 11:13:07 -0500
Message-ID: <5492FD19.6030407@cygwin.com>
Date: Thu, 18 Dec 2014 16:13:00 -0000
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Export new stdio and stdio_ext functions
Content-Type: multipart/mixed; boundary="------------020002050401030108030009"
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00020.txt.bz2

This is a multi-part message in MIME format.
--------------020002050401030108030009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 116

These patches export the BSD, GNU, and Solaris stdio extensions (27 in 
total) recently added to newlib.

--
Yaakov

--------------020002050401030108030009
Content-Type: text/x-patch;
 name="cygwin-stdio-new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-stdio-new.patch"
Content-length: 4306

2014-12-18  Yaakov Selkowitz  <yselkowitz@...>

	* common.din (__fbufsize, __flbf, __fpending, __freadable, __freading,
	__fsetlocking, __fwritable, __fwriting, clearerr_unlocked,
	feof_unlocked, ferror_unlocked, fflush_unlocked, fgetc_unlocked,
	fgets_unlocked, fgetwc_unlocked, fgetws_unlocked, fileno_unlocked,
	fputc_unlocked, fputs_unlocked, fputwc_unlocked, fputws_unlocked,
	fread_unlocked, fwrite_unlocked, getwc_unlocked, getwchar_unlocked,
	putwc_unlocked, putwchar_unlocked): Export.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin/common.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/common.din,v
retrieving revision 1.14
diff -u -p -r1.14 common.din
--- cygwin/common.din	5 Dec 2014 16:31:36 -0000	1.14
+++ cygwin/common.din	17 Dec 2014 21:17:26 -0000
@@ -49,9 +49,17 @@ __dn_expand SIGFE
 __dn_skipname SIGFE
 __eprintf SIGFE
 __errno NOSIGFE
+__fbufsize NOSIGFE
+__flbf NOSIGFE
 __fpclassifyd NOSIGFE
 __fpclassifyf NOSIGFE
+__fpending NOSIGFE
 __fpurge SIGFE
+__freadable NOSIGFE
+__freading NOSIGFE
+__fsetlocking SIGFE
+__fwritable NOSIGFE
+__fwriting NOSIGFE
 __getreent NOSIGFE
 __infinity NOSIGFE
 __isinfd NOSIGFE
@@ -209,6 +217,7 @@ cimag NOSIGFE
 cimagf NOSIGFE
 cleanup_glue NOSIGFE
 clearerr SIGFE
+clearerr_unlocked SIGFE
 clock SIGFE
 clock_getcpuclockid SIGFE
 clock_getres SIGFE
@@ -364,8 +373,10 @@ fegetprec NOSIGFE
 fegetround NOSIGFE
 feholdexcept SIGFE
 feof SIGFE
+feof_unlocked SIGFE
 feraiseexcept SIGFE
 ferror SIGFE
+ferror_unlocked SIGFE
 fesetenv SIGFE
 fesetexceptflag SIGFE
 fesetprec NOSIGFE
@@ -374,16 +385,22 @@ fetestexcept NOSIGFE
 feupdateenv SIGFE
 fexecve SIGFE
 fflush SIGFE
+fflush_unlocked SIGFE
 ffs NOSIGFE
 ffsl NOSIGFE
 ffsll NOSIGFE
 fgetc SIGFE
+fgetc_unlocked SIGFE
 fgetpos SIGFE
 fgets SIGFE
+fgets_unlocked SIGFE
 fgetwc SIGFE
+fgetwc_unlocked SIGFE
 fgetws SIGFE
+fgetws_unlocked SIGFE
 fgetxattr SIGFE
 fileno SIGFE
+fileno_unlocked SIGFE
 finite NOSIGFE
 finitef NOSIGFE
 fiprintf SIGFE
@@ -410,10 +427,15 @@ fpathconf SIGFE
 fprintf SIGFE
 fpurge SIGFE
 fputc SIGFE
+fputc_unlocked SIGFE
 fputs SIGFE
+fputs_unlocked SIGFE
 fputwc SIGFE
+fputwc_unlocked SIGFE
 fputws SIGFE
+fputws_unlocked SIGFE
 fread SIGFE
+fread_unlocked SIGFE
 free SIGFE
 freeaddrinfo = cygwin_freeaddrinfo SIGFE
 freeifaddrs SIGFE
@@ -454,6 +476,7 @@ futimesat SIGFE
 fwide SIGFE
 fwprintf SIGFE
 fwrite SIGFE
+fwrite_unlocked SIGFE
 fwscanf SIGFE
 gai_strerror = cygwin_gai_strerror NOSIGFE
 gamma NOSIGFE
@@ -546,7 +569,9 @@ getutxid SIGFE
 getutxline SIGFE
 getw SIGFE
 getwc SIGFE
+getwc_unlocked SIGFE
 getwchar SIGFE
+getwchar_unlocked SIGFE
 getwd SIGFE
 getxattr SIGFE
 glob SIGFE
@@ -918,7 +943,9 @@ pututline SIGFE
 pututxline SIGFE
 putw SIGFE
 putwc SIGFE
+putwc_unlocked SIGFE
 putwchar SIGFE
+putwchar_unlocked SIGFE
 pwrite SIGFE
 qsort NOSIGFE
 qsort_r NOSIGFE
Index: cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.415
diff -u -p -r1.415 version.h
--- cygwin/include/cygwin/version.h	8 Dec 2014 11:21:14 -0000	1.415
+++ cygwin/include/cygwin/version.h	17 Dec 2014 21:17:26 -0000
@@ -458,12 +458,19 @@ details. */
       280: Static atexit in libcygwin.a, CW_FIXED_ATEXIT.
       281: Add CW_GETNSS_PWD_SRC, CW_GETNSS_GRP_SRC.
       282: Export __bsd_qsort_r, qsort_r.
+      283: Export __fbufsize, __flbf, __fpending, __freadable, __freading,
+           __fsetlocking, __fwritable, __fwriting. clearerr_unlocked,
+           feof_unlocked, ferror_unlocked, fflush_unlocked, fgetc_unlocked,
+           fgets_unlocked, fgetwc_unlocked, fgetws_unlocked, fileno_unlocked,
+           fputc_unlocked, fputs_unlocked, fputwc_unlocked, fputws_unlocked,
+           fread_unlocked, fwrite_unlocked, getwc_unlocked, getwchar_unlocked,
+           putwc_unlocked, putwchar_unlocked.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 282
+#define CYGWIN_VERSION_API_MINOR 283
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------020002050401030108030009
Content-Type: text/x-patch;
 name="doc-stdio-new.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="doc-stdio-new.patch"
Content-length: 3469

2014-12-18  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.xml (ov-new1.7.34): Document Solaris stdio_ext.h
	functions and BSD/GNU unlocked stdio extensions.
	* posix.xml (std-bsd): Add BSD unlocked stdio extensions.
	(std-gnu): Add GNU unlocked stdio extensions.
	(std-solaris): Add stdio_ext.h functions.

Index: doc/new-features.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.xml,v
retrieving revision 1.39
diff -u -p -r1.39 new-features.xml
--- doc/new-features.xml	15 Dec 2014 20:30:15 -0000	1.39
+++ doc/new-features.xml	17 Dec 2014 21:16:50 -0000
@@ -60,6 +60,19 @@ default Windows environment into the new
 New APIs: qsort_r, __bsd_qsort_r.
 </para></listitem>
 
+<listitem><para>
+New APIs: __fbufsize, __flbf, __fpending, __freadable, __freading,
+__fsetlocking, __fwritable, __fwriting.
+</para></listitem>
+
+<listitem><para>
+New APIs: clearerr_unlocked, feof_unlocked, ferror_unlocked, fflush_unlocked,
+fgetc_unlocked, fgets_unlocked, fgetwc_unlocked, fgetws_unlocked,
+fileno_unlocked, fputc_unlocked, fputs_unlocked, fputwc_unlocked,
+fputws_unlocked, fread_unlocked, fwrite_unlocked, getwc_unlocked,
+getwchar_unlocked, putwc_unlocked, putwchar_unlocked.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
Index: doc/posix.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/posix.xml,v
retrieving revision 1.5
diff -u -p -r1.5 posix.xml
--- doc/posix.xml	6 Dec 2014 17:13:00 -0000	1.5
+++ doc/posix.xml	17 Dec 2014 21:16:50 -0000
@@ -993,6 +993,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     bindresvport_sa
     cfmakeraw
     cfsetspeed
+    clearerr_unlocked
     daemon
     dn_comp
     dn_expand
@@ -1002,12 +1003,19 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     endusershell
     err
     errx
+    feof_unlocked
+    ferror_unlocked
+    fflush_unlocked
+    fileno_unlocked
+    fgetc_unlocked
     finite
     finitef
     fiprintf
     flock			(see chapter "Implementation Notes")
     forkpty
     fpurge
+    fputc_unlocked
+    fread_unlocked
     freeifaddrs
     fstatfs
     fts_children
@@ -1020,6 +1028,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     fts_set_clientptr
     funopen
     futimes
+    fwrite_unlocked
     gamma
     gamma_r
     gammaf
@@ -1144,9 +1153,15 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     fegetexcept
     ffsl
     ffsll
+    fgets_unlocked
+    fgetwc_unlocked
+    fgetws_unlocked
     fgetxattr
     flistxattr
     fopencookie
+    fputs_unlocked
+    fputwc_unlocked
+    fputws_unlocked
     fremovexattr
     fsetxattr
     get_avphys_pages
@@ -1158,6 +1173,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     getopt_long
     getopt_long_only
     getpt
+    getwc_unlocked
+    getwchar_unlocked
     getxattr
     lgetxattr
     listxattr
@@ -1176,6 +1193,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pthread_getattr_np
     pthread_sigqueue
     ptsname_r
+    putwc_unlocked
+    putwchar_unlocked
     qsort_r			(see chapter "Implementation Notes")
     quotactl
     rawmemchr
@@ -1199,7 +1218,15 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
 <sect1 id="std-solaris"><title>System interfaces compatible with Solaris or SunOS functions:</title>
 
 <screen>
+    __fbufsize
+    __flbf
+    __fpending
     __fpurge
+    __freadable
+    __freading
+    __fsetlocking
+    __fwritable
+    __fwriting
     acl
     aclcheck
     aclfrommode

--------------020002050401030108030009--
