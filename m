From: Robert Collins <robert.collins@itdomain.com.au>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: PTHREAD_COND_INITIALIZER
Date: Tue, 25 Sep 2001 03:38:00 -0000
Message-id: <1001414378.1761.45.camel@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1C6@itdomain002.itdomain.net.au> <342526142.20010925114613@logos-m.ru>
X-SW-Source: 2001-q3/msg00196.html

On Tue, 2001-09-25 at 17:46, egor duda wrote:
> Hi!
> 
> Tuesday, 25 September, 2001 Robert Collins robert.collins@itdomain.com.au wrote:
> 
> >> why? SUSv2 doesn't tell anything about PTHREAD_COND_INITIALIZER's
> >> validity as pointer. Are there any particular reasons for not making
> >> it NULL?

Also, note that IEEE and SUSv2 make no claims about the type of
pthread_cond_t. It's opaque. I happen to be using pointers because that
allows incremental improvements and occasional size changes of the
cygwin internal data without breaking user space linkage. Thus the
ability to detect PTHREAD_COND_FOO is the only SUSv2 requirement.

> RC> Yes. Null is returned by calloc(), so users may unintentionally submit
> RC> PTHREAD_COND_INITIALIZER when there is actually a bug in their program.
> RC> Then they will wonder why their (say) shared memory stuff is compiling
> RC> but not working.
> 
> well, CreateEvent() too accepts NULL as last argument to create an
> anonymous event. as numerous other win32 functions do. Personally, i
> found this approach consistent. NULL is only pointer that's guaranteed
> to not point to valid object. Everything else is system-dependent.

Firstly, we do not need to cater for all systems - just
win9x/Me/Nt/2K/XP in the 32-bit win32 subsystem.

Secondly, there are common features in both core platforms. I refer you
to 
http://support.microsoft.com/directory/article.asp?ID=KB;EN-US;Q125691
and
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dngenlib/html/msdn_ntvmm.asp

The combination indicate that an address between the 3 and 4 Gb limit
will _never_ be a valid userspace address. So as long as we test for
pointer equality in that range before checking for addressable memory,
we are _guaranteed_ safety.
Yes, the 0-4Mb space I used initially is not guaranteed safe under NT, I
acknowledge that and agree it should be fixed.

However I still do not agree on NULL. Using a non-null value is
efectively free speed wise, and can help detect programmer errors. 

The difference between the CreateEvent style API and the pthreads API is
that CreateEvent accepts and requires all the parameters to define event
behaviour. The NULL you refer to is _simply_ the name. You are not
allowed under teh CreateEvent to call SignalObjectAndWait (NULL, foo);
Under pthreads you are allowed to do that - IFF PTHREAD_COND_INITIALIZER
is used. That difference being that the INITIALIZER is always the
default parameters. It's really a case of failing gracefully in the case
of programmer idiocy, EINVAL is better than Q:"hey it works on 95, but
not on NT" - why? A: on 95 you are getting NULL'd memory, but not on NT.
(for example).

I really don't see any benefit from using NULL in this instance, and I
do see benefits from not using NULL.

> >> RC> * I'm still not sure of the appropriateness of the
> >> clean_up routine typedef change,
> >> 
> >> see pthread_cleanup_push() prototype in SUSv2. it reads:
> >> 
> >> void pthread_cleanup_push(void (*routine)(void*), void *arg);
> >> 
> >> current macro won't compile if called from application this way.
> 
> RC> Ah, ok, I'll check that fix in tonight then.
> 
> please, fix this too:
> 
>  __pthread_mutexattr_gettype (const pthread_mutexattr_t *attr, int *type)
>  {
> -  if (!verifyable_object_isvalid (*attr, PTHREAD_MUTEX_MAGIC))
> +  if (!verifyable_object_isvalid (*attr, PTHREAD_MUTEXATTR_MAGIC))
>      return EINVAL;
>    *type = (*attr)->mutextype;

Thanks. There were a bunch like that that I've corrected. I also noticed
that I'm equally guilty of potentially crashing on invalid parameters.
I've adjusted verifyable_object_isvalid to account for that, and am
testing now.

There is a bunch of code that can be improved, and a similar call
pattern to your cond_construct has arisen when I reviewed the
mutex_initializer. I still think that function is ancilliary though.

> RC> Actually I think it is guaranteed on both 9x and NT according to MSDN
> RC> doco on memory regions. I researched that before choosing it.
> 
> On Alpha too? and on PowerPC? and on next version of windows? I'm not
> so sure. The example of Microsoft's own APIs that use NULL as "empty"
> data, shows that they don't rely on validity of pointers such as
> '(void*) 20'. There's only one example, and i stumbled over that
> several times (as probably many others did) is INVALID_HANDLE_VALUE ==
> 0xffffffff, which is returned by CreateFile().
> 
> Microsoft may tell that 0x0000-0x4095 region is generally invalid, but
> i've never seen they guaranteeing that.

See above. As for Alpha, and PowerPC, when someone ports cygwin to those
platforms, I'll happily spend the time to research the virtual address
space rules for them.

> RC> I have some of those tests ported too :]. Many of them are very
> RC> pthreads-win32 internals specific though.
> 
> not too many, actually. a bunch of them do include "internal.h" but
> doesn't use if for testing itself, but only for diagnostic output.

Yes, and the internals are what they are debugging :]. *shrug*.
 
> RC>  Can I suggest we split this up so as not to duplicate effort? My
> RC> testsuite is available from my home page (I mailed the url to the
> RC> list a few days ago IIRC. Anyway I can mail that url to you when I
> RC> get home)..
> 
> i'll take a look.

http://users.bigpond.net.au/PthreadTest-0.1.tar.gz

This doesn't have any of the win32 pthreads tests in it - I've kept that
partitioned for now (so that essentially everything in that test suite
is under my copyright).

Rob
