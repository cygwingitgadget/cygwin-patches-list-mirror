Return-Path: <cygwin-patches-return-7056-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13362 invoked by alias); 8 Aug 2010 05:49:24 -0000
Received: (qmail 13351 invoked by uid 22791); 8 Aug 2010 05:49:23 -0000
X-SWARE-Spam-Status: No, hits=-50.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-pw0-f43.google.com (HELO mail-pw0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 08 Aug 2010 05:49:18 +0000
Received: by pwi5 with SMTP id 5so2087157pwi.2        for <cygwin-patches@cygwin.com>; Sat, 07 Aug 2010 22:49:17 -0700 (PDT)
Received: by 10.114.66.5 with SMTP id o5mr16493198waa.219.1281246556782;        Sat, 07 Aug 2010 22:49:16 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id q6sm7087527waj.10.2010.08.07.22.49.15        (version=SSLv3 cipher=RC4-MD5);        Sat, 07 Aug 2010 22:49:16 -0700 (PDT)
Subject: [PATCH] define RTLD_LOCAL
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-PO+h9KVefBHitorv07Rh"
Date: Sun, 08 Aug 2010 05:49:00 -0000
Message-ID: <1281246553.1344.24.camel@YAAKOV04>
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
X-SW-Source: 2010-q3/txt/msg00016.txt.bz2


--=-PO+h9KVefBHitorv07Rh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 919

POSIX requires RTLD_LOCAL to be defined in <dlfcn.h>[1].  While our
dlopen() does nothing with its second argument, portable software can
rightfully expect the definition to exist alongside the other RTLD_*
macros.

So why 0?  POSIX states wrt dlopen()[2]:

> If neither RTLD_GLOBAL nor RTLD_LOCAL are specified, then the default
> behavior is unspecified.

On Linux, RTLD_LOCAL is the default behaviour[3], and hence is defined
as 0[4], therefore I have done the same here.

Patch attached.  Since this doesn't actually do anything, I wasn't sure
if I should bump CYGWIN_VERSION_API_MINOR for this or not; I can
certainly do so before committing if desired.


Yaakov

[1] http://www.opengroup.org/onlinepubs/9699919799/basedefs/dlfcn.h.html
[2] http://www.opengroup.org/onlinepubs/9699919799/functions/dlopen.html
[3] http://linux.die.net/man/3/dlopen
[4] http://sourceware.org/git/?p=glibc.git;a=blob;f=bits/dlfcn.h


--=-PO+h9KVefBHitorv07Rh
Content-Disposition: attachment; filename="winsup-RTLD_LOCAL.patch"
Content-Type: text/x-patch; name="winsup-RTLD_LOCAL.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 800

2010-08-06  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/dlfcn.h (RTLD_LOCAL): Define.

Index: include/dlfcn.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/dlfcn.h,v
retrieving revision 1.3
diff -u -r1.3 dlfcn.h
--- include/dlfcn.h	14 Sep 2004 08:29:12 -0000	1.3
+++ include/dlfcn.h	7 Aug 2010 01:22:37 -0000
@@ -31,6 +31,7 @@
 #define RTLD_DEFAULT    NULL
 
 /* valid values for mode argument to dlopen */
+#define RTLD_LOCAL	0	/* symbols in this dlopen'ed obj are not visible to other dlopen'ed objs */
 #define RTLD_LAZY	1	/* lazy function call binding */
 #define RTLD_NOW	2	/* immediate function call binding */
 #define RTLD_GLOBAL	4	/* symbols in this dlopen'ed obj are visible to other dlopen'ed objs */

--=-PO+h9KVefBHitorv07Rh--
