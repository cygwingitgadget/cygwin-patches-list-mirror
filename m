From: "Norman Vine" <nhv@cape.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>, "'Greg Smith'" <gsmith@nc.rr.com>, <Jason.Tishler@dothill.com>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: Deadly embrace between pthread_cond_wait and pthread_cond_signal
Date: Thu, 21 Jun 2001 12:29:00 -0000
Message-id: <002401c0fa86$74d12880$a300a8c0@nhv>
References: <01da01c0fa5f$1bfe6d70$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00324.html

THANK YOU GREG and ROB :-)))

I have not done exhaustive testing yet but..... 
It appears that with this patch 
Python threading WORKS !!

:-)))

Norman Vine

>-----Original Message-----
>From: cygwin-patches-owner@sources.redhat.com
>[ mailto:cygwin-patches-owner@sources.redhat.com]On Behalf Of Robert
>Collins
>Sent: Thursday, June 21, 2001 10:33 AM
>To: Greg Smith
>Cc: cygwin-patches@cygwin.com
>Subject: Re: Deadly embrace between pthread_cond_wait and
>pthread_cond_signal
>
>
>Correct a deadlock situation...
>Changelog:
>2001-06-22  Robert Collins  rbtcollins@hotmail.com
>
>    * thread.cc (__pthread_cond_timedwait): Lock the waiting mutex
>before the condition protect mutex to avoid deadlocking.
>    (__pthread_cond_wait): Ditto.
>
>
>Greg, as far as speed goes, there is a major optimisation I want to
>make, which is to make all process private mutex's critical sections,
>instead of system wide mutex's. This should be a lot faster... when I
>get that done :].
>
>Rob
>
>----- Original Message -----
>From: "Greg Smith" <gsmith@nc.rr.com>
>To: <cygwin@cygwin.com>
>Sent: Thursday, June 21, 2001 3:11 PM
>Subject: Deadly embrace between pthread_cond_wait and
>pthread_cond_signal
>
>
>> I am using the cygwin-src snapshot from June 19.
>>
>> Suppose I have a thread, t1, that looks like:
>> void *t1() {
>>    pthread_mutex_lock(&lock);
>>    pthread_cond_wait(&cond,&lock);
>>    pthread_mutex_unlock(&lock);
>> }
>> and a thread, t2, that looks like:
>> void *t2() {
>>    pthread_mutex_lock(&lock);
>>    pthread_cond_signal(&cond);
>>    sleep(1);
>>    pthread_cond_signal(&cond);
>>    pthread_mutex_unlock(&lock);
>> }
>>
>> When thread t1 wakes up as a result of the first pthread_cond_signal
>> issued by thread t2, __pthread_cond_wait in thread.cc 
>obtains internal
>> mutex `cond_access' then hangs trying to acquire external 
>mutex `lock'
>> which is owned by thread t2.
>>
>> When thread t2 issues the second pthread_cond_signal, still holding
>> external mutex `lock', pthread_cond::Signal in thread.cc tries to
>> get internal mutex `cond_access' and hangs because it is owned by t1.
>>
>> So, t1 has `cond_access' and is waiting on `lock'
>> and t2 has `lock' and is waiting on `cond_access'.
>>
>> As a workaround, I moved the pthread_mutex_lock for cond_access in
>> __pthread_cond_wait from before the (*cond)->mutex->Lock() to after
>> it, and my application has gotten a whole lot further than 
>ever before
>> using native cygwin pthreads, although it does seem to be running as
>> slow as molasses compared to linux.  But maybe that's cause of my
>> debug stuff I had to add.
>>
>> Thanks,
>>
>> Greg
>>
>> --
>> Want to unsubscribe from this list?
>> Check out: http://cygwin.com/ml/#unsubscribe-simple
>>
>>
>
