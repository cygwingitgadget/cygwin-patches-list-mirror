Return-Path: <cygwin-patches-return-6345-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10091 invoked by alias); 5 Aug 2008 05:17:12 -0000
Received: (qmail 10080 invoked by uid 22791); 5 Aug 2008 05:17:11 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 05 Aug 2008 05:14:06 +0000
Received: from localhost.localdomain ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1KQErz-0007PD-VW 	for cygwin-patches@cygwin.com; Tue, 05 Aug 2008 05:14:04 +0000
Message-ID: <4897E0E8.AB669CAC@dessent.net>
Date: Tue, 05 Aug 2008 05:17:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] fix profiling
Content-Type: multipart/mixed;  boundary="------------BD6BD1EBBC686AA713942B12"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00008.txt.bz2

This is a multi-part message in MIME format.
--------------BD6BD1EBBC686AA713942B12
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1156


Long story short: some asm()s have missing volatile modifiers.

The mcount() profiling hook is implemented with a short wrapper around
the actual mcount function.  The wrapper's purpose is to get the pc of
the caller as well as the return value of the caller's frame, and pass
those on as arguments to the actual mcount function.  Because it's a
local static function the compiler inlines all this into one function. 
The problem is these asm()s aren't marked volatile and so the compiler
freely rearranges them and interleaves them with the prologue of the
inlined function.  Thus mcount gets some bogus value for the pc and
ignores the data because it's not in the valid range of .text.

Since this code is lifted from the BSDs I did check that this change was
made there as well, e.g.
<http://www.openbsd.org/cgi-bin/cvsweb/src/sys/arch/i386/include/profile.h?rev=1.10&content-type=text/x-cvsweb-markup>.

Unfortuantely there seems to also be some bitrot in the gprof side, as
the codepath to read BSD style gmon.out files is also broken.  I've
posted a separate patch to the binutils list.  With both these fixes,
gprof again works with Cygwin.

Brian
--------------BD6BD1EBBC686AA713942B12
Content-Type: text/plain; charset=us-ascii;
 name="mcount_asm_volatile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mcount_asm_volatile.patch"
Content-length: 919

2008-08-04  Brian Dessent  <brian@dessent.net>

	* config/i386/profile.h (mcount): Mark asms volatile.

Index: config/i386/profile.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/config/i386/profile.h,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 profile.h
--- config/i386/profile.h	17 Feb 2000 19:38:31 -0000	1.1.1.1
+++ config/i386/profile.h	5 Aug 2008 05:02:25 -0000
@@ -48,11 +48,11 @@ mcount()								\
 	 *								\
 	 * selfpc = pc pushed by mcount call				\
 	 */								\
-	__asm("movl 4(%%ebp),%0" : "=r" (selfpc));			\
+	__asm __volatile ("movl 4(%%ebp),%0" : "=r" (selfpc));		\
 	/*								\
 	 * frompcindex = pc pushed by call into self.			\
 	 */								\
-	__asm("movl (%%ebp),%0;movl 4(%0),%0" : "=r" (frompcindex));	\
+	__asm __volatile ("movl (%%ebp),%0;movl 4(%0),%0" : "=r" (frompcindex));\
 	_mcount(frompcindex, selfpc);					\
 }
 

--------------BD6BD1EBBC686AA713942B12--

