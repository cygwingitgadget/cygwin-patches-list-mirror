Return-Path: <cygwin-patches-return-7245-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6610 invoked by alias); 3 Apr 2011 23:56:05 -0000
Received: (qmail 6600 invoked by uid 22791); 3 Apr 2011 23:56:04 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm3-vm0.bullet.mail.bf1.yahoo.com (HELO nm3-vm0.bullet.mail.bf1.yahoo.com) (98.139.212.154)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 03 Apr 2011 23:55:59 +0000
Received: from [98.139.212.146] by nm3.bullet.mail.bf1.yahoo.com with NNFMP; 03 Apr 2011 23:55:58 -0000
Received: from [98.139.213.12] by tm3.bullet.mail.bf1.yahoo.com with NNFMP; 03 Apr 2011 23:55:58 -0000
Received: from [127.0.0.1] by smtp112.mail.bf1.yahoo.com with NNFMP; 03 Apr 2011 23:55:58 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp112.mail.bf1.yahoo.com with SMTP; 03 Apr 2011 16:55:58 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id DF0F9428013	for <cygwin-patches@cygwin.com>; Sun,  3 Apr 2011 19:55:57 -0400 (EDT)
Date: Sun, 03 Apr 2011 23:56:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
Message-ID: <20110403235557.GA15529@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301873845.3104.26.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301873845.3104.26.camel@YAAKOV04>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00011.txt.bz2

On Sun, Apr 03, 2011 at 06:37:25PM -0500, Yaakov (Cygwin/X) wrote:
>When building Qt Creator, I encountered a compile error because its code
>uses 'major' and 'minor' as variable names.  Looking at the current
><sys/sysmacros.h>, which is pulled in automatically by <sys/types.h>,
>makes it obvious why that doesn't work.
>
>Since this code obviously compiles on Linux, I investigated further,
>starting with:
>
>http://www.kernel.org/doc/man-pages/online/pages/man3/minor.3.html
>
>and running some tests on a Linux system.  In short, with glibc:
>
>1) these are indeed macros, but;
>2) the [name] macros point to gnu_dev_[name] functions;
>3) the latter are defined as inline functions in <sys/sysmacros.h>;
>4) the inline functions are used only if optimization is on.
>
>Based on this, I refactored our existing macros into both inline and
>normal functions.  An additional benefit is type-checking in the
>arguments and return types of these functions.
>
>Patches for winsup/cygwin and winsup/doc attached.
>
>
>Yaakov
>

>2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
>
>	* include/cygwin/types.h: Move #include <sys/sysmacros.h> to
>	end of header so the latter get the dev_t typedef.
>	* include/sys/sysmacros.h (gnu_dev_major, gnu_dev_minor,
>	gnu_dev_makedev): Prototype and define as inline functions.
>	(major, minor, makedev): Redefine in terms of gnu_dev_*.
>	* miscfuncs.cc (gnu_dev_major, gnu_dev_minor, gnu_dev_makedev):
>	New functions.
>	* cygwin.din (gnu_dev_major, gnu_dev_minor, gnu_dev_makedev): Export.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>	* posix.sgml (std-gnu): Add gnu_dev_major, gnu_dev_minor, gnu_dev_makedev.
>
>Index: cygwin.din
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
>retrieving revision 1.234
>diff -u -r1.234 cygwin.din
>--- cygwin.din	29 Mar 2011 10:32:40 -0000	1.234
>+++ cygwin.din	3 Apr 2011 20:43:11 -0000
>@@ -802,6 +802,9 @@
> _gmtime = gmtime SIGFE
> gmtime_r SIGFE
> _gmtime_r = gmtime_r SIGFE
>+gnu_dev_major NOSIGFE
>+gnu_dev_makedev NOSIGFE
>+gnu_dev_minor NOSIGFE
> grantpt NOSIGFE
> hcreate SIGFE
> hcreate_r SIGFE
>Index: miscfuncs.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
>retrieving revision 1.58
>diff -u -r1.58 miscfuncs.cc
>--- miscfuncs.cc	12 Mar 2010 23:13:47 -0000	1.58
>+++ miscfuncs.cc	3 Apr 2011 20:43:20 -0000
>@@ -1,7 +1,7 @@
> /* miscfuncs.cc: misc funcs that don't belong anywhere else
> 
>    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
>-   2005, 2006, 2007, 2008 Red Hat, Inc.
>+   2005, 2006, 2007, 2008, 2010, 2011 Red Hat, Inc.
> 
> This file is part of Cygwin.
> 
>@@ -9,6 +9,7 @@
> Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> details. */
> 
>+#define __INSIDE_CYGWIN_GNU_DEV__

I'd prefer a more descriptive name like "__DONT_DEFINE_INLINE_GNU_DEV" but,
then again, why do these have to be exported?  Why can't they just be always
inlined?

cgf
