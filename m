Return-Path: <cygwin-patches-return-6252-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11929 invoked by alias); 8 Mar 2008 01:39:31 -0000
Received: (qmail 11915 invoked by uid 22791); 8 Mar 2008 01:39:30 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 08 Mar 2008 01:39:14 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JXo1o-0007if-RB 	for cygwin-patches@cygwin.com; Sat, 08 Mar 2008 01:39:12 +0000
Message-ID: <47D1EE32.72610760@dessent.net>
Date: Sat, 08 Mar 2008 01:39:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [patch] handle_to_fn: null terminate
Content-Type: multipart/mixed;  boundary="------------8D6C49C63FE255DC5E21746B"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00026.txt.bz2

This is a multi-part message in MIME format.
--------------8D6C49C63FE255DC5E21746B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 263


I noticed in strace some lines like:

fhandler_base::close: closing
'/Device/NamedPipe/Win32Pipes.000008e0.00000002<several junk bytes>'
handle 0x740

This was caused by handle_to_fn simply forgetting to add a \0 when
converting, as in the attached patch.

Brian
--------------8D6C49C63FE255DC5E21746B
Content-Type: text/plain; charset=us-ascii;
 name="handle_to_fn_nul_terminate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handle_to_fn_nul_terminate.patch"
Content-length: 596

2008-03-07  Brian Dessent  <brian@dessent.net>

	* dtable.cc (handle_to_fn): Null-terminate posix_fn in the case
	of justslash = true.

Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.182
diff -u -p -r1.182 dtable.cc
--- dtable.cc	15 Feb 2008 17:53:10 -0000	1.182
+++ dtable.cc	8 Mar 2008 01:33:52 -0000
@@ -952,6 +952,7 @@ handle_to_fn (HANDLE h, char *posix_fn)
 	  *d = '/';
 	else
 	  *d = *s;
+      *d = 0;
     }
 
   debug_printf ("derived path '%s', posix '%s'", w32, posix_fn);

--------------8D6C49C63FE255DC5E21746B--
