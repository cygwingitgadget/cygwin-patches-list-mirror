From: Christopher Faylor <cgf@redhat.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: pthreads update for the adventurous
Date: Fri, 13 Apr 2001 23:54:00 -0000
Message-id: <20010414025511.A9478@redhat.com>
References: <8D00C32549556B4E977F81DBC24E985DC80C@crtsmail1.technol_exch.corp.riotinto.org> <04e501c0c475$3d059e50$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00061.html

Go ahead and check this in, Robert.  However, please add a blank line
after the first ChangeLog entry and pay close attention to the
formatting of that first line.  One of two formats are acceptable.
You've invented a third.  Please just use the format that use see
elsewhere in the ChangeLog.

cgf

On Sat, Apr 14, 2001 at 09:55:35AM +1000, Robert Collins wrote:
>Thanks for the report David. That bugs been in cygwin's pthread support
>forever - but it's gone now. (Cross fingers)
>
>If you apply the attached patch to your CVS working directory and make a
>new cygwin1.dll the test should pass.
>
>Otherwise, you can wait for the next snapshot.
>
>Chris: I hope the changelog and patch are ok..
>
>==
>Saturday Apr 14 2001  Robert Collins <rbtcollins@hotmail.com>
> * thread.h (MTinterface): Add threadcount.
> * thread.cc (MTinterface::Init): Set threadcount to 1.
> (__pthread_create): Increment threadcount.
> (__pthread_exit): Decrement threadcount and call exit() from the last
>thread.
>==
>
>Rob
>
>----- Original Message -----
>From: "Billinghurst, David (CRTS)" <David.Billinghurst@riotinto.com>
>To: <cygwin@cygwin.com>
>Sent: Friday, April 13, 2001 10:55 PM
>Subject: RE: pthreads update for the adventurous
>
>
>> OK.  I'll bite.
>>
>> I have built cygwin1.dll from cvs, then proceeded to build and test
>gcc-3.0
>> with --enable-threads=posix.  This seems to work OK.
>>
>> I then tried example 1 from
>>
> http://www.llnl.gov/computing/tutorials/workshops/workshop/pthreads/MAIN
>.htm
>> l (below) using standard cygwin gcc-2.95.3-2 and the gcc-3.0 I built.
>There
>> appears to be a problem with pthread_exit() as the program never
>exits.  I
>> tried to debug this, but soon got lost.
>>
>>
>>
>>
>/***********************************************************************
>****
>> ***
>> * FILE: hello.c
>> * DESCRIPTION:
>> *   A "hello world" Pthreads program.  Demonstrates thread creation
>and
>> *   termination.
>> *
>> * SOURCE:
>> * LAST REVISED: 9/20/98 Blaise Barney
>>
>************************************************************************
>****
>> **/
>>
>> #include <pthread.h>
>> #include <stdio.h>
>> #define NUM_THREADS 5
>>
>> void *PrintHello(void *threadid)
>> {
>>    printf("\n%d: Hello World!\n", threadid);
>>    pthread_exit(NULL);
>> }
>>
>> int main()
>> {
>>    pthread_t threads[NUM_THREADS];
>>    int rc, t;
>>    for(t=0;t<NUM_THREADS;t++){
>>       printf("Creating thread %d\n", t);
>>       rc = pthread_create(&threads[t], NULL, PrintHello, (void *)t);
>>       if (rc){
>>          printf("ERROR; return code from pthread_create() is %d\n",
>rc);
>>          exit(-1);
>>       }
>>    }
>>    pthread_exit(NULL);
>> }
>>
>>
>> --
>> Want to unsubscribe from this list?
>> Check out: http://cygwin.com/ml/#unsubscribe-simple
>>
>>



>--
>Want to unsubscribe from this list?
>Check out: http://cygwin.com/ml/#unsubscribe-simple

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
