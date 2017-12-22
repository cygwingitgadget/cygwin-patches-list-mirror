Return-Path: <cygwin-patches-return-8986-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119144 invoked by alias); 22 Dec 2017 09:48:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119087 invoked by uid 89); 22 Dec 2017 09:48:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=Facility, air, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 22 Dec 2017 09:48:36 +0000
Received: from localhost (mark@localhost)	by m0.truegem.net (8.12.11/8.12.11) with ESMTP id vBM9mYBT035875	for <cygwin-patches@cygwin.com>; Fri, 22 Dec 2017 01:48:34 -0800 (PST)	(envelope-from mark@maxrnd.com)
Date: Fri, 22 Dec 2017 09:48:00 -0000
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin_internal methods to get/set thread name
In-Reply-To: <20171221102502.GJ19986@calimero.vinschen.de>
Message-ID: <Pine.BSF.4.63.1712220116310.32087@m0.truegem.net>
References: <20171220080832.2328-1-mark@maxrnd.com> <20171220115122.GF19986@calimero.vinschen.de> <Pine.BSF.4.63.1712202346060.17134@m0.truegem.net> <20171221102502.GJ19986@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00116.txt.bz2

On Thu, 21 Dec 2017, Corinna Vinschen wrote:
> On Dec 21 00:29, Mark Geisert wrote:
>> On Wed, 20 Dec 2017, Corinna Vinschen wrote:
>>> Hi Mark,
>>>
>>> A lot to discuss here.
>>
>> Yes, but first let me say I'd call these "speculative" patches, things I
>> found necessary during aio library development.  I had an incorrect mental
>> picture of the Cygwin DLL: I was treating it as just a user-space DLL where,
>> for an add-on library, one was free to use Cygwin constructs or pthread
>> constructs, or even Win32 constructs for that matter.
>>
>> I've now updated that mental picture of the Cygwin DLL to treat it as a
>> kernel, where one can only use constructs provided by Cygwin.  So, in the
>> aio library there will be cygthreads only and no pthreads or Win32 threads.
>> (So I should also separately update the gmon profiler to use a cygthread
>> rather than a Win32 thread ;-)).
>
> You're right that Cygwin is treated as kernel because it plays this
> role (combined with libc, libm, etc) for all the rest of Cygwin libs
> and executables.
>
> But I'm not sure what you mean by "aio library" here.  aio functionality
> should be part of Cygwin itself.  As soon as you implement another
> library linking against the Cygwin DLL, you're "user space" and thus you
> can only use POSIX calls.

I fear I may have confused you by discussing what I *had* implemented, but 
have now discarded in order to use a new approach.  The new approach (aio 
within Cygwin DLL, using cygthreads but only if necessary) I do agree with 
and will implement towards.  But what I had working already, previously, 
was a separate aio library built on top of Cygwin that I linked with my 
test app.  That library operated just as you surmised above: only used 
POSIX calls, used pthreads, only used cygwin_internal() to get at 
underlying fds.  I agree that that first approach, though working, is a 
non-starter for a robust Cygwin aio facility.

>                            The cygwin_internal() call is a very narrow
> exception, which basically should only be used to access Cygwin
> internals by applications which know what they are doing.  That's almost
> exclusively the stuff in the winsup/utils dir.  Given that cygthreads
> are not exported from the Cygwin DLL, you would not be able to use them(*)
>
> So as I understood it, aio stuff should be implemented inside the
> "kernel", the Cygwin DLL, using internal classes, methods and functions,
> exporting aio POSIX calls to user space.  Thus it's not clear to me what
> you mean by "aio library" at the moment.

I just meant the aio_* and lio_* functions as a group.  Wasn't using 
"library" literally, though my first implementation was organized as a 
linkable library.  "Facility" would be a better word than library.

>
> (*) Actually, I think you won't need threads at all if you use Windows
>    completion routines, but you know that already :}

Absolutely!

>
>> So these patches reflect the earlier mental picture.  Maybe none of the code
>> makes sense in an accurate mental picture.  I wanted to at least air the
>> code to see if some use might be made of it before discarding it.
>
> I don't see a need for such calls unless they are used by very specific
> scenarios, like GDB or strace.
>
>> [...]
>> I was using strace and getting annoyed with it displaying "unknown thread
>> 0x###" for my aio threads.  At that point they were pthreads and not
>> cygthreads.  So that was the impetus for the name-getting additions.
>> Name-setting, that's another story.  I thought that perhaps a debugging app
>> might want to tag threads of a subject process with names if they don't
>> already have names.  But I concede there is no such app at present.
>
> Given that you'd have to call cygwin_internal as well as
> pthread_setname_np in the context of the traced process, there's not
> much difference...

Yes, I see now what you mean.  I wasn't looking from far enough away.

Welp, it seems all the patch content relating to cygwin_internal() 
should go away.

I'd still like to get a vote of acceptance for what I've called the 
"courtesy" code in cygthread.cc, cygthread::name method.  The method is 
called with a Windows tid and that tid is looked up in the table of 
cygthreads.  If found, you immediately have the thread's name.  I added 
code on the failure path for the case where tid represents a pthread.  If 
it does, the pthread's name is retrieved into the result buffer.

This would be useful in straces of any application whose pthreads issue 
Cygwin syscalls: It means the strace log has messages referring to 
pthreads by their names and not by "unknown 0x###" as at present.  It was 
a help while debugging my "aio library built in userspace using pthreads" 
that shall never be mentioned again ;-).  But somebody else coding or 
debugging their own multi-threaded app will run into this need eventually.
Thanks for reading,

..mark
