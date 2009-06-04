Return-Path: <cygwin-patches-return-6533-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32576 invoked by alias); 4 Jun 2009 00:23:16 -0000
Received: (qmail 32566 invoked by uid 22791); 4 Jun 2009 00:23:15 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_74,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 00:23:06 +0000
Received: by bwz26 with SMTP id 26so403669bwz.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 17:23:03 -0700 (PDT)
Received: by 10.204.123.136 with SMTP id p8mr1456582bkr.21.1244074983929;         Wed, 03 Jun 2009 17:23:03 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 31sm10954155fkt.43.2009.06.03.17.23.02         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 17:23:03 -0700 (PDT)
Message-ID: <4A2716AF.9070101@gmail.com>
Date: Thu, 04 Jun 2009 00:23:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 2.
References: <4A270656.8090704@gmail.com>
In-Reply-To: <4A270656.8090704@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
X-SW-Source: 2009-q2/txt/msg00075.txt.bz2

Dave Korn wrote:
>   The attached patch implements ilockexch and ilockcmpexch, using the inline
> asm definition from __arch_compare_and_exchange_val_32_acq in
> glibc-2.10.1/sysdeps/i386/i486/bits/atomic.h, trivially expanded inline rather
> than in its original preprocessor macro form.
> 
>   It generates incorrect code.

  This much looks like it's probably a compiler bug.  This version, compiled
with current GCC HEAD, generates the same results as in the take 3 version,
without needing the explicit memory clobber added:

L469:
	.loc 2 127 0
	movl	__ZN13pthread_mutex7mutexesE+8, %eax	 # mutexes.head, D.30413
	movl	%eax, 36(%ebx)	 # D.30413, <variable>.next
	.loc 5 58 0
/APP
 # 58 "/gnu/winsup/src/winsup/cygwin/winbase.h" 1
	lock cmpxchgl %ebx, __ZN13pthread_mutex7mutexesE+8	 # this,
 # 0 "" 2
/NO_APP
	movl	%eax, -12(%ebp)	 # tmp76, ret
	.loc 5 59 0
	movl	-12(%ebp), %eax	 # ret, D.30414
	.loc 2 126 0
	cmpl	%eax, 36(%ebx)	 # D.30414, <variable>.next
	jne	L469	 #,

... right down to the unoptimised register motion.  This is what we would have
hoped to see: the "memory" clobber ought to be superfluous, and the
write-output operand in *t should have told GCC not to move the store to
node->next after the loop.

  I checked 4.3.3; it behaves the same as 4.3.2, i.e. it incorrectly lowers
the store without a memory clobber present.

    cheers,
      DaveK
