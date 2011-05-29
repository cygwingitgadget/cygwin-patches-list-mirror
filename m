Return-Path: <cygwin-patches-return-7411-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2896 invoked by alias); 29 May 2011 08:00:41 -0000
Received: (qmail 2848 invoked by uid 22791); 29 May 2011 08:00:37 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm19-vm0.bullet.mail.bf1.yahoo.com (HELO nm19-vm0.bullet.mail.bf1.yahoo.com) (98.139.213.162)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 29 May 2011 08:00:22 +0000
Received: from [98.139.212.153] by nm19.bullet.mail.bf1.yahoo.com with NNFMP; 29 May 2011 05:58:52 -0000
Received: from [98.139.211.206] by tm10.bullet.mail.bf1.yahoo.com with NNFMP; 29 May 2011 05:58:52 -0000
Received: from [127.0.0.1] by smtp215.mail.bf1.yahoo.com with NNFMP; 29 May 2011 05:58:52 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp215.mail.bf1.yahoo.com with SMTP; 28 May 2011 22:58:51 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 308A742804D	for <cygwin-patches@cygwin.com>; Sun, 29 May 2011 01:58:51 -0400 (EDT)
Date: Sun, 29 May 2011 08:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Problems with: Improvements to fork handling (2/5)
Message-ID: <20110529055851.GA32323@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DCAD609.70106@cs.utoronto.ca> <20110528205000.GA30326@ednor.casa.cgf.cx> <4DE179DE.8040008@cs.utoronto.ca> <20110529002317.GA31865@ednor.casa.cgf.cx> <4DE1B101.4000603@cs.utoronto.ca> <4DE1CD9D.20608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE1CD9D.20608@gmail.com>
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
X-SW-Source: 2011-q2/txt/msg00177.txt.bz2

On Sat, May 28, 2011 at 09:37:49PM -0700, Daniel Colascione wrote:
>On 5/28/11 7:35 PM, Ryan Johnson wrote:
>> On 28/05/2011 8:23 PM, Christopher Faylor wrote:
>>> On Sat, May 28, 2011 at 06:40:30PM -0400, Ryan Johnson wrote:
>>>> On 28/05/2011 4:50 PM, Christopher Faylor wrote:
>>>>> On Wed, May 11, 2011 at 02:31:37PM -0400, Ryan Johnson wrote:
>>>>>> This patch has the parent sort its dll list topologically by
>>>>>> dependencies. Previously, attempts to load a DLL_LOAD dll risked
>>>>>> pulling
>>>>>> in dependencies automatically, and the latter would then not benefit
>>>>> >from the code which "encourages" them to land in the right places. The
>>>>>> dependency tracking is achieved using a simple class which allows to
>>>>>> introspect a mapped dll image and pull out the dependencies it lists.
>>>>>> The code currently rebuilds the dependency list at every fork rather
>>>>>> than attempt to update it properly as modules are loaded and unloaded.
>>>>>> Note that the topsort optimization affects only cygwin dlls, so any
>>>>>> windows dlls which are pulled in dynamically (directly or indirectly)
>>>>>> will still impose the usual risk of address space clobbers.
>>>>> Bad news.
>>>>>
>>>>> I applied this patch and the one after it but then noticed that zsh
>>>>> started
>>>>> producing:  "bad address: " errors.
>>>>>
>>>>> path:4: bad address: /share/bin/dopath
>>>>> term:1: bad address: /bin/tee
>>>>>
>>>>> The errors disappear when I back this patch out.
>>>>>
>>>>> FWIW, I was running "zsh -l".  I have somewhat complicated
>>>>> .zshrc/.zlogin/.zshenv files.  I'll post them if needed.
>>>>>
>>>>> Until this is fixed, this patch and the subsequent ones which rely on
>>>>> it, can't go in.  I did commit this fix but it has been backed out now.
>>>> Hmm. I also see bad address errors in bash sometimes. However, when I
>>>> searched through the cygwin mailing list archives I saw that other
>>>> people have reported this problem in the past [1], so I figured it was
>>>> some existing, sporadic issue rather than my patch...
>>>>
>>>> Could you tell me what a 'bad address' error is? I'd be happy to debug
>>>> this, but really don't know what kind of bug I'm hunting here, except
>>>> that it might be a problem wow64 and suspending threads [2]. Whatever
>>>> became of these bad address errors the last time(s) they cropped up? I
>>>> can't find any resolution with Google, at least.
>>> If I had any insight beyond "It works without the patch and it doesn't
>>> work with it" I would have shared it.
>
>> Let me rephrase a bit... The error happens too early in fork for gdb to
>> be any help, and I was hoping you could tell me what part(s) of cygwin
>> are capable of "raising" this error -- it seems to be a linux (not
>> Windows) flavor of error message, but the case-insensitive regexp
>> 'bad.address' does not match anything in the cygwin sources.
>
>The actual string is in strerror.c in newlib, which is why you didn't
>find it with a grep on winsup/cygwin.

It doesn't come from newlib.  If you grep "Bad address" in
winsup/cygwin/* you will see where it comes from.

I don't know why grep -i 'bad.address' didn't find anything but it
really is there.

>The error code is EFAULT.  There are 127 places in the cygwin1.dll
>where EFAULT can raised, according to grep '\bEFAULT\b' *.cc.  In most
>of them, EFAULT is raised after something called san has detected that
>to Windows raised an unexpected structured exception.  My hunch would
>be to look in spawn.cc first, in spawn_guts, but I haven't read your
>patch in enough detail to narrow the problem down further.  strace
>might be handy.

spawn.cc wasn't touched by the patch but I suppose something in the
modified fork code could affect a subsequent exec.

Anyway, I don't see any indication that the problem is too early for the
CYGWIN_DEBUG= trick to work.  See how-to-debug-cygwin.txt.

cgf
