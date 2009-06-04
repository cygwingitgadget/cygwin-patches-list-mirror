Return-Path: <cygwin-patches-return-6535-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3476 invoked by alias); 4 Jun 2009 01:41:13 -0000
Received: (qmail 3465 invoked by uid 22791); 4 Jun 2009 01:41:13 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f224.google.com (HELO mail-fx0-f224.google.com) (209.85.220.224)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 04 Jun 2009 01:41:07 +0000
Received: by fxm24 with SMTP id 24so433789fxm.2         for <cygwin-patches@cygwin.com>; Wed, 03 Jun 2009 18:41:05 -0700 (PDT)
Received: by 10.103.182.1 with SMTP id j1mr953753mup.119.1244079664894;         Wed, 03 Jun 2009 18:41:04 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id y2sm2408818mug.43.2009.06.03.18.41.03         (version=SSLv3 cipher=RC4-MD5);         Wed, 03 Jun 2009 18:41:04 -0700 (PDT)
Message-ID: <4A2728F8.8020907@gmail.com>
Date: Thu, 04 Jun 2009 01:41:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH?]  Separate pthread patches, #2 take 2.
References: <4A270656.8090704@gmail.com> <4A2716AF.9070101@gmail.com>
In-Reply-To: <4A2716AF.9070101@gmail.com>
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
X-SW-Source: 2009-q2/txt/msg00077.txt.bz2

Dave Korn wrote:
> Dave Korn wrote:
>>   The attached patch implements ilockexch and ilockcmpexch, using the inline
>> asm definition from __arch_compare_and_exchange_val_32_acq in
>> glibc-2.10.1/sysdeps/i386/i486/bits/atomic.h, trivially expanded inline rather
>> than in its original preprocessor macro form.
>>
>>   It generates incorrect code.
> 
>   This much looks like it's probably a compiler bug.  

  Let's see whether anyone else agrees:

        http://gcc.gnu.org/ml/gcc/2009-06/msg00053.html

    cheers,
      DaveK
