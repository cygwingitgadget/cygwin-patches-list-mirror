From: egor duda <deo@logos-m.ru>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Subject: Re: PTHREAD_COND_INITIALIZER
Date: Mon, 24 Sep 2001 23:55:00 -0000
Message-id: <14745625265.20010925105325@logos-m.ru>
References: <19733505618.20010924193924@logos-m.ru> <0f4701c14544$8d21cda0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q3/msg00193.html

Hi!

Tuesday, 25 September, 2001 Robert Collins robert.collins@itdomain.com.au wrote:

RC> Hi Egor,
RC> Thanks for that.

RC> It's not quite right yet though....
RC> In pthread.h,
RC> * PTHREAD_COND_INITIALIZER must be a never valid address, that is
RC> unlikely to occur randomly - 0 won't work. (See
RC> PTHREAD_MUTEX_INITIALIZER).

why? SUSv2 doesn't tell anything about PTHREAD_COND_INITIALIZER's
validity as pointer. Are there any particular reasons for not making
it NULL?

RC> * I'm still not sure of the appropriateness of the clean_up routine
RC> typedef change,

see pthread_cleanup_push() prototype in SUSv2. it reads:

void pthread_cleanup_push(void (*routine)(void*), void *arg);

current macro won't compile if called from application this way.

RC> it should go in as a separate patch regardless.

RC> In thread.cc, you have introduced many deference potential invalid
RC> memory issues.  No dereferencing of * parameters should occur until a
RC> verifyable_object_isvalid () call is made on them. As you can see that
RC> function checks for address space allocation and for the INITIALIZER
RC> macro's, and for the correct contect according to a magic cookie.

RC> ie this is bad:
RC> + if (*cond != PTHREAD_COND_INITIALIZER &&
RC> + verifyable_object_isvalid (*cond, PTHREAD_COND_MAGIC))
RC> return EBUSY;

only one, actually. *cond is called unchecked only in
__pthread_cond_init(), and i'll fix that. Other functions call
__pthread_cond_construct, which, in turn, check if cond is a valid
pointer. Maybe __pthread_cond_construct() is misleading name as in
do both verification and construction of condvar object, and i open
for suggestions about better name.

RC> whereas adding PTHREAD_COND_INITIALIZER to verifyable_object_isvalid
RC> won't introduce this issue.

RC> pthread_cond_construct is a (to me) unneeded function, thats what the
RC> object constructor is for. Finally reusing the verifyyobject call will
RC> result in less os overhead (in calls to IsBadWritePtr).

btw, i don't like making PTHREAD_MUTEX_INITIALIZER to be (void*) 20.
it's not guaranteed by anybody that this memory area won't be
accessible. by using (void*) 20 we add yet another dependency on
undocumented (though always working, for now) system feature. Cygwin
has a plenty of them already, no need to add one more where it's not
needed.

RC> Can I suggest you look at the implementation of
RC> PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER should be nearly
RC> identical.
RC> (ie the new code in each function is only two lines:

that's reasonable. i think that "PTHREAD_*_INITIALIZER"s are better
made to be NULL.

RC> And finally, can you create a simple (able to be included in my GPL'd
RC> pthread test suite) testcase to test the COND_INITIALIZER?

do you have one? would you mind including it in cygwin testsuite in
CVS?

RC> If you have  the time to create boundary tests as well, that's even better, but a
RC> core test is needed IMO. I'll run the whole suite for regression
RC> checking (unless you want to :} ).

i'm porting testsuite from pthreads-win32 to cygwin and want to add it
to current cygwin testsuite.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
