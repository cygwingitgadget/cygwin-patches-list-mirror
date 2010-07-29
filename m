Return-Path: <cygwin-patches-return-7047-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10088 invoked by alias); 29 Jul 2010 02:39:51 -0000
Received: (qmail 10074 invoked by uid 22791); 29 Jul 2010 02:39:50 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f45.google.com (HELO mail-ww0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 29 Jul 2010 02:39:47 +0000
Received: by wwf26 with SMTP id 26so30770wwf.2        for <cygwin-patches@cygwin.com>; Wed, 28 Jul 2010 19:39:45 -0700 (PDT)
Received: by 10.227.132.129 with SMTP id b1mr11540202wbt.5.1280371185124;        Wed, 28 Jul 2010 19:39:45 -0700 (PDT)
Received: from [192.168.2.99] ([82.6.108.62])        by mx.google.com with ESMTPS id a1sm259071wbb.14.2010.07.28.19.39.43        (version=SSLv3 cipher=RC4-MD5);        Wed, 28 Jul 2010 19:39:44 -0700 (PDT)
Message-ID: <4C50EEF0.4090903@gmail.com>
Date: Thu, 29 Jul 2010 02:39:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix build warnings for functions without return value
References: <004d01cb2e99$7567c500$60374f00$@gmail.com> <20100728224433.GA11483@ednor.casa.cgf.cx> <000601cb2eab$52022a30$f6067e90$@gmail.com>
In-Reply-To: <000601cb2eab$52022a30$f6067e90$@gmail.com>
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
X-SW-Source: 2010-q3/txt/msg00007.txt.bz2

On 29/07/2010 00:19, Daniel Colascione wrote:
>> From: cygwin-patches-owner@cygwin.com [mailto:cygwin-patches-
>>
>> I don't see why this is needed.  Cygwin uses -Werror by default so, if gcc
> 4.3.4
>> emitted warnings we wouldn't be able to build a release or make a
> snapshot.
> 
> It's because Cygwin uses -Werror that I had to patch the source. I'm
> compiling with '-Os -march=native', which must tickle a different part of
> the optimizer and thereby produce this warning.

  This is http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42674

> (One of the nice things
> about clang is reportedly that it produces the same warnings no matter what
> the optimizer does.) Besides, the current code is technically undefined and
> the patch removes that undefined behavior --- which could start producing
> warnings for the current build at any time.

  I think actually it's not undefined, because the functions never return.

    cheers,
      DaveK
