Return-Path: <cygwin-patches-return-6621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9350 invoked by alias); 14 Sep 2009 02:37:09 -0000
Received: (qmail 9056 invoked by uid 22791); 14 Sep 2009 02:37:08 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f219.google.com (HELO mail-fx0-f219.google.com) (209.85.220.219)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Sep 2009 02:37:03 +0000
Received: by fxm19 with SMTP id 19so1993089fxm.2         for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2009 19:37:00 -0700 (PDT)
Received: by 10.204.19.141 with SMTP id a13mr4656862bkb.11.1252895820664;         Sun, 13 Sep 2009 19:37:00 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 19sm598018fkr.43.2009.09.13.19.36.59         (version=SSLv3 cipher=RC4-MD5);         Sun, 13 Sep 2009 19:37:00 -0700 (PDT)
Message-ID: <4AADAF9C.2000601@gmail.com>
Date: Mon, 14 Sep 2009 02:37:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: newlib@sourceware.org
CC: cygwin-patches@cygwin.com
Subject: [PATCH] Define _TIMEVAL_DEFINED consistently whenever defining timeval.
Content-Type: multipart/mixed;  boundary="------------040704000500050801040507"
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
X-SW-Source: 2009-q3/txt/msg00075.txt.bz2

This is a multi-part message in MIME format.
--------------040704000500050801040507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1006


    Hi all,

  Granted that the whole _TIMEVAL_DEFINED/__USE_W32_SOCKETS thing is basically
an ugly and undesirable hack, but until we have a plan to fix the whole
tcl/tk/expect/dejagnu/gdb/insight combo (as well as gnat), I figure we have to
live with it, and so it should at least be correct consistent and complete.

  There is still one place that struct timeval is defined but _TIMEVAL_DEFINED
is not, causing order-of-include problems.  The attached patch is the most
minimal adjustment that could be made to the whole thing to make it
at-least-not-any-worse-than-it-already-is, and solves problems compiling GNAT
from upstream sources.

newlib/ChangeLog:

	* libc/include/sys/time.h (_TIMEVAL_DEFINED): Define when
	defining struct timeval.

  Sanity-checked by building winsup on i686-pc-cygwin, but I think it's fairly
clear by inspection that this could only ever prevent a redefinition error,
and it's exactly how the MinGW headers solve the same problem.  Is this OK?

    cheers,
      DaveK

--------------040704000500050801040507
Content-Type: text/x-c;
 name="timeval-defined-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timeval-defined-patch.diff"
Content-length: 493

Index: newlib/libc/include/sys/time.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/sys/time.h,v
retrieving revision 1.13
diff -p -u -r1.13 time.h
--- newlib/libc/include/sys/time.h	11 Dec 2008 22:48:38 -0000	1.13
+++ newlib/libc/include/sys/time.h	14 Sep 2009 01:21:20 -0000
@@ -13,6 +13,7 @@ extern "C" {
 #endif
 
 #ifndef _WINSOCK_H
+#define _TIMEVAL_DEFINED
 struct timeval {
   time_t      tv_sec;
   suseconds_t tv_usec;

--------------040704000500050801040507--
