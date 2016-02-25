Return-Path: <cygwin-patches-return-8357-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 42943 invoked by alias); 25 Feb 2016 08:47:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42931 invoked by uid 89); 25 Feb 2016 08:47:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=Hx-languages-length:1604, geisert, Geisert, H*r:8.12.11
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 25 Feb 2016 08:47:22 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1P8l1gM069090	for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2016 00:47:01 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 25 Feb 2016 08:47:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
In-Reply-To: <20160223111423.GB5618@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1602250040380.66582@m0.truegem.net>
References: <56C820D8.4010203@maxrnd.com> <56CAF4A3.5060806@dronecode.org.uk> <Pine.BSF.4.63.1602222322100.88046@m0.truegem.net> <20160223111423.GB5618@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00063.txt.bz2

On Tue, 23 Feb 2016, Corinna Vinschen wrote:
> On Feb 22 23:36, Mark Geisert wrote:
>> On Mon, 22 Feb 2016, Jon Turney wrote:
>>> There doesn't seem to be anything specific to profiling about this, so it
>>> could be written in a more generic way, as "call a callback function for
>>> each thread".
>>
>> I saw your later conversation with Corinna on the list re why
>> cygwin_internal() is involved now.  (I too had stumbled over the
>> cygwin1.dll/libgmon.a gap when I started this work.)  Given the necessity of
>> the separation, does it still make sense to write a generic per-thread
>> callback mechanism and then make use of it for this patch, or is that
>> overkill?  I can't tell.
>
> One problem with a generic solution is to generalize the arguments to
> the called function.  IMHO, keep it as is for now.  If we ever need to
> make this generic we can still do it.

OK.

>>>> +	if ((prefix = getenv("GMON_OUT_PREFIX")) != NULL) {
>>>
>>> setup-env.xml might be an appropriate place to mention this environment
>>> variable.
>>
>> I am now writing a gprof.xml that will be tied into the existing
>> programming.xml.  I plan to document GMON_OUT_PREFIX in gprof.xml.  Do you
>> think that's sufficient?
>
> A single paragraph in setup-env.xml pointing to gprof.xml might be
> helpful, I think.

Alright, I can do that as part of the separate doc patch that I'm working.

I ran into an issue while testing the profiling of programs that fork() 
but don't exec().  So it may be a short while before I can send ver 3. 
Just FYI.

..mark
