Return-Path: <cygwin-patches-return-7262-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28032 invoked by alias); 4 Apr 2011 12:41:33 -0000
Received: (qmail 28020 invoked by uid 22791); 4 Apr 2011 12:41:32 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 12:41:14 +0000
Received: by yxe42 with SMTP id 42so2662099yxe.2        for <cygwin-patches@cygwin.com>; Mon, 04 Apr 2011 05:41:13 -0700 (PDT)
Received: by 10.150.189.4 with SMTP id m4mr6533881ybf.344.1301920873430;        Mon, 04 Apr 2011 05:41:13 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id u35sm2130500yba.27.2011.04.04.05.41.12        (version=SSLv3 cipher=OTHER);        Mon, 04 Apr 2011 05:41:12 -0700 (PDT)
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110404122647.GQ3669@calimero.vinschen.de>
References: <1301873845.3104.26.camel@YAAKOV04>	 <20110403235557.GA15529@ednor.casa.cgf.cx>	 <1301875911.3104.39.camel@YAAKOV04>	 <20110404051942.GA30475@ednor.casa.cgf.cx>	 <20110404105430.GN3669@calimero.vinschen.de>	 <1301916432.3104.76.camel@YAAKOV04>	 <20110404122647.GQ3669@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-mEFM6mPO/wTnvPCL0Jnv"
Date: Mon, 04 Apr 2011 12:41:00 -0000
Message-ID: <1301920876.3104.78.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00028.txt.bz2


--=-mEFM6mPO/wTnvPCL0Jnv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 314

On Mon, 2011-04-04 at 14:26 +0200, Corinna Vinschen wrote:
> On Apr  4 06:27, Yaakov (Cygwin/X) wrote:
> > Alright, do I still bump CYGWIN_VERSION_API_MINOR for only inline
> > functions?
> 
> No, that's not necessary.
> 
> > What about posix.sgml?
> 
> You can skip it as well.

Revised patch attached.


Yaakov


--=-mEFM6mPO/wTnvPCL0Jnv
Content-Disposition: attachment; filename="sysmacros-inline.patch"
Content-Type: text/x-patch; name="sysmacros-inline.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2298

2011-04-04  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/cygwin/types.h: Move #include <sys/sysmacros.h> to
	end of header so the latter get the dev_t typedef.
	* include/sys/sysmacros.h (gnu_dev_major, gnu_dev_minor,
	gnu_dev_makedev): Prototype and define as inline functions.
	(major, minor, makedev): Redefine in terms of gnu_dev_*.

Index: include/cygwin/types.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/types.h,v
retrieving revision 1.33
diff -u -r1.33 types.h
--- include/cygwin/types.h	29 Mar 2011 10:32:40 -0000	1.33
+++ include/cygwin/types.h	3 Apr 2011 20:43:20 -0000
@@ -17,7 +17,6 @@
 #ifndef _CYGWIN_TYPES_H
 #define _CYGWIN_TYPES_H
 
-#include <sys/sysmacros.h>
 #include <stdint.h>
 #include <endian.h>
 
@@ -220,6 +219,8 @@
 #endif /* __INSIDE_CYGWIN__ */
 #endif /* _CYGWIN_TYPES_H */
 
+#include <sys/sysmacros.h>
+
 #ifdef __cplusplus
 }
 #endif
Index: include/sys/sysmacros.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/sysmacros.h,v
retrieving revision 1.4
diff -u -r1.4 sysmacros.h
--- include/sys/sysmacros.h	26 Feb 2010 09:36:21 -0000	1.4
+++ include/sys/sysmacros.h	3 Apr 2011 20:43:20 -0000
@@ -1,6 +1,6 @@
 /* sys/sysmacros.h
 
-   Copyright 1998, 2001, 2010 Red Hat, Inc.
+   Copyright 1998, 2001, 2010, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -11,8 +11,30 @@
 #ifndef _SYS_SYSMACROS_H
 #define _SYS_SYSMACROS_H
 
-#define major(dev) ((int)(((dev) >> 16) & 0xffff))
-#define minor(dev) ((int)((dev) & 0xffff))
-#define makedev(major, minor) (((major) << 16) | ((minor) & 0xffff))
+_ELIDABLE_INLINE int gnu_dev_major(dev_t);
+_ELIDABLE_INLINE int gnu_dev_minor(dev_t);
+_ELIDABLE_INLINE dev_t gnu_dev_makedev(int, int);
+
+_ELIDABLE_INLINE int
+gnu_dev_major(dev_t dev)
+{
+	return (int)(((dev) >> 16) & 0xffff);
+}
+
+_ELIDABLE_INLINE int
+gnu_dev_minor(dev_t dev)
+{
+	return (int)((dev) & 0xffff);
+}
+
+_ELIDABLE_INLINE dev_t
+gnu_dev_makedev(int maj, int min)
+{
+	return (((maj) << 16) | ((min) & 0xffff));
+}
+
+#define major(dev) gnu_dev_major(dev)
+#define minor(dev) gnu_dev_minor(dev)
+#define makedev(maj, min) gnu_dev_makedev(maj, min)
 
 #endif /* _SYS_SYSMACROS_H */

--=-mEFM6mPO/wTnvPCL0Jnv--
