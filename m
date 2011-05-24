Return-Path: <cygwin-patches-return-7402-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8178 invoked by alias); 24 May 2011 17:49:14 -0000
Received: (qmail 8154 invoked by uid 22791); 24 May 2011 17:49:09 -0000
X-SWARE-Spam-Status: No, hits=-0.3 required=5.0	tests=AWL,BAYES_00,SPF_NEUTRAL
X-Spam-Check-By: sourceware.org
Received: from smtp3.epfl.ch (HELO smtp3.epfl.ch) (128.178.224.226)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 24 May 2011 17:48:55 +0000
Received: (qmail 28690 invoked by uid 107); 24 May 2011 17:48:51 -0000
Received: from dhcphost-ic216.utsc.utoronto.ca (HELO discarded) (142.1.102.216) (authenticated)  by smtp3.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPA; Tue, 24 May 2011 19:48:52 +0200
Message-ID: <4DDBEF83.8060004@cs.utoronto.ca>
Date: Tue, 24 May 2011 17:49:00 -0000
From: Ryan Johnson <ryan.johnson@cs.utoronto.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Improvements to fork handling (1/5)
References: <4DCAD5FB.9050508@cs.utoronto.ca> <20110522014135.GA18936@ednor.casa.cgf.cx> <4DD909E8.1050407@cs.utoronto.ca> <20110522202918.GC25762@ednor.casa.cgf.cx>
In-Reply-To: <20110522202918.GC25762@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00168.txt.bz2

On 22/05/2011 4:29 PM, Christopher Faylor wrote:
> On Sun, May 22, 2011 at 09:04:40AM -0400, Ryan Johnson wrote:
>> On 21/05/2011 9:41 PM, Christopher Faylor wrote:
>>> On Wed, May 11, 2011 at 02:31:23PM -0400, Ryan Johnson wrote:
>>>> Hi all,
>>>>
>>>> This is the first of a series of patches, sent in separate emails as
>>>> requested.
>>>>
>>>> The first patch allows a child which failed due to address space
>>>> clobbers to report cleanly back to the parent. As a result, DLL_LINK
>>>> which land wrong, DLL_LOAD whose space gets clobbered, and failure to
>>>> replicate the cygheap, generate retries and dispense with the terminal
>>>> spam. Handling of unexpected errors should not have changed. Further,
>>>> the patch fixes several sources of access violations and crashes,
>>>> including:
>>>> - accessing invalid state after failing to notice that a
>>>> statically-linked dll loaded at the wrong location
>>>> - accessing invalid state while running dtors on a failed forkee. I
>>>> follow cgf's approach of simply not running any dtors, based on the
>>>> observation that dlls in the parent (gcc_s!) can store state about other
>>>> dlls and crash trying to access that state in the child, even if they
>>>> appeared to map properly in both processes.
>>>> - attempting to generate a stack trace when somebody in the call chain
>>>> used alloca(). This one is only sidestepped here, because we eliminate
>>>> the access violations and api_fatal calls which would have triggered the
>>>> problematic stack traces. I have a separate patch which allows offending
>>>> functions to disable stack traces, if folks are interested, but it was
>>>> kind of noisy so I left it out for now (cygwin uses alloca pretty
>>>> liberally!).
>>>>
>>>> Ryan
>>>> diff --git a/child_info.h b/child_info.h
>>>> --- a/child_info.h
>>>> +++ b/child_info.h
>>>> @@ -92,6 +92,18 @@ public:
>>>>     void alloc_stack_hard_way (volatile char *);
>>>> };
>>>>
>>>> +/* Several well-known problems can prevent us from patching up a
>>>> +   forkee; when such errors arise the child should exit cleanly (with
>>>> +   a failure code for the parent) rather than dumping stack.  */
>>>> +#define fork_api_fatal(fmt, args...)					\
>>>> +  do									\
>>>> +    {									\
>>>> +      sigproc_printf (fmt,## args);					\
>>>> +      fork_info->handle_failure (-1);					\
>>>> +    }									\
>>>> +  while(0)
>>>> +
>>>> +
>>>> class fhandler_base;
>>>>
>>>> class cygheap_exec_info
>>>> diff --git a/dll_init.cc b/dll_init.cc
>>>> --- a/dll_init.cc
>>>> +++ b/dll_init.cc
>>>> @@ -19,6 +19,7 @@ details. */
>>>> #include "dtable.h"
>>>> #include "cygheap.h"
>>>> #include "pinfo.h"
>>>> +#include "child_info.h"
>>>> #include "cygtls.h"
>>>> #include "exception.h"
>>>> #include<wchar.h>
>>>> @@ -131,10 +132,16 @@ dll_list::alloc (HINSTANCE h, per_proces
>>>>       {
>>>>         if (!in_forkee)
>>>> 	d->count++;	/* Yes.  Bump the usage count. */
>>>> +      else if (d->handle != h)
>>>> +	fork_api_fatal ("Location of %W changed from %p (parent) to %p (child)",
>>>> +			d->name, d->handle, h);
>>> You seem to be guranteeing a failure in a condition which could conceivably work
>>> ok for simple applications, i.e., if a dll loads in a different location that
>>> is not necessarily going to cause a problem.
>> By fork semantics the condition *is* a failure. If we try to relax the
>> requirement we risk Bad Things happening, usually in hard-to-diagnose
>> ways. The example I have right off is libgcc_s storing pointers to other
>> dlls and seg faulting when it tries to access pointers which were valid
>> in the parent but not in the child. I prefer a fail-fast solution over
>> cross-fingers-and-hope-it-doesn't-happen-to-me.
> When you add a failure case like this you are assuming that you
> understand all of the parameters and that it will make things better.  I
> am not convinced that this won't cause previously working cases to fail.
>
> It is not inconceivable that a DLL could be relocated into another
> location and continue to work in a forked process.  Yes, I know this
> doesn't match the way fork is supposed to work but I'm not as concerned
> about that as I am about Cygwin mailing list complaints about new
> failures.
WJM?

> The reason I'm objecting to this is because I've considered, from time
> to time, adding a similar test but have always avoided it because I
> couldn't convince myself that it would help more than it would hurt.  If
> we are going to add tests, I'd prefer that the testing be done in
> frok:parent when the child_copy happens for static and dynamic dlls,
> maybe by adding a dll function which first checks that the data/bss can
> be copied to the same location as the parent.
Maybe the new way you mentioned you're working on obviates the above, but:

1. We won't necessarily get as far as frok::parent. Both the above check 
and the access violations it avoids usually happen before cygwin1.dll 
initializes.

2. Because it runs before child_copy, the above check triggers a retry 
on failure and the overall fork can still succeed.

3. Any additional failures due to the above check would be just as 
intermittent as what happens now. It's not like some app would suddenly 
and systematically refuse to fork with this patch in place. At worst 
fork failures might become somewhat more frequent. Caveat: sometimes the 
parent's address space layout is especially hostile and fork does seem 
to fail systematically. However, this happens to me either way and can 
be fixed by restarting the offending process.

4. My experiments suggest that most access violations during fork arise 
precisely because dlls move, and moved dlls usually cause access 
violations. Those already generate noise on the list (emacs, anyone?), 
and the above fix would make that noise either disappear (successful 
retry) or merge with the usual gripes about "fork failed: resource 
temporarily unavailable" where it belongs.

5. Not performing the above check can cause forked programs to 
mysteriously fail at some later point after the fork appears to succeed. 
Given that we have at least one known example (cyggcc_s) I would argue 
that forks gone bad contribute to user frustration but do not generate 
mailing list traffic because it looks like an intermittent and 
non-reproducible problem with the user's code. WJM?

Ryan
