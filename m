Return-Path: <cygwin-patches-return-8325-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5372 invoked by alias); 18 Feb 2016 06:36:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 5361 invoked by uid 89); 18 Feb 2016 06:36:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_05,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=behavioral, qualifies, H*r:8.12.11, ssp
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 18 Feb 2016 06:36:07 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id u1I6ZoQK027677	for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2016 22:35:51 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Thu, 18 Feb 2016 06:36:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: gprof profiling of multi-threaded Cygwin programs
In-Reply-To: <20160217104241.GA31536@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1602172218120.19332@m0.truegem.net>
References: <56C404FF.502@maxrnd.com> <20160217104241.GA31536@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00031.txt.bz2

On Wed, 17 Feb 2016, Corinna Vinschen wrote:
> Hi Mark,
>
>
> thanks for the patch.  Generally the patch is fine, I have just a few
> nits.
>
> On Feb 16 21:28, Mark Geisert wrote:
>> I've attached a patch set modifying Cygwin's profiling support to sample PC
>> values of all an application's threads, not just the main thread.  There is
>> no change to how profiling is requested: just compile and link the app with
>> "-pg" as usual.  The profiling info is dumped into file gmon.out as usual.
>>
>> There is a behavioral change that ought to be documented somewhere:  If a
>
> If it ought to be documented, what about providing the doc patch, too?
> Any chance you could come up with a short section about profiling in the
> context of winsup/doc/programming.xml?  Otherwise there's basically only
> the description of the ssp tool in winsup/doc/utils.xml yet, which is a
> bit ... disappointing.

I can provide a doc patch but I could not figure out where this behavior 
change should be documented.  winsup/doc/utils.xml is concerned with tools 
written for Cygwin, but the behavior change is to bog-standard gprof from 
binutils that we're using on Cygwin.  (Note that no gprof code was 
changed; it's the system that's changed under it.)  There is no 
/usr/share/doc/Cygwin/binutils.README yet and I guess that's because there 
hasn't been a need for one.  Not sure this qualifies.

It seems like a Cygwin-specific gprof man page patch is what's called for. 
Is there an example of that in the source tree I could crib from?

I do see that a case could be made for general profiling documentation in 
winsup/doc/programming.xml but that's more than I want to take on at the 
moment.

All your other review comments are OK by me and I'll implement those and 
resubmit the patch when that's done, including the simple doc update.
Thanks much,

..mark
