Return-Path: <cygwin-patches-return-6504-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27744 invoked by alias); 11 Apr 2009 18:07:36 -0000
Received: (qmail 27734 invoked by uid 22791); 11 Apr 2009 18:07:35 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f226.google.com (HELO mail-bw0-f226.google.com) (209.85.218.226)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Apr 2009 18:07:30 +0000
Received: by bwz26 with SMTP id 26so1711117bwz.2         for <cygwin-patches@cygwin.com>; Sat, 11 Apr 2009 11:07:27 -0700 (PDT)
Received: by 10.103.24.11 with SMTP id b11mr2452859muj.76.1239473246991;         Sat, 11 Apr 2009 11:07:26 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id n10sm5768255mue.9.2009.04.11.11.07.26         (version=SSLv3 cipher=RC4-MD5);         Sat, 11 Apr 2009 11:07:26 -0700 (PDT)
Message-ID: <49E0DED2.5020601@gmail.com>
Date: Sat, 11 Apr 2009 18:07:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49DB4D95.7000903@byu.net> <49DB4FC4.7020903@cwilson.fastmail.fm> <20090407131534.GY852@calimero.vinschen.de> <49E013DC.4030509@gmail.com> <20090411080736.GA25426@calimero.vinschen.de> <20090411180023.GA3324@ednor.casa.cgf.cx>
In-Reply-To: <20090411180023.GA3324@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q2/txt/msg00046.txt.bz2

Christopher Faylor wrote:
> On Sat, Apr 11, 2009 at 10:07:36AM +0200, Corinna Vinschen wrote:
>> On Apr 11 04:51, Dave Korn wrote:
>>> Corinna Vinschen wrote:
>>>
>>>> Good point, I guess.  So, if we all agree on that, I'd suggest to
>>>> change Dave's patch to the one below.
>>>   Two hunks went astray in the adjustment, the fixes for INTPTR_Mxx and
>>> SIZE_MAX still apply because we didn't change their types.
>>>
>>>   Also, Joseph just introduced a new testcase in GCC SVN, and it shows up a
>>> problem with our definition of WINT_MAX.
>> What problem exactly?  UINT_MAX not defined?
>>
>>> 	* include/stdint.h (INTPTR_MIN, INTPTR_MAX):  Add 'L' suffix.
>>> 	(WINT_MAX):  Add 'U' suffix.
>> Applied.
> 
> These are now different than linux.  Didn't we want to make them the same?

  If linux doesn't have them matching the types they define, the linux headers
are going to need patching upstream as well.  We have

typedef long intptr_t;

therefore the constants must be long as well.  What does Linux have?

    cheers,
      DaveK
