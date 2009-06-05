Return-Path: <cygwin-patches-return-6542-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16252 invoked by alias); 5 Jun 2009 13:53:22 -0000
Received: (qmail 16234 invoked by uid 22791); 5 Jun 2009 13:53:21 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_62,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f224.google.com (HELO mail-fx0-f224.google.com) (209.85.220.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 05 Jun 2009 13:53:15 +0000
Received: by fxm24 with SMTP id 24so1637693fxm.2         for <cygwin-patches@cygwin.com>; Fri, 05 Jun 2009 06:53:12 -0700 (PDT)
Received: by 10.103.174.18 with SMTP id b18mr2208747mup.47.1244209991690;         Fri, 05 Jun 2009 06:53:11 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id j2sm9666828mue.42.2009.06.05.06.53.04         (version=SSLv3 cipher=RC4-MD5);         Fri, 05 Jun 2009 06:53:08 -0700 (PDT)
Message-ID: <4A29260B.90001@gmail.com>
Date: Fri, 05 Jun 2009 13:53:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 2.
References: <4A270656.8090704@gmail.com> <4A2716AF.9070101@gmail.com> <4A2728F8.8020907@gmail.com> <20090604151053.GX23519@calimero.vinschen.de>
In-Reply-To: <20090604151053.GX23519@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------090203010707090808010601"
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
X-SW-Source: 2009-q2/txt/msg00084.txt.bz2

This is a multi-part message in MIME format.
--------------090203010707090808010601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1900

Corinna Vinschen wrote:
> On Jun  4 02:52, Dave Korn wrote:
>> Dave Korn wrote:
>>> Dave Korn wrote:
>>>>   The attached patch implements ilockexch and ilockcmpexch, using the inline
>>>> asm definition from __arch_compare_and_exchange_val_32_acq in
>>>> glibc-2.10.1/sysdeps/i386/i486/bits/atomic.h, trivially expanded inline rather
>>>> than in its original preprocessor macro form.
>>>>
>>>>   It generates incorrect code.
>>>   This much looks like it's probably a compiler bug.  
>>   Let's see whether anyone else agrees:
>>
>>         http://gcc.gnu.org/ml/gcc/2009-06/msg00053.html
> 
> When you checked in this change, I'll create a 1.7.0-49 test release.

  This is the final version I committed.  It is the glibc version, with the
addition of the memory clobber, which that discussion revealed was absolutely
required, and the use of a register asm var to feed the inline asm, which is
in accordance with documented practice in the gcc manual.  (This now leaves
only one difference between the glibc version and the version I posted, which
is the use of a "+a" write-only output constraint paired with a numeric "0"
matching input constraint in glibc's version compared with a single output
operand using the read-write constraing "=a" in my version.  These should in
fact be exactly identical in terms of what they indicate to reload, in any case.)

  I have also manually inspected the generated assembly from thread.cc and
shared.cc in a cygwin DLL build and verified that it is correct and efficient,
and have installed the resulting DLL and retested all Thomas Stalder's
testcases and the previously intermittently failing pthread7-rope testcase
from libstdc++ testsuite.  Committed with this ChangeLog:

winsup/cygwin/ChangeLog

	* winbase.h (ilockexch):  Fix asm constraints.
	(ilockcmpexch):  Likewise.


  Libstdc++ plan after the weekend.  Cheers all!

    cheers,
      DaveK



--------------090203010707090808010601
Content-Type: text/x-c;
 name="pthread-interlocked-asms-final.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pthread-interlocked-asms-final.diff"
Content-length: 1358

? winsup/cygwin/cygwin-cxx.h
? winsup/cygwin/mutex
Index: winsup/cygwin/winbase.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winbase.h,v
retrieving revision 1.14
diff -p -u -r1.14 winbase.h
--- winsup/cygwin/winbase.h	12 Jul 2008 18:09:17 -0000	1.14
+++ winsup/cygwin/winbase.h	5 Jun 2009 13:05:08 -0000
@@ -38,22 +38,31 @@ ilockdecr (volatile long *m)
 extern __inline__ long
 ilockexch (volatile long *t, long v)
 {
-  register int __res;
-  __asm__ __volatile__ ("\n\
-1:	lock	cmpxchgl %3,(%1)\n\
-	jne 1b\n\
- 	": "=a" (__res), "=q" (t): "1" (t), "q" (v), "0" (*t): "cc");
-  return __res;
+  return
+  ({
+    register __typeof (*t) ret __asm ("%eax");
+    __asm __volatile ("\n"
+	"1:	lock cmpxchgl %2, %1\n"
+	"	jne  1b\n"
+	: "=a" (ret), "=m" (*t)
+	: "r" (v), "m" (*t), "0" (*t)
+	: "memory");
+    ret;
+  });
 }
 
 extern __inline__ long
 ilockcmpexch (volatile long *t, long v, long c)
 {
-  register int __res;
-  __asm__ __volatile__ ("\n\
-	lock cmpxchgl %3,(%1)\n\
-	": "=a" (__res), "=q" (t) : "1" (t), "q" (v), "0" (c): "cc");
-  return __res;
+  return
+  ({
+    register __typeof (*t) ret __asm ("%eax");
+    __asm __volatile ("lock cmpxchgl %2, %1"
+	: "=a" (ret), "=m" (*t)
+	: "r" (v), "m" (*t), "0" (c)
+	: "memory");
+    ret;
+  });
 }
 
 #undef InterlockedIncrement

--------------090203010707090808010601--
