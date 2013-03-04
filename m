Return-Path: <cygwin-patches-return-7842-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2529 invoked by alias); 4 Mar 2013 11:40:07 -0000
Received: (qmail 2512 invoked by uid 22791); 4 Mar 2013 11:40:06 -0000
X-SWARE-Spam-Status: No, hits=-5.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_GC
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f175.google.com (HELO mail-ia0-f175.google.com) (209.85.210.175)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Mar 2013 11:39:57 +0000
Received: by mail-ia0-f175.google.com with SMTP id k38so2515150iah.34        for <cygwin-patches@cygwin.com>; Mon, 04 Mar 2013 03:39:57 -0800 (PST)
X-Received: by 10.50.190.164 with SMTP id gr4mr2092938igc.19.1362397196794;        Mon, 04 Mar 2013 03:39:56 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id wx2sm10370604igb.4.2013.03.04.03.39.55        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Mon, 04 Mar 2013 03:39:56 -0800 (PST)
Date: Mon, 04 Mar 2013 11:40:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130304053936.49484e71@YAAKOV04>
In-Reply-To: <20130304105134.GF5468@calimero.vinschen.de>
References: <20130304021224.381b9ec4@YAAKOV04>	<20130304105134.GF5468@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/KqIA+itu6tJtxosPXgit8Oa"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00053.txt.bz2


--MP_/KqIA+itu6tJtxosPXgit8Oa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 477

On Mon, 4 Mar 2013 11:51:34 +0100, Corinna Vinschen wrote:
> That looks good, thanks for catching this problem!  Please apply the
> Cygwin changes.  I'll rebuild new base packages including the gcc
> patches soon.

BTW, at some point the attached patch will also need to be added for
4.8.  The libgcj ABI version changes with every GCC major.minor, and
this define seems to always be missed; a comment to this effect in
libjava/libtool-version probably wouldn't hurt.


Yaakov

--MP_/KqIA+itu6tJtxosPXgit8Oa
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=gcc48-libgcj-version.patch
Content-length: 1218

--- a/gcc/config/i386/cygwin.h	2013-01-10 14:38:27.000000000 -0600
+++ b/gcc/config/i386/cygwin.h	2013-03-04 00:18:04.989538700 -0600
@@ -137,5 +137,5 @@
 #define LIBGCC_SONAME "cyggcc_s" LIBGCC_EH_EXTN "-1.dll"
 
 /* We should find a way to not have to update this manually.  */
-#define LIBGCJ_SONAME "cyggcj" /*LIBGCC_EH_EXTN*/ "-13.dll"
+#define LIBGCJ_SONAME "cyggcj" /*LIBGCC_EH_EXTN*/ "-14.dll"
 
--- a/gcc/config/i386/cygwin-w64.h	2013-03-03 23:58:36.941826800 -0600
+++ b/gcc/config/i386/cygwin-w64.h	2013-03-04 00:18:00.309532200 -0600
@@ -155,4 +155,4 @@
 #define LIBGCC_SONAME "cyggcc_s" LIBGCC_EH_EXTN "-1.dll"
 
 /* We should find a way to not have to update this manually.  */
-#define LIBGCJ_SONAME "cyggcj" /*LIBGCC_EH_EXTN*/ "-13.dll"
+#define LIBGCJ_SONAME "cyggcj" /*LIBGCC_EH_EXTN*/ "-14.dll"
--- a/gcc/config/i386/mingw32.h	2013-01-10 14:38:27.000000000 -0600
+++ b/gcc/config/i386/mingw32.h	2013-03-04 05:35:13.791448500 -0600
@@ -245,4 +245,4 @@
 #define LIBGCC_SONAME "libgcc_s" LIBGCC_EH_EXTN "-1.dll"
 
 /* We should find a way to not have to update this manually.  */
-#define LIBGCJ_SONAME "libgcj" /*LIBGCC_EH_EXTN*/ "-13.dll"
+#define LIBGCJ_SONAME "libgcj" /*LIBGCC_EH_EXTN*/ "-14.dll"

--MP_/KqIA+itu6tJtxosPXgit8Oa--
