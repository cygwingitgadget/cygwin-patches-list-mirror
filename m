From: egor duda <deo@logos-m.ru>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: cygwin-patches@cygwin.com
Subject: Re: PTHREAD_COND_INITIALIZER
Date: Tue, 25 Sep 2001 00:46:00 -0000
Message-id: <342526142.20010925114613@logos-m.ru>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1C6@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00195.html

Hi!

Tuesday, 25 September, 2001 Robert Collins robert.collins@itdomain.com.au wrote:

>> why? SUSv2 doesn't tell anything about PTHREAD_COND_INITIALIZER's
>> validity as pointer. Are there any particular reasons for not making
>> it NULL?

RC> Yes. Null is returned by calloc(), so users may unintentionally submit
RC> PTHREAD_COND_INITIALIZER when there is actually a bug in their program.
RC> Then they will wonder why their (say) shared memory stuff is compiling
RC> but not working.

well, CreateEvent() too accepts NULL as last argument to create an
anonymous event. as numerous other win32 functions do. Personally, i
found this approach consistent. NULL is only pointer that's guaranteed
to not point to valid object. Everything else is system-dependent.

>> RC> * I'm still not sure of the appropriateness of the
>> clean_up routine typedef change,
>> 
>> see pthread_cleanup_push() prototype in SUSv2. it reads:
>> 
>> void pthread_cleanup_push(void (*routine)(void*), void *arg);
>> 
>> current macro won't compile if called from application this way.

RC> Ah, ok, I'll check that fix in tonight then.

please, fix this too:

 __pthread_mutexattr_gettype (const pthread_mutexattr_t *attr, int *type)
 {
-  if (!verifyable_object_isvalid (*attr, PTHREAD_MUTEX_MAGIC))
+  if (!verifyable_object_isvalid (*attr, PTHREAD_MUTEXATTR_MAGIC))
     return EINVAL;
   *type = (*attr)->mutextype;

>> RC> whereas adding PTHREAD_COND_INITIALIZER to verifyable_object_isvalid
>> RC> won't introduce this issue.
>> 
>> RC> pthread_cond_construct is a (to me) unneeded function, 
>> thats what the
>> RC> object constructor is for. Finally reusing the 
>> verifyyobject call will
>> RC> result in less os overhead (in calls to IsBadWritePtr).
>> 
>> btw, i don't like making PTHREAD_MUTEX_INITIALIZER to be (void*) 20.
>> it's not guaranteed by anybody that this memory area won't be
>> accessible. by using (void*) 20 we add yet another dependency on
>> undocumented (though always working, for now) system feature. Cygwin
>> has a plenty of them already, no need to add one more where it's not
>> needed.

RC> Actually I think it is guaranteed on both 9x and NT according to MSDN
RC> doco on memory regions. I researched that before choosing it.

On Alpha too? and on PowerPC? and on next version of windows? I'm not
so sure. The example of Microsoft's own APIs that use NULL as "empty"
data, shows that they don't rely on validity of pointers such as
'(void*) 20'. There's only one example, and i stumbled over that
several times (as probably many others did) is INVALID_HANDLE_VALUE ==
0xffffffff, which is returned by CreateFile().

Microsoft may tell that 0x0000-0x4095 region is generally invalid, but
i've never seen they guaranteeing that.

>> RC> Can I suggest you look at the implementation of
>> RC> PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER 
>> should be nearly
>> RC> identical.
>> RC> (ie the new code in each function is only two lines:
>> 
>> that's reasonable. i think that "PTHREAD_*_INITIALIZER"s are better
>> made to be NULL.
>> 
>> RC> And finally, can you create a simple (able to be included 
>> in my GPL'd
>> RC> pthread test suite) testcase to test the COND_INITIALIZER?
>> 
>> do you have one? would you mind including it in cygwin testsuite in
>> CVS?

RC> I have a test case for every bug I've fixed :]. More than happy for it
RC> to go into CVS, though I am maintaining it as a separate package (and
RC> will continue to do so).

>> RC> If you have  the time to create boundary tests as well, 
>> that's even better, but a
>> RC> core test is needed IMO. I'll run the whole suite for regression
>> RC> checking (unless you want to :} ).
>> 
>> i'm porting testsuite from pthreads-win32 to cygwin and want to add it
>> to current cygwin testsuite.

RC> I have some of those tests ported too :]. Many of them are very
RC> pthreads-win32 internals specific though.

not too many, actually. a bunch of them do include "internal.h" but
doesn't use if for testing itself, but only for diagnostic output.

RC>  Can I suggest we split this up so as not to duplicate effort? My
RC> testsuite is available from my home page (I mailed the url to the
RC> list a few days ago IIRC. Anyway I can mail that url to you when I
RC> get home)..

i'll take a look.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
