Return-Path: <cygwin-patches-return-6562-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17694 invoked by alias); 7 Jul 2009 21:09:02 -0000
Received: (qmail 17680 invoked by uid 22791); 7 Jul 2009 21:09:01 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f217.google.com (HELO mail-fx0-f217.google.com) (209.85.220.217)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 21:08:53 +0000
Received: by fxm17 with SMTP id 17so3604835fxm.2         for <cygwin-patches@cygwin.com>; Tue, 07 Jul 2009 14:08:50 -0700 (PDT)
Received: by 10.103.248.17 with SMTP id a17mr3657535mus.97.1247000930837;         Tue, 07 Jul 2009 14:08:50 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id w5sm2592696mue.34.2009.07.07.14.08.49         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Jul 2009 14:08:50 -0700 (PDT)
Message-ID: <4A53BC5D.7010401@gmail.com>
Date: Tue, 07 Jul 2009 21:09:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com>
In-Reply-To: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com>
Content-Type: multipart/mixed;  boundary="------------000004060109010209050101"
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
X-SW-Source: 2009-q3/txt/msg00016.txt.bz2

This is a multi-part message in MIME format.
--------------000004060109010209050101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1773

Brian Ford wrote:
> I'm trying to build Cygwin 1.7 from CVS to debug an ImageMagick problem on
> server 2008 that causes an access violation in cygwin1.dll.  Doe anyone
> know the work around for this issue?
> 
> g++ (GCC) 3.4.4 (cygming special, gdc 0.12, using dmd 0.125)
> 
> winsup/cygwin/winbase.h: In
> member function `int pthread_mutex::_trylock(pthread*)':
> winsup/cygwin/winbase.h:59:
> warning: volatile register variables don't work as you might wish
> winsup/cygwin/winbase.h:63:
> error: can't find a register in class `AREG' while reloading `asm'

  The attached patch fixes the warning about volatile register variables, by
explicitly specifying the type, instead of using typeof() the input parameter
(which inherits the volatility), and which I also saw using gcc HEAD the other
day.

  It doesn't do anything about the reload failure, which is a bug in GCC-3,
since the usage is a standard usage supported by the documentation.  It's
possible that it may disappear as a side-effect, in which case all the better.
 (I experimented briefly with removing the register asm from the source and
building it with gcc-4.3.2, and the results were disappointing; we actually
got worse register allocation, resulting in some functions having larger stack
frames and more registers saved/restored, so I guess the RA can still benefit
from the extra hint.)

  Tested by building thread.o and shared.o with CFLAGS="-g -O2 --save-temps"
before and after and comparing the generated .s file; no differences except in
debug info, where (naturally) a bunch of bits changed in the flag words
encoding the datatypes of variables.

winsup/cygwin/ChangeLog:

	* winbase.h (ilockexch):  Avoid making 'ret' volatile.
	(ilockcmpexch):  Likewise.

  Ok?

    cheers,
      DaveK

--------------000004060109010209050101
Content-Type: text/x-c;
 name="winbase-no-volatile-temp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="winbase-no-volatile-temp.diff"
Content-length: 816

Index: winsup/cygwin/winbase.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winbase.h,v
retrieving revision 1.15
diff -p -u -r1.15 winbase.h
--- winsup/cygwin/winbase.h	5 Jun 2009 13:53:01 -0000	1.15
+++ winsup/cygwin/winbase.h	7 Jul 2009 20:53:12 -0000
@@ -40,7 +40,7 @@ ilockexch (volatile long *t, long v)
 {
   return
   ({
-    register __typeof (*t) ret __asm ("%eax");
+    register long ret __asm ("%eax");
     __asm __volatile ("\n"
 	"1:	lock cmpxchgl %2, %1\n"
 	"	jne  1b\n"
@@ -56,7 +56,7 @@ ilockcmpexch (volatile long *t, long v, 
 {
   return
   ({
-    register __typeof (*t) ret __asm ("%eax");
+    register long ret __asm ("%eax");
     __asm __volatile ("lock cmpxchgl %2, %1"
 	: "=a" (ret), "=m" (*t)
 	: "r" (v), "m" (*t), "0" (c)

--------------000004060109010209050101--
