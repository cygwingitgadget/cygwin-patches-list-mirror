Return-Path: <cygwin-patches-return-8387-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116875 invoked by alias); 10 Mar 2016 19:12:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116857 invoked by uid 89); 10 Mar 2016 19:12:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=Geisert, geisert, pushing, Either
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 10 Mar 2016 19:12:30 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u2AJBxED035831	for <cygwin-patches@cygwin.com>; Thu, 10 Mar 2016 11:11:59 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 10 Mar 2016 19:12:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
In-Reply-To: <20160310094053.GE13258@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1603101048110.25541@m0.truegem.net>
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de> <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net> <56E131C6.5080008@maxrnd.com> <20160310093933.GD13258@calimero.vinschen.de> <20160310094053.GE13258@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00093.txt.bz2

On Thu, 10 Mar 2016, Corinna Vinschen wrote:
> On Mar 10 10:39, Corinna Vinschen wrote:
>> On Mar 10 00:35, Mark Geisert wrote:
>>> This is Version 4 incorporating review comments of Version 3.  This is just
>>> the code patch; a separate doc patch is forthcoming.
>>
>> Uhm...
>>
>>> +		long divisor = 1000*1000*1000; // covers positive pid_t values
>>
>> ...still "long"?
>>
>> Was that an oversight or did you decide to keep it a long?  Either way,
>> no reason to resend another patch version.  If you want an int32_t here,
>> I fix that locally before pushing the patch.

Oversight.  Now corrected like this in my local repository:

-               long divisor = 1000*1000*1000; // covers positive pid_t values
+               int32_t divisor = 1000*1000*1000; // covers +ve pid_t values

Hopefully this mailer won't fold those two lines.

>
> Oh, btw., do you have a sentence or two for the release text?  Just
> a short description what's new or changed or fixed.  Have a look at
> winsup/cygwin/release/2.5.0 for an informal howto.

What's new:
-----------

- Environment variable GMON_OUT_PREFIX enables multiple gmon.out files to
   preserve profiling data after fork or from multiple program runs.

What changed:
-------------

- Profiling data, specifically pc sampling, now covers all threads of a
   program and not just the main thread.


OK with me if you prefer both sentences in one category or the other.  I 
hope to have the doc patch ready in the next day or two.
Thanks,

..mark
