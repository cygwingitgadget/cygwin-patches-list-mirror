Return-Path: <cygwin-patches-return-6532-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8286 invoked by alias); 3 Jun 2009 23:41:37 -0000
Received: (qmail 8276 invoked by uid 22791); 3 Jun 2009 23:41:36 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_74,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Jun 2009 23:41:29 +0000
Received: by bwz26 with SMTP id 26so390943bwz.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 16:41:26 -0700 (PDT)
Received: by 10.204.57.67 with SMTP id b3mr1411850bkh.99.1244072486371;         Wed, 03 Jun 2009 16:41:26 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 28sm10898351fkx.24.2009.06.03.16.41.25         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 16:41:25 -0700 (PDT)
Message-ID: <4A270CEE.3030100@gmail.com>
Date: Wed, 03 Jun 2009 23:41:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 1 redux
References: <4A270656.8090704@gmail.com> <4A270BA4.3080602@gmail.com>
In-Reply-To: <4A270BA4.3080602@gmail.com>
Content-Type: multipart/mixed;  boundary="------------000701070008000604090502"
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
X-SW-Source: 2009-q2/txt/msg00074.txt.bz2

This is a multi-part message in MIME format.
--------------000701070008000604090502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 982

Dave Korn wrote:
> Dave Korn wrote:
>>   The attached patch implements ilockexch and ilockcmpexch, using the inline
>> asm definition from __arch_compare_and_exchange_val_32_acq in
>> glibc-2.10.1/sysdeps/i386/i486/bits/atomic.h, trivially expanded inline rather
>> than in its original preprocessor macro form.

  And this one, just to have the full set in the same place, is the version
that I originally suggested.  It generates correct and efficient code:

L215:
	.loc 3 127 0
	movl	__ZN13pthread_mutex7mutexesE+8, %eax	 # mutexes.head, D.28638
	movl	%eax, 36(%ebx)	 # D.28638, <variable>.next
	.loc 2 53 0
/APP
 # 53 "/gnu/winsup/src/winsup/cygwin/winbase.h" 1
	
	lock cmpxchgl %ebx,__ZN13pthread_mutex7mutexesE+8	 # this,
	
 # 0 "" 2
/NO_APP
	.loc 3 126 0
	cmpl	%eax, 36(%ebx)	 # D.28635, <variable>.next
	jne	L215	 #,

but is more risky.  No ChangeLog because it's not going to be approved, I'm
posting it just for completeness and future reference.

    cheers,
      DaveK

--------------000701070008000604090502
Content-Type: text/x-c;
 name="pthread-interlocked-asms-v1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pthread-interlocked-asms-v1.diff"
Content-length: 1129

Index: winsup/cygwin/winbase.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winbase.h,v
retrieving revision 1.14
diff -p -u -r1.14 winbase.h
--- winsup/cygwin/winbase.h	12 Jul 2008 18:09:17 -0000	1.14
+++ winsup/cygwin/winbase.h	3 Jun 2009 17:38:06 -0000
@@ -38,21 +38,21 @@ ilockdecr (volatile long *m)
 extern __inline__ long
 ilockexch (volatile long *t, long v)
 {
-  register int __res;
+  register long __res __asm__ ("%eax") = *t;
   __asm__ __volatile__ ("\n\
-1:	lock	cmpxchgl %3,(%1)\n\
+1:	lock	cmpxchgl %2,%1\n\
 	jne 1b\n\
- 	": "=a" (__res), "=q" (t): "1" (t), "q" (v), "0" (*t): "cc");
+ 	": "+a" (__res), "=m" (*t): "q" (v), "m" (*t) : "memory", "cc");
   return __res;
 }
 
 extern __inline__ long
 ilockcmpexch (volatile long *t, long v, long c)
 {
-  register int __res;
+  register long __res __asm ("%eax") = c;
   __asm__ __volatile__ ("\n\
-	lock cmpxchgl %3,(%1)\n\
-	": "=a" (__res), "=q" (t) : "1" (t), "q" (v), "0" (c): "cc");
+	lock cmpxchgl %2,%1\n\
+	": "+a" (__res), "=m" (*t) : "q" (v), "m" (*t) : "memory", "cc");
   return __res;
 }
 

--------------000701070008000604090502--
