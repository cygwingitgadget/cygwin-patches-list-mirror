Return-Path: <cygwin-patches-return-2284-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30592 invoked by alias); 2 Jun 2002 05:43:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30578 invoked from network); 2 Jun 2002 05:43:44 -0000
Date: Sat, 01 Jun 2002 22:43:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtors run twice on dll detach (update)
Message-ID: <20020602054342.GA5509@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA7600C5F90@itdomain003.itdomain.net.au> <m33cxan017.fsf@benny-ppc.benny.crocodial.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33cxan017.fsf@benny-ppc.benny.crocodial.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00267.txt.bz2

On Thu, May 02, 2002 at 03:37:24PM +0200, Benjamin Riefenstahl wrote:
>"Robert Collins" <robert.collins@itdomain.com.au> writes:
>> > If we just avoid setting up the destructor calls using atexit 
>> > then the destructors will only run once.  So, in the normal 
>> > case, the destructor will run after much cleanup has occurred 
>> > in the cygwin DLL (specifically in the do_exit function).  
>> > This means that the destructor may not be able to use all of 
>> > the facilities of cygwin when it is finally executed.
>> 
>> Yup. That is why I don't think that the atexit call is obsolete.
>>  
>> > This won't be an issue for the problem below, but I wonder if 
>> > it is a problem for other destructors.  I'm not sure what 
>> > kind of environment a global destructor is guaranteed to have 
>> > but I suspect that it should be a completely normal environment.
>> > 
>> > Anyone know for sure?  Is there an online reference for this 
>> > kind of thing?
>> 
>> It'll be in the C++ standard, which is proprietary :[. Anyone here have
>> the standard and care to check for us?
>
>C++ 98 in one spot (3.6.3 Termination, para 3) says that atexit()
>functions are called before destructors for objects created before
>registration of the atexit() functions and after destruction of
>objects created after registration.  IOW the order is as if destructor
>calls are implemented as atexit() functions.
>
>Later in the description of exit() (18.3 Start and Termination, para
>8) this is repeated.  Actions of exit() are defined to be in this
>order:
>
>- atexit() functions and destructor calls.
>
>- Flushing C streams. 
>
>- Return to OS with exit code. 
>
>Except for the addition of destructor calls, this is the same
>definition as in the C standard, judging from my copy of the last C9x
>draft.

I never thanked you for providing this information.  THANK YOU.

I finally got around to fixing this problem tonight.  I wanted to get
it into 1.3.11.

It should be in the next snapshot.

Although I didn't use the method in the patch, I do appreciate the amount
of work that went into tracking down the problem.  I think that my fix
will be a little less intrusive but it would have taken me very much
longer to figure out what was going on without the use of the patch.

Thanks,
cgf
