Return-Path: <cygwin-patches-return-7591-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21503 invoked by alias); 24 Jan 2012 05:53:38 -0000
Received: (qmail 21492 invoked by uid 22791); 24 Jan 2012 05:53:36 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-qw0-f50.google.com (HELO mail-qw0-f50.google.com) (209.85.216.50)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Jan 2012 05:53:23 +0000
Received: by qabg27 with SMTP id g27so2179515qab.2        for <cygwin-patches@cygwin.com>; Mon, 23 Jan 2012 21:53:22 -0800 (PST)
Received: by 10.224.100.71 with SMTP id x7mr12947138qan.33.1327384402798;        Mon, 23 Jan 2012 21:53:22 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id g17sm31384039qad.3.2012.01.23.21.53.21        (version=SSLv3 cipher=OTHER);        Mon, 23 Jan 2012 21:53:22 -0800 (PST)
Message-ID: <1327384403.5392.7.camel@YAAKOV04>
Subject: [PATCH] ldd: support .oct and .so modules
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Tue, 24 Jan 2012 05:53:00 -0000
Content-Type: multipart/mixed; boundary="=-4pR/7K9GGtvOsYQBOoYD"
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
X-SW-Source: 2012-q1/txt/msg00014.txt.bz2


--=-4pR/7K9GGtvOsYQBOoYD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 292

Octave modules use the .oct extension, and several programs use .so for
modules even on Cygwin (e.g. Apache2, Mesa, OpenSSL, Ruby).  Currently,
running ldd(1) on any of these returns ENOEXEC.

The attached patch fixes ldd to treat these as DLLs and show their
runtime dependencies.


Yaakov


--=-4pR/7K9GGtvOsYQBOoYD
Content-Disposition: attachment; filename="utils-ldd-so-oct.patch"
Content-Type: text/x-patch; name="utils-ldd-so-oct.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 950

2012-01-??  Yaakov Selkowitz  <yselkowitz@...>

	* ldd.cc (start_process): Handle .oct and .so as DLLs.

Index: ldd.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/ldd.cc,v
retrieving revision 1.13
diff -u -p -r1.13 ldd.cc
--- ldd.cc	17 Dec 2011 23:39:47 -0000	1.13
+++ ldd.cc	24 Jan 2012 05:43:41 -0000
@@ -189,7 +189,11 @@ start_process (const wchar_t *fn, bool& 
   PROCESS_INFORMATION pi;
   si.cb = sizeof (si);
   wchar_t *cmd;
-  if (wcslen (fn) < 4 || wcscasecmp (wcschr (fn, L'\0') - 4, L".dll") != 0)
+  /* OCaml natdynlink plugins (.cmxs) cannot be handled by ldd because they
+     can only be loaded by flexdll_dlopen() */
+  if (wcslen (fn) < 4 || (wcscasecmp (wcschr (fn, L'\0') - 4, L".dll") != 0
+       && wcscasecmp (wcschr (fn, L'\0') - 4, L".oct") != 0
+       && wcscasecmp (wcschr (fn, L'\0') - 3, L".so") != 0))
     {
       cmd = wcsdup (fn);
       isdll = false;

--=-4pR/7K9GGtvOsYQBOoYD--
