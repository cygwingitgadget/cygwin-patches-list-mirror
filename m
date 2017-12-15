Return-Path: <cygwin-patches-return-8970-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75920 invoked by alias); 15 Dec 2017 01:09:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75908 invoked by uid 89); 15 Dec 2017 01:09:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=eyes, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 15 Dec 2017 01:09:43 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vBF19gVT038423	for <cygwin-patches@cygwin.com>; Thu, 14 Dec 2017 17:09:42 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Fri, 15 Dec 2017 01:09:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement sigtimedwait
In-Reply-To: <20171214130348.GA24531@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1712141707080.37987@m0.truegem.net>
References: <20171214065430.4500-1-mark@maxrnd.com> <20171214130348.GA24531@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00100.txt.bz2

On Thu, 14 Dec 2017, Corinna Vinschen wrote:
> Hi Mark,
>
> Thanks for sigtimedwait!  Two questions:
>
> On Dec 13 22:54, Mark Geisert wrote:
>> diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
>> index 69c5e2aad..0599d8a3e 100644
>> --- a/winsup/cygwin/signal.cc
>> +++ b/winsup/cygwin/signal.cc
>> [...]
>> +	}
>> +      cwaittime.QuadPart = (LONGLONG) timeout->tv_sec * NSPERSEC
>> +                          + ((LONGLONG) timeout->tv_nsec + 99LL) / 100LL;
>> +    }
>> +
>> +  return sigwait_common (set, info, timeout ? &cwaittime : cw_infinite);
>
> Would you mind to change the name of cwaittime to waittime throughout?
> The leading "cw" actually puzzeled me for a while since I misinterpreted
> it as one of the cw_* constants.  No idea if it's just my bad eyes, but
> dropping the leading c might raise readability a bit.

I don't mind.  What I was attempting to communicate with "cwaittime" was a 
wait time in "cygwait units" of 100ns.  But I wasn't happy with it either.

Revised patch correcting both points is on its way.
Thanks much,

..mark
