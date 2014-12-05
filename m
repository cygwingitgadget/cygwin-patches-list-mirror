Return-Path: <cygwin-patches-return-8039-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12675 invoked by alias); 5 Dec 2014 03:08:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 12656 invoked by uid 89); 5 Dec 2014 03:08:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.6 required=5.0 tests=AWL,BAYES_00,SPF_HELO_PASS autolearn=ham version=3.3.2
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 05 Dec 2014 03:08:45 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sB538hJB022781	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)	for <cygwin-patches@cygwin.com>; Thu, 4 Dec 2014 22:08:43 -0500
Received: from [10.10.116.25] ([10.10.116.25])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sB538fpg008564	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)	for <cygwin-patches@cygwin.com>; Thu, 4 Dec 2014 22:08:42 -0500
Message-ID: <548121B7.2010803@cygwin.com>
Date: Fri, 05 Dec 2014 03:08:00 -0000
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] qsort_r (pending newlib patch)
Content-Type: multipart/mixed; boundary="------------070807090801010704010100"
X-IsSubscribed: yes
X-SW-Source: 2014-q4/txt/msg00018.txt.bz2

This is a multi-part message in MIME format.
--------------070807090801010704010100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 21

Attached.

--
Yaakov

--------------070807090801010704010100
Content-Type: text/plain; charset=windows-1252;
 name="winsup-qsort_r.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="winsup-qsort_r.patch"
Content-length: 3521

2014-12-04  Yaakov Selkowitz  <yselkowitz@...>

	doc/
	* new-features.xml (ov-new1.7.34): Document qsort_r and __bsd_qsort_r.
	* posix.xml (std-bsd): Add qsort_r.
	(std-gnu): Ditto.
	(std-notes): Add section for qsort_r.

	cygwin/
	* common.din (__bsd_qsort_r): Add.
	(qsort_r): Add.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: doc/new-features.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.xml,v
retrieving revision 1.36
diff -u -p -r1.36 new-features.xml
--- doc/new-features.xml	13 Nov 2014 13:10:26 -0000	1.36
+++ doc/new-features.xml	5 Dec 2014 01:22:25 -0000
@@ -36,6 +36,10 @@ are supposed to work.  Finally implement
 getfacl(1)/setfacl(1) accordingly.
 </para></listitem>
 
+<listitem><para>
+New APIs: qsort_r, __bsd_qsort_r.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
Index: doc/posix.xml
===================================================================
RCS file: /cvs/src/src/winsup/doc/posix.xml,v
retrieving revision 1.3
diff -u -p -r1.3 posix.xml
--- doc/posix.xml	22 Oct 2014 19:29:33 -0000	1.3
+++ doc/posix.xml	5 Dec 2014 01:22:26 -0000
@@ -1047,6 +1047,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     madvise
     mkstemps
     openpty
+    qsort_r			(see chapter "Implementation Notes")
     rcmd
     rcmd_af
     reallocf
@@ -1175,6 +1176,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pthread_getattr_np
     pthread_sigqueue
     ptsname_r
+    qsort_r			(see chapter "Implementation Notes")
     quotactl
     rawmemchr
     removexattr
@@ -1568,6 +1570,9 @@ available when cygserver is running.</pa
 what works on Windows:  Windows only supports user block quotas on NTFS, no
 group quotas, no inode quotas, no time constraints.</para>
 
+<para><function>qsort_r</function> is available in both BSD and GNU flavors,
+depending on whether _BSD_SOURCE or _GNU_SOURCE is defined when compiling.</para>
+
 </sect1>
 
 </chapter>
Index: cygwin/common.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/common.din,v
retrieving revision 1.13
diff -u -p -r1.13 common.din
--- cygwin/common.din	29 Oct 2014 09:56:18 -0000	1.13
+++ cygwin/common.din	5 Dec 2014 01:22:26 -0000
@@ -41,6 +41,7 @@ __assert_func NOSIGFE
 __assertfail NOSIGFE
 __b64_ntop NOSIGFE
 __b64_pton NOSIGFE
+__bsd_qsort_r NOSIGFE
 __cxa_atexit = cygwin__cxa_atexit SIGFE
 __cxa_finalize SIGFE
 __dn_comp SIGFE
@@ -920,6 +921,7 @@ putwc SIGFE
 putwchar SIGFE
 pwrite SIGFE
 qsort NOSIGFE
+qsort_r NOSIGFE
 quotactl SIGFE
 raise SIGFE
 rand NOSIGFE
Index: cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.413
diff -u -p -r1.413 version.h
--- cygwin/include/cygwin/version.h	13 Nov 2014 13:10:25 -0000	1.413
+++ cygwin/include/cygwin/version.h	5 Dec 2014 01:22:27 -0000
@@ -457,12 +457,13 @@ details. */
       279: Export stime.
       280: Static atexit in libcygwin.a, CW_FIXED_ATEXIT.
       281: Add CW_GETNSS_PWD_SRC, CW_GETNSS_GRP_SRC.
+      282: Export __bsd_qsort_r, qsort_r.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 281
+#define CYGWIN_VERSION_API_MINOR 282
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------070807090801010704010100--
