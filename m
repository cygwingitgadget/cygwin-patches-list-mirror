Return-Path: <cygwin-patches-return-7408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7790 invoked by alias); 29 May 2011 00:23:39 -0000
Received: (qmail 7775 invoked by uid 22791); 29 May 2011 00:23:38 -0000
X-SWARE-Spam-Status: No, hits=-0.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY,URI_BLOGSPOT
X-Spam-Check-By: sourceware.org
Received: from nm17.bullet.mail.sp2.yahoo.com (HELO nm17.bullet.mail.sp2.yahoo.com) (98.139.91.87)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 29 May 2011 00:23:20 +0000
Received: from [98.139.91.65] by nm17.bullet.mail.sp2.yahoo.com with NNFMP; 29 May 2011 00:23:19 -0000
Received: from [208.71.42.210] by tm5.bullet.mail.sp2.yahoo.com with NNFMP; 29 May 2011 00:23:19 -0000
Received: from [127.0.0.1] by smtp221.mail.gq1.yahoo.com with NNFMP; 29 May 2011 00:23:19 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp221.mail.gq1.yahoo.com with SMTP; 28 May 2011 17:23:19 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2616742804D	for <cygwin-patches@cygwin.com>; Sat, 28 May 2011 20:23:18 -0400 (EDT)
Date: Sun, 29 May 2011 00:23:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems with: Improvements to fork handling (2/5)
Message-ID: <20110529002317.GA31865@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx> <4DE179DE.8040008@cs.utoronto.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE179DE.8040008@cs.utoronto.ca>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00174.txt.bz2

On Sat, May 28, 2011 at 06:40:30PM -0400, Ryan Johnson wrote:
>On 28/05/2011 4:50 PM, Christopher Faylor wrote:
>> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>>> This patch has the parent sort its dll list topologically by
>>> dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling
>>> in dependencies automatically, and the latter would then not benefit
>> >from the code which "encourages" them to land in the right places. The
>>> dependency tracking is achieved using a simple class which allows to
>>> introspect a mapped dll image and pull out the dependencies it lists.
>>> The code currently rebuilds the dependency list at every fork rather
>>> than attempt to update it properly as modules are loaded and unloaded.
>>> Note that the topsort optimization affects only cygwin dlls, so any
>>> windows dlls which are pulled in dynamically (directly or indirectly)
>>> will still impose the usual risk of address space clobbers.
>> Bad news.
>>
>> I applied this patch and the one after it but then noticed that zsh started
>> producing:  "bad address: " errors.
>>
>> path:4: bad address: /share/bin/dopath
>> term:1: bad address: /bin/tee
>>
>> The errors disappear when I back this patch out.
>>
>> FWIW, I was running "zsh -l".  I have somewhat complicated
>> .zshrc/.zlogin/.zshenv files.  I'll post them if needed.
>>
>> Until this is fixed, this patch and the subsequent ones which rely on
>> it, can't go in.  I did commit this fix but it has been backed out now.
>Hmm. I also see bad address errors in bash sometimes. However, when I 
>searched through the cygwin mailing list archives I saw that other 
>people have reported this problem in the past [1], so I figured it was 
>some existing, sporadic issue rather than my patch...
>
>Could you tell me what a 'bad address' error is? I'd be happy to debug 
>this, but really don't know what kind of bug I'm hunting here, except 
>that it might be a problem wow64 and suspending threads [2]. Whatever 
>became of these bad address errors the last time(s) they cropped up? I 
>can't find any resolution with Google, at least.

If I had any insight beyond "It works without the patch and it doesn't
work with it" I would have shared it.

>[1] http://cygwin.com/ml/cygwin/2011-02/msg00215.html
>[2] 
>http://zachsaw.blogspot.com/2010/11/wow64-bug-getthreadcontext-may-return.html
>
>Thoughts?

Pulling random messages out of the mailing list with the term "bad
address" in them is not going to fix the problem.  Given all of the
stuff you're doing with memory, it makes sense to me that your code has
a problem rather than this is a coincidental manifestation of a problem
reported three months ago.

cgf
