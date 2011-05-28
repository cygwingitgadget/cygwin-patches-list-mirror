Return-Path: <cygwin-patches-return-7407-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24363 invoked by alias); 28 May 2011 22:40:53 -0000
Received: (qmail 24350 invoked by uid 22791); 28 May 2011 22:40:51 -0000
X-SWARE-Spam-Status: No, hits=1.0 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL,URI_BLOGSPOT
X-Spam-Check-By: sourceware.org
Received: from smtp0.epfl.ch (HELO smtp0.epfl.ch) (128.178.224.219)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 28 May 2011 22:40:36 +0000
Received: (qmail 16255 invoked by uid 107); 28 May 2011 22:40:31 -0000
Received: from 206-248-130-97.dsl.teksavvy.com (HELO discarded) (206.248.130.97) (authenticated)  by smtp0.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Sun, 29 May 2011 00:40:31 +0200
Message-ID: <4DE179DE.8040008@cs.utoronto.ca>
Date: Sat, 28 May 2011 22:40:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Problems with: Improvements to fork handling (2/5)
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx>
In-Reply-To: <20110528205000.GA30326@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2011-q2/txt/msg00173.txt.bz2

On 28/05/2011 4:50 PM, Christopher Faylor wrote:
> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>> This patch has the parent sort its dll list topologically by
>> dependencies. Previously, attempts to load a DLL_LOAD dll risked pulling
>> in dependencies automatically, and the latter would then not benefit
> >from the code which "encourages" them to land in the right places. The
>> dependency tracking is achieved using a simple class which allows to
>> introspect a mapped dll image and pull out the dependencies it lists.
>> The code currently rebuilds the dependency list at every fork rather
>> than attempt to update it properly as modules are loaded and unloaded.
>> Note that the topsort optimization affects only cygwin dlls, so any
>> windows dlls which are pulled in dynamically (directly or indirectly)
>> will still impose the usual risk of address space clobbers.
> Bad news.
>
> I applied this patch and the one after it but then noticed that zsh started
> producing:  "bad address: " errors.
>
> path:4: bad address: /share/bin/dopath
> term:1: bad address: /bin/tee
>
> The errors disappear when I back this patch out.
>
> FWIW, I was running "zsh -l".  I have somewhat complicated
> .zshrc/.zlogin/.zshenv files.  I'll post them if needed.
>
> Until this is fixed, this patch and the subsequent ones which rely on
> it, can't go in.  I did commit this fix but it has been backed out now.
Hmm. I also see bad address errors in bash sometimes. However, when I 
searched through the cygwin mailing list archives I saw that other 
people have reported this problem in the past [1], so I figured it was 
some existing, sporadic issue rather than my patch...

Could you tell me what a 'bad address' error is? I'd be happy to debug 
this, but really don't know what kind of bug I'm hunting here, except 
that it might be a problem wow64 and suspending threads [2]. Whatever 
became of these bad address errors the last time(s) they cropped up? I 
can't find any resolution with Google, at least.

[1] http://cygwin.com/ml/cygwin/2011-02/msg00215.html
[2] 
http://zachsaw.blogspot.com/2010/11/wow64-bug-getthreadcontext-may-return.html

Thoughts?
Ryan
