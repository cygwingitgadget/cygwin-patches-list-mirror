Return-Path: <cygwin-patches-return-5808-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22931 invoked by alias); 22 Mar 2006 16:30:25 -0000
Received: (qmail 22920 invoked by uid 22791); 22 Mar 2006 16:30:25 -0000
X-Spam-Check-By: sourceware.org
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 22 Mar 2006 16:30:23 +0000
Received: from root by ciao.gmane.org with local (Exim 4.43) 	id 1FM6Dz-0005lt-A9 	for cygwin-patches@cygwin.com; Wed, 22 Mar 2006 17:30:19 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])         by main.gmane.org with esmtp (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Wed, 22 Mar 2006 17:30:19 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))         id 1AlnuQ-0007hv-00         for <cygwin-patches@cygwin.com>; Wed, 22 Mar 2006 17:30:19 +0100
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  fcntl debug
Date: Wed, 22 Mar 2006 16:30:00 -0000
Message-ID:  <loom.20060322T160630-568@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00117.txt.bz2

In an attempt to figure out why my third newlib freopen(NULL) patch
still failed (and hence leading to today's fourth patch - man, I have
really fat-fingered my efforts to get freopen(NULL) usable), I noticed
that an strace of fcntl(F_GETFL) was not as helpful as I would like.

2006-03-22  Eric Blake  <ebb9@byu.net>

	* fhandler.cc (fcntl): Print flags in hex.

Index: winsup/cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.250
diff -u -r1.250 fhandler.cc
--- winsup/cygwin/fhandler.cc	22 Feb 2006 16:40:42 -0000	1.250
+++ winsup/cygwin/fhandler.cc	22 Mar 2006 15:05:08 -0000
@@ -1,7 +1,7 @@
 /* fhandler.cc.  See console.cc for fhandler_console functions.
 
    Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
-   2005 Red Hat, Inc.
+   2005, 2006 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -1304,7 +1304,7 @@
       break;
     case F_GETFL:
       res = get_flags ();
-      debug_printf ("GETFL: %d", res);
+      debug_printf ("GETFL: %p", res);
       break;
     case F_SETFL:
       {

