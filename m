From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: FW: sched* functions, pthread rework
Date: Tue, 20 Mar 2001 17:20:00 -0000
Message-id: <20010320202038.C1778@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF02E270@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q1/msg00216.html

Robert,
The formatting on this ChangeLog is really messed up.  Is there some
reason why you sent it as if it was a reply to a previous message?
I can see that you sent this to "ezmlm" (?) but I don't know why
that reformatted your ChangeLog.

There were a few other problems.

Case/Sentences:
	* sched.cc: new file, implements sched*

Should be something like:
	* sched.cc: New file.  Implements sched_* functions.

Leading comma?
	* include/sched.h: , new file, user land includes for sched*

Should be:
	* include/sched.h: New file.  User-land includes for sched*.

Incorrect tense:
	* cygwin.din: added exports for sched*
	* pthread.cc: ran indent.  Also added pthread_attrset/get detachstate.

Should be:
	* cygwin.din: Add exports for sched*.
	* pthread.cc: Fix indendentation.  Add pthread_attrset/get detachstate.

This:
	* thread.cc: full rewrite of core logic.  MTitem class removed, new
	classes for each pthread_ type.  Added pthread_attr_setdetachstate &

Should be something like:

	* thread.cc: Rewrite core logic.
	(MTItem): Remove.
	(Blah): New class.
	(Foo): New class.

Also, please don't group disparate patches together.  One patch at a
time, please.

Could you resubmit this with updated ChangeLog entries, and as two
separate patches so that it will be easier to track if there are
comments or questions?

cgf

On Wed, Mar 21, 2001 at 11:48:35AM +1100, Robert Collins wrote:
>Doh! sent it to ezmlm
>> -----Original Message-----
>> From: Robert Collins 
>> Sent: Wednesday, March 21, 2001 11:15 AM
>> To:
>> cygwin-patches-sc.985034813.hnjamfflckgaejhnpmeo-robert.collin
>> s=itdomain
>> .com.au@sources.redhat.com
>> Subject: sched* functions, pthread rework
>> 
>> 
>> Ok here's round one of a full overhaul of the pthreads code.
>> 
>> This appears fully stable to me. Rather than emulating some 
>> of the win32
>> features (such as using an array to store the thread list) this simply
>> utilises win32 for most of the functionality needed. I've 
>> replaced a lot
>> of the Macro'd one liners (about 6 lines er macro) with two 
>> line tests,
>> which has aided my debugging unbelievable.
>> 
>> For clarity: the sched* functions are not thread related and should be
>> in cygwin1.dll even when it's built non threaded..
>> 
>> New files: sched.cc, include/semaphore.h, include/sched.h
>> 
>> There are still 6 FIXME's in the code: 3 are notes for adding optional
>> features, 2 are from before my time and I'll look into them shortly. 1
>> is because I haven't implemented the pthread_key_* destructor 
>> logic yet.
>> I'll be doing that shortly... but now was a good point to the core of
>> the work into CVS (it's nice and stable :] ).
>> 
>> Next on the hit list are the pthread_cleanup* functions and 
>> the pthread_
>> fork related functions.
>> 
>> Changelog:
>> 21 Mar 2001 Robert Collins <rbtcollins@hotmail.com>
>>     * sched.cc: new file, implements sched*
>>     * include/sched.h: , new file, user land includes for sched*
>>     * Makefile.in: added sched.o
>>     * cygwin.din: added exports for sched*
>>     * pinfo.h: reference pthread instead of class ThreadItem
>>     * include.pthread.h typedef pthread_*_t as void * not 
>> int. Also add
>> some posix defines.
>>     * pthread.cc: ran indent. Also added pthread_attrset/get
>> detachstate.
>>     * thread.cc: full rewrite of core logic. MTitem class removed, new
>> classes for each pthread_ type.
>>                         Added pthread_attr_setdetachstate &
>> pthread_attr_getdetachstate.
>>                         fixed pthread_exit and return logic.
>>     * thread.h: removed MTitem class, simplified MTinterface, 
>> added new
>> classes for each pthread_* type.
>> 
>> 
>> Rob
>> 






-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
