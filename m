Return-Path: <cygwin-patches-return-6502-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16794 invoked by alias); 11 Apr 2009 11:20:44 -0000
Received: (qmail 16783 invoked by uid 22791); 11 Apr 2009 11:20:43 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f176.google.com (HELO mail-fx0-f176.google.com) (209.85.220.176)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Apr 2009 11:20:37 +0000
Received: by fxm24 with SMTP id 24so1523159fxm.2         for <cygwin-patches@cygwin.com>; Sat, 11 Apr 2009 04:20:34 -0700 (PDT)
Received: by 10.103.250.1 with SMTP id c1mr2315932mus.64.1239448834860;         Sat, 11 Apr 2009 04:20:34 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id j10sm5086273mue.56.2009.04.11.04.20.33         (version=SSLv3 cipher=RC4-MD5);         Sat, 11 Apr 2009 04:20:34 -0700 (PDT)
Message-ID: <49E07A60.80902@gmail.com>
Date: Sat, 11 Apr 2009 11:20:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49E013DC.4030509@gmail.com> <20090411080736.GA25426@calimero.vinschen.de>
In-Reply-To: <20090411080736.GA25426@calimero.vinschen.de>
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
X-SW-Source: 2009-q2/txt/msg00044.txt.bz2

Corinna Vinschen wrote:
> On Apr 11 04:51, Dave Korn wrote:
>> Corinna Vinschen wrote:
>>
>>> Good point, I guess.  So, if we all agree on that, I'd suggest to
>>> change Dave's patch to the one below.
>>   Two hunks went astray in the adjustment, the fixes for INTPTR_Mxx and
>> SIZE_MAX still apply because we didn't change their types.
>>
>>   Also, Joseph just introduced a new testcase in GCC SVN, and it shows up a
>> problem with our definition of WINT_MAX.
> 
> What problem exactly?  UINT_MAX not defined?

  Yep.  The other option would have been for stdint.h to #include limits.h,
but that starts to drag in a bunch of other stuff and I figured out best not
to add a bunch of unexpected dependencies.

    cheers,
      DaveK


