Return-Path: <cygwin-patches-return-6476-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5511 invoked by alias); 4 Apr 2009 07:13:40 -0000
Received: (qmail 5501 invoked by uid 22791); 4 Apr 2009 07:13:39 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f173.google.com (HELO mail-ew0-f173.google.com) (209.85.219.173)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Apr 2009 07:13:33 +0000
Received: by ewy21 with SMTP id 21so1266283ewy.2         for <cygwin-patches@cygwin.com>; Sat, 04 Apr 2009 00:13:31 -0700 (PDT)
Received: by 10.210.71.13 with SMTP id t13mr1540159eba.80.1238829210982;         Sat, 04 Apr 2009 00:13:30 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 23sm3953284eya.26.2009.04.04.00.13.30         (version=SSLv3 cipher=RC4-MD5);         Sat, 04 Apr 2009 00:13:30 -0700 (PDT)
Message-ID: <49D70B05.6020509@gmail.com>
Date: Sat, 04 Apr 2009 07:13:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx>
In-Reply-To: <20090404062459.GB22452@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00018.txt.bz2

Christopher Faylor wrote:

  Ah, I could address a bit more to these two questions as well:

> Isn't a long 32 bits?  What would be the ABI breakage in changing that
> one typedef rather than lots of #defines?  

  Yes, a long is 32 bits, but while that makes for binary ABI
(calling-convention) compatibility it isn't the same thing in the C and C++
types system.  Therefore the underlying types are an inextricably woven part
of the overall C-language ABI as well as their physical bit sizes.  Changing
them certainly has the potential to change the ABI, particularly in C++, but I
think it also might potentially render some of the compiler's aliasing
assumptions invalid when linking code using the new definitions against
objects or libraries using the old.

  Changing the limits #defines, OTOH, is absolutely guaranteed ABI neutral.
They really are "just constants" at runtime, and constants don't get mangled
or alias anything.  So I reckon it's a safer way to proceed and I don't yet
see any potential 64-bit problems down the line if we leave everything as it
currently stands.

  Can you see anything I've overlooked in this analysis?

    cheers,
      DaveK
