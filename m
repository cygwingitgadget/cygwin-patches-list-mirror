From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "egor duda" <cygwin-patches@cygwin.com>
Subject: RE: PTHREAD_COND_INITIALIZER
Date: Tue, 25 Sep 2001 00:01:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1C6@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00194.html

Sorry, this mail is a little rushed, I was just leaving the office..

> -----Original Message-----
> From: egor duda [ mailto:deo@logos-m.ru ]
> Sent: Tuesday, September 25, 2001 4:53 PM
> To: Robert Collins
> Cc: cygwin-patches@cygwin.com
> Subject: Re: PTHREAD_COND_INITIALIZER
> 
> 
> Hi!
> 
> Tuesday, 25 September, 2001 Robert Collins 
> robert.collins@itdomain.com.au wrote:
> 
> RC> Hi Egor,
> RC> Thanks for that.
> 
> RC> It's not quite right yet though....
> RC> In pthread.h,
> RC> * PTHREAD_COND_INITIALIZER must be a never valid address, that is
> RC> unlikely to occur randomly - 0 won't work. (See
> RC> PTHREAD_MUTEX_INITIALIZER).
> 
> why? SUSv2 doesn't tell anything about PTHREAD_COND_INITIALIZER's
> validity as pointer. Are there any particular reasons for not making
> it NULL?

Yes. Null is returned by calloc(), so users may unintentionally submit
PTHREAD_COND_INITIALIZER when there is actually a bug in their program.
Then they will wonder why their (say) shared memory stuff is compiling
but not working.

> RC> * I'm still not sure of the appropriateness of the 
> clean_up routine
> RC> typedef change,
> 
> see pthread_cleanup_push() prototype in SUSv2. it reads:
> 
> void pthread_cleanup_push(void (*routine)(void*), void *arg);
> 
> current macro won't compile if called from application this way.

Ah, ok, I'll check that fix in tonight then.

> RC> it should go in as a separate patch regardless.
> 
> RC> In thread.cc, you have introduced many deference potential invalid
> RC> memory issues.  No dereferencing of * parameters should 
> occur until a
> RC> verifyable_object_isvalid () call is made on them. As you 
> can see that
> RC> function checks for address space allocation and for the 
> INITIALIZER
> RC> macro's, and for the correct contect according to a magic cookie.
> 
> RC> ie this is bad:
> RC> + if (*cond != PTHREAD_COND_INITIALIZER &&
> RC> + verifyable_object_isvalid (*cond, PTHREAD_COND_MAGIC))
> RC> return EBUSY;
> 
> only one, actually. *cond is called unchecked only in
> __pthread_cond_init(), and i'll fix that. Other functions call
> __pthread_cond_construct, which, in turn, check if cond is a valid
> pointer. Maybe __pthread_cond_construct() is misleading name as in
> do both verification and construction of condvar object, and i open
> for suggestions about better name.
> 
> RC> whereas adding PTHREAD_COND_INITIALIZER to 
> verifyable_object_isvalid
> RC> won't introduce this issue.
> 
> RC> pthread_cond_construct is a (to me) unneeded function, 
> thats what the
> RC> object constructor is for. Finally reusing the 
> verifyyobject call will
> RC> result in less os overhead (in calls to IsBadWritePtr).
> 
> btw, i don't like making PTHREAD_MUTEX_INITIALIZER to be (void*) 20.
> it's not guaranteed by anybody that this memory area won't be
> accessible. by using (void*) 20 we add yet another dependency on
> undocumented (though always working, for now) system feature. Cygwin
> has a plenty of them already, no need to add one more where it's not
> needed.

Actually I think it is guaranteed on both 9x and NT according to MSDN
doco on memory regions. I researched that before choosing it.

> RC> Can I suggest you look at the implementation of
> RC> PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER 
> should be nearly
> RC> identical.
> RC> (ie the new code in each function is only two lines:
> 
> that's reasonable. i think that "PTHREAD_*_INITIALIZER"s are better
> made to be NULL.
> 
> RC> And finally, can you create a simple (able to be included 
> in my GPL'd
> RC> pthread test suite) testcase to test the COND_INITIALIZER?
> 
> do you have one? would you mind including it in cygwin testsuite in
> CVS?

I have a test case for every bug I've fixed :]. More than happy for it
to go into CVS, though I am maintaining it as a separate package (and
will continue to do so).

> RC> If you have  the time to create boundary tests as well, 
> that's even better, but a
> RC> core test is needed IMO. I'll run the whole suite for regression
> RC> checking (unless you want to :} ).
> 
> i'm porting testsuite from pthreads-win32 to cygwin and want to add it
> to current cygwin testsuite.

I have some of those tests ported too :]. Many of them are very
pthreads-win32 internals specific though. Can I suggest we split this up
so as not to duplicate effort? My testsuite is available from my home
page (I mailed the url to the list a few days ago IIRC. Anyway I can
mail that url to you when I get home)..

Rob
