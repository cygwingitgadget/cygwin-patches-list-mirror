From: Robert Collins <robert.collins@itdomain.com.au>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: PTHREAD_COND_INITIALIZER
Date: Tue, 25 Sep 2001 04:42:00 -0000
Message-id: <1001418247.1825.69.camel@lifelesswks>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F1C6@itdomain002.itdomain.net.au> <342526142.20010925114613@logos-m.ru> <1001414378.1761.45.camel@lifelesswks> <11811589024.20010925151026@logos-m.ru>
X-SW-Source: 2001-q3/msg00198.html

On Tue, 2001-09-25 at 21:10, egor duda wrote:
> Hi!
> 
> Tuesday, 25 September, 2001 Robert Collins robert.collins@itdomain.com.au wrote:
> 
> >> RC> Yes. Null is returned by calloc(), so users may unintentionally submit
> >> RC> PTHREAD_COND_INITIALIZER when there is actually a bug in their program.
> >> RC> Then they will wonder why their (say) shared memory stuff is compiling
> >> RC> but not working.
> >> 
> >> well, CreateEvent() too accepts NULL as last argument to create an
> >> anonymous event. as numerous other win32 functions do. Personally, i
> >> found this approach consistent. NULL is only pointer that's guaranteed
> >> to not point to valid object. Everything else is system-dependent.
> 
> RC> Firstly, we do not need to cater for all systems - just
> RC> win9x/Me/Nt/2K/XP in the 32-bit win32 subsystem.
> 
> this approach just adds more difficulties for whomever wanting to port
> cygwin to win64, alpha, ppc, etc. Those are solvable problems, of course,
> but i stand for not creating them in first place.

Sure. It's a tradeoff.

> RC> Secondly, there are common features in both core platforms. I refer you
> RC> to  http://support.microsoft.com/directory/article.asp?ID=KB;EN-US;Q125691
> RC> and http://msdn.microsoft.com/library/default.asp?url=/library/en-us/dngenlib/html/msdn_ntvmm.asp
> 
> RC> The combination indicate that an address between the 3 and 4 Gb limit
> RC> will _never_ be a valid userspace address. So as long as we test for
> RC> pointer equality in that range before checking for addressable memory,
> RC> we are _guaranteed_ safety.
> RC> Yes, the 0-4Mb space I used initially is not guaranteed safe under NT, I
> RC> acknowledge that and agree it should be fixed.
> 
> RC> However I still do not agree on NULL. Using a non-null value is
> RC> efectively free speed wise, and can help detect programmer errors. 
> 
> RC> The difference between the CreateEvent style API and the pthreads API is
> RC> that CreateEvent accepts and requires all the parameters to define event
> RC> behaviour. The NULL you refer to is _simply_ the name. You are not
> RC> allowed under teh CreateEvent to call SignalObjectAndWait (NULL, foo);
> RC> Under pthreads you are allowed to do that - IFF PTHREAD_COND_INITIALIZER
> RC> is used.
> 
> one shouldn't pass PTHREAD_*_INITIALIZERs as directly as parameters.
> SUSv2 says they can be used as initializers for static data.
> passing PTHREAD_COND_INITIALIZER directly to function is obvious
> memory leak.

Well they cannot be used in such a fashion anyway, that would return
EINVAL with either P_C_I==0 or P_C_I==invalid address. It's things like

pthread_cond_t foo = NULL;
...
if (y)
pthread_cond_init (foo, bar);
...
pthread_cond_wait(foo, del);

that using NULL allows for collision between uninited cond variable, and
accidental use of the static INITIALIZER. Use of the static INITIALIZER
should be a _deliberate_ action. NULL collides with that.

> RC> That difference being that the INITIALIZER is always the
> RC> default parameters. It's really a case of failing gracefully in the case
> RC> of programmer idiocy, EINVAL is better than Q:"hey it works on 95, but
> RC> not on NT" - why? A: on 95 you are getting NULL'd memory, but not on NT.
> RC> (for example).
> 
> and those idiots who don't check for NULL return from malloc won't
> check for EINVAL either.

Well they might do something like:
class queue 
...

queue::queue ()
{
cond_var = NULL; /* test for NULL in the submission functions, so we
init it before use */
}
...
foo = new queue;
...
_bug somewhere_ that results in pthread_cond_wait without testing for
NULL.

No malloc check needed.

> RC> I really don't see any benefit from using NULL in this instance, and I
> RC> do see benefits from not using NULL.
> 
> the benefit from using NULL is portability. I understand that cygwin
> is not supposed to that portable as, say, Apache, but nevertheless.
 
Ok, I'll accept that. So we use void *(-2), void * (-3) and so on -
address's so high up they can never be valid for pthread objects because
pthread objects are larger than the remaining address space.

> I'll check this stuff into cygwin testsuite tonight. it
> needs just minor cleanup currently.

You might want to check with cgf first about copyright issues? I don't
know - is the testsuite GPL compatible.

> RC> http://users.bigpond.net.au/PthreadTest-0.1.tar.gz

Doh!
http://users.bigpond.net.au/robertc/PthreadTest-0.1.tar.gz

Rob
