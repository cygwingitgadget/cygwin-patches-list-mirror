Return-Path: <cygwin-patches-return-6466-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12883 invoked by alias); 3 Apr 2009 13:08:52 -0000
Received: (qmail 12870 invoked by uid 22791); 3 Apr 2009 13:08:51 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.146)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 13:08:45 +0000
Received: by ey-out-1920.google.com with SMTP id 5so191711eyb.20         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 06:08:42 -0700 (PDT)
Received: by 10.216.20.74 with SMTP id o52mr398008weo.147.1238764122456;         Fri, 03 Apr 2009 06:08:42 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id t2sm4674784gve.2.2009.04.03.06.08.41         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 06:08:41 -0700 (PDT)
Message-ID: <49D60CC2.8090205@gmail.com>
Date: Fri, 03 Apr 2009 13:08:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Add uchar.h
Content-Type: multipart/mixed;  boundary="------------040906020902030906040604"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00008.txt.bz2

This is a multi-part message in MIME format.
--------------040906020902030906040604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 390

Dave Korn wrote:
>
>  I've got a bit of a load on right now what with gcc back in stage1.

  However, as part of dealing with that I did try throwing together one of
these.  I wrote this from scratch based solely on reading n1040; it's
skeletal, but at least provides the two new unicode typedefs.  Want it?

winsup/cygwin/ChangeLog

	* include/uchar.h:  New file.

    cheers,
      DaveK

--------------040906020902030906040604
Content-Type: text/x-c;
 name="add-uchar-h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add-uchar-h.diff"
Content-length: 1360

Index: winsup/cygwin/include/uchar.h
===================================================================
RCS file: winsup/cygwin/include/uchar.h
diff -N winsup/cygwin/include/uchar.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ winsup/cygwin/include/uchar.h	3 Apr 2009 13:03:52 -0000
@@ -0,0 +1,37 @@
+/* uchar.h - unicode character types
+
+   Copyright 2009 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _UCHAR_H
+#define _UCHAR_H
+
+/* Exact-width character types */
+
+typedef unsigned short char16_t;    /* Must match uint_least16_t */
+typedef unsigned long  char32_t;    /* Must match uint_least32_t */
+
+
+/* We do not define an encoding yet. */
+
+/* #undef __STDC_UTF_16__ */
+/* #undef __STDC_UTF_32__ */
+
+/* We do not provide the standard library functions yet. */
+
+/* size_t mbrtoc16(char16_t * restrict pc16, const char * restrict s,
+		size_t n, mbstate_t * restrict ps); */
+
+/* size_t c16rtomb(char * restrict s, char16_t c16, mbstate_t * restrict ps); */
+
+/* size_t mbrtoc32(char32_t * restrict pc32, const char * restrict s, size_t n,
+		mbstate_t * restrict ps); */
+
+/* size_t c32rtomb(char * restrict s, char32_t c32, mbstate_t * restrict ps); */
+
+#endif /* _UCHAR_H */

--------------040906020902030906040604--
