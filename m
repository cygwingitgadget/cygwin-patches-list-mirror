Return-Path: <cygwin-patches-return-7589-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3355 invoked by alias); 13 Jan 2012 09:26:16 -0000
Received: (qmail 3341 invoked by uid 22791); 13 Jan 2012 09:26:15 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SARE_SUB_PCT_LETTER
X-Spam-Check-By: sourceware.org
Received: from mail-qw0-f43.google.com (HELO mail-qw0-f43.google.com) (209.85.216.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 13 Jan 2012 09:26:02 +0000
Received: by qadz30 with SMTP id z30so666034qad.2        for <cygwin-patches@cygwin.com>; Fri, 13 Jan 2012 01:26:02 -0800 (PST)
Received: by 10.224.187.20 with SMTP id cu20mr250974qab.43.1326446762064;        Fri, 13 Jan 2012 01:26:02 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id er7sm5584895qab.16.2012.01.13.01.26.00        (version=SSLv3 cipher=OTHER);        Fri, 13 Jan 2012 01:26:01 -0800 (PST)
Message-ID: <1326446761.6960.0.camel@YAAKOV04>
Subject: [PATCH] doc: document printf %m
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 13 Jan 2012 09:26:00 -0000
Content-Type: multipart/mixed; boundary="=-sqrXU4jpBzj+6mN48MvN"
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
X-SW-Source: 2012-q1/txt/msg00012.txt.bz2


--=-sqrXU4jpBzj+6mN48MvN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 76

New feature just added to newlib.  Patch for winsup/doc attached.


Yaakov


--=-sqrXU4jpBzj+6mN48MvN
Content-Disposition: attachment; filename="doc-printf-m.patch"
Content-Type: text/x-patch; name="doc-printf-m.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 881

2012-01-??  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document support for the %m
	%m conversion flag in printf functions.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.98
diff -u -p -r1.98 new-features.sgml
--- new-features.sgml	12 Jan 2012 23:42:11 -0000	1.98
+++ new-features.sgml	13 Jan 2012 09:20:00 -0000
@@ -105,6 +105,11 @@ dlopen now supports the Glibc-specific R
 </para></listitem>
 
 <listitem><para>
+The printf(3) and wprintf(3) families of functions now handle the %m
+conversion flag.
+</para></listitem>
+
+<listitem><para>
 Other new API: clock_settime, __fpurge, getgrouplist, get_current_dir_name,
 getpt, ppoll, psiginfo, psignal, ptsname_r, sys_siglist, pthread_setschedprio,
 pthread_sigqueue, sysinfo.

--=-sqrXU4jpBzj+6mN48MvN--
