Return-Path: <cygwin-patches-return-6343-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25713 invoked by alias); 1 Aug 2008 13:54:09 -0000
Received: (qmail 25664 invoked by uid 22791); 1 Aug 2008 13:54:08 -0000
X-Spam-Check-By: sourceware.org
Received: from smarthost02.mail.zen.net.uk (HELO smarthost02.mail.zen.net.uk) (212.23.3.141)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 01 Aug 2008 13:53:48 +0000
Received: from [62.3.107.196] (helo=straightrunning.com) 	by smarthost02.mail.zen.net.uk with esmtp (Exim 4.63) 	(envelope-from <colin.harrison@virgin.net>) 	id 1KOv4k-0001Fg-8C 	for cygwin-patches@cygwin.com; Fri, 01 Aug 2008 13:53:46 +0000
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <cygwin-patches@cygwin.com>
Subject: Patch for pformat.c in winsup/mingw CVS
Date: Fri, 01 Aug 2008 13:54:00 -0000
Message-ID:<200808011353.m71DrjsI011717@StraightRunning.com>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-Smarthost02-IP: [62.3.107.196]
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00006.txt.bz2

Hi,

The latest CVS winsup/mingw runtime caused a crash, for me, in strlen() when
testing previously 'good' code built with it in the toolchain.
I found this patch fixed the problem for me, so it may be of help to
others...

--- ./mingw/mingwex/stdio/save_pformat.c        2008-07-29
00:24:20.000000000 +0100
+++ ./mingw/mingwex/stdio/pformat.c     2008-07-31 19:30:29.000000000 +0100
@@ -358,7 +358,7 @@
    * This is implemented as a trivial call to `__pformat_putchars()',
    * passing the length of the input string as the character count.
    */
-  __pformat_putchars( s, strlen( s ), stream );
+  __pformat_putchars( s, s ? strlen( s ) : 0, stream );
 }

 static
@@ -436,7 +436,7 @@
    * This is implemented as a trivial call to `__pformat_wputchars()',
    * passing the length of the input string as the character count.
    */
-  __pformat_wputchars( s, wcslen( s ), stream );
+  __pformat_wputchars( s, s ? wcslen( s ) : 0, stream );
 }

 static __inline__

Thanks
Colin Harrison
