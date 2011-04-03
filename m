Return-Path: <cygwin-patches-return-7242-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8111 invoked by alias); 3 Apr 2011 21:54:41 -0000
Received: (qmail 8100 invoked by uid 22791); 3 Apr 2011 21:54:40 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 03 Apr 2011 21:54:36 +0000
Received: by gxk22 with SMTP id 22so2460118gxk.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 14:54:35 -0700 (PDT)
Received: by 10.150.169.20 with SMTP id r20mr6153496ybe.311.1301867675475;        Sun, 03 Apr 2011 14:54:35 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id u35sm1880144yba.12.2011.04.03.14.54.34        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 14:54:34 -0700 (PDT)
Subject: [PATCH] reorder major-0 devices (was Re: [PATCH] implement /proc/sysvipc/*)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110401213330.GI3669@calimero.vinschen.de>
References: <1301650256.3108.4.camel@YAAKOV04>	 <20110401100556.GB24008@calimero.vinschen.de>	 <1301687867.184.10.camel@YAAKOV04>	 <20110401213330.GI3669@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-xZCdToLye085E7uLpt9+"
Date: Sun, 03 Apr 2011 21:54:00 -0000
Message-ID: <1301867677.3104.5.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00008.txt.bz2


--=-xZCdToLye085E7uLpt9+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1099

On Fri, 2011-04-01 at 23:33 +0200, Corinna Vinschen wrote:
> On Apr  1 14:57, Yaakov (Cygwin/X) wrote:
> > For the sake of clarity, I would reorder it a bit further to
> > make FH_PROC and friends to one side of major-0 and everything else to
> > the other side:
> > 
> >   /* begin /proc directories */
> >   FH_PROC    = FHDEV (0, 255),
> >   FH_REGISTRY= FHDEV (0, 254),
> >   FH_PROCNET = FHDEV (0, 253),
> >   FH_PROCESSFD = FHDEV (0, 252),
> >   FH_PROCSYS = FHDEV (0, 251),
> >   FH_PROCSYSVIPC = FHDEV (0,250),
> > 
> >   FH_PROC_MIN_MINOR = FHDEV (0,200),
> >   /* end /proc directories */
> > 
> >   FH_PIPE    = FHDEV (0, 199),
> >   FH_PIPER   = FHDEV (0, 198),
> >   FH_PIPEW   = FHDEV (0, 197),
> >   FH_FIFO    = FHDEV (0, 196),
> >   FH_PROCESS = FHDEV (0, 195),
> >   FH_FS      = FHDEV (0, 194),	/* filesystem based device */
> >   FH_NETDRIVE= FHDEV (0, 193),
> >   FH_DEV     = FHDEV (0, 192),
> > 
> > As either way this should be a separate changeset IMHO, I have committed
> > my patch as is and will follow this up on Sunday.
> 
> Sounds ok to me.

Patch attached.


Yaakov


--=-xZCdToLye085E7uLpt9+
Content-Disposition: attachment; filename="device-major-0-reorder.patch"
Content-Type: text/x-patch; name="device-major-0-reorder.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2598

2011-03-04  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
	    Corinna Vinschen  <corinna@vinschen.de>

	* devices.h (fh_devices): Define FH_PROC_MIN_MINOR.
	Reorder major-0 devices so that all /proc directories fall
	between FH_PROC and FH_PROC_MIN_MINOR.
	* path.h (isproc_dev): Redefine accordingly.

Index: devices.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/devices.h,v
retrieving revision 1.27
diff -u -r1.27 devices.h
--- devices.h	1 Apr 2011 19:48:19 -0000	1.27
+++ devices.h	3 Apr 2011 21:46:44 -0000
@@ -1,6 +1,6 @@
 /* devices.h
 
-   Copyright 2002, 2003, 2004, 2005, 2007, 2009, 2010 Red Hat, Inc.
+   Copyright 2002, 2003, 2004, 2005, 2007, 2009, 2010, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -39,22 +39,25 @@
   FH_WINDOWS = FHDEV (13, 255),
   FH_CLIPBOARD=FHDEV (13, 254),
 
-  FH_PIPE    = FHDEV (0, 255),
-  FH_PIPER   = FHDEV (0, 254),
-  FH_PIPEW   = FHDEV (0, 253),
-  FH_FIFO    = FHDEV (0, 252),
-  FH_PROC    = FHDEV (0, 250),
-  FH_REGISTRY= FHDEV (0, 249),
-  FH_PROCESS = FHDEV (0, 248),
-
-  FH_FS      = FHDEV (0, 247),	/* filesystem based device */
-
-  FH_NETDRIVE= FHDEV (0, 246),
-  FH_DEV     = FHDEV (0, 245),
-  FH_PROCNET = FHDEV (0, 244),
-  FH_PROCESSFD = FHDEV (0, 243),
-  FH_PROCSYS = FHDEV (0, 242),
-  FH_PROCSYSVIPC = FHDEV (0,241),
+  /* begin /proc directories */
+  FH_PROC    = FHDEV (0, 255),
+  FH_REGISTRY= FHDEV (0, 254),
+  FH_PROCNET = FHDEV (0, 253),
+  FH_PROCESSFD = FHDEV (0, 252),
+  FH_PROCSYS = FHDEV (0, 251),
+  FH_PROCSYSVIPC = FHDEV (0,250),
+
+  FH_PROC_MIN_MINOR = FHDEV (0,200),
+  /* end /proc directories */
+
+  FH_PIPE    = FHDEV (0, 199),
+  FH_PIPER   = FHDEV (0, 198),
+  FH_PIPEW   = FHDEV (0, 197),
+  FH_FIFO    = FHDEV (0, 196),
+  FH_PROCESS = FHDEV (0, 195),
+  FH_FS      = FHDEV (0, 194),  /* filesystem based device */
+  FH_NETDRIVE= FHDEV (0, 193),
+  FH_DEV     = FHDEV (0, 192),
 
   DEV_FLOPPY_MAJOR = 2,
   FH_FLOPPY  = FHDEV (DEV_FLOPPY_MAJOR, 0),
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.155
diff -u -r1.155 path.h
--- path.h	1 Apr 2011 19:48:19 -0000	1.155
+++ path.h	3 Apr 2011 21:46:44 -0000
@@ -18,8 +18,7 @@
 #include <fcntl.h>
 
 #define isproc_dev(devn) \
-  (devn == FH_PROC || devn == FH_REGISTRY || devn == FH_PROCESS || \
-   devn == FH_PROCNET || devn == FH_PROCSYS || devn == FH_PROCSYSVIPC)
+  (devn >= FH_PROC_MIN_MINOR && devn <= FH_PROC)
 
 #define isprocsys_dev(devn) (devn == FH_PROCSYS)
 

--=-xZCdToLye085E7uLpt9+--
