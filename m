From: egor duda <deo@logos-m.ru>
To: Earnie Boyd <earnie_boyd@yahoo.com>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>, MinGW Dvlpr <mingw-dvlpr@lists.sourceforge.net>
Subject: Re: [Fwd: w32api and gcc -pedantic]]
Date: Mon, 16 Apr 2001 07:26:00 -0000
Message-id: <116167418985.20010416182520@logos-m.ru>
References: <3ADAF2AA.2AE1A652@yahoo.com>
X-SW-Source: 2001-q2/msg00074.html

Hi!

Monday, 16 April, 2001 Earnie Boyd earnie_boyd@yahoo.com wrote:

EB> Unless someone can give me a reasonable counter to Danny's reply below,
EB> I'm not accepting this patch.

EB> Earnie.

EB> -------- Original Message --------
EB> Subject: Re: [MinGW-dvlpr] [Fwd: w32api and gcc -pedantic]
EB> Date: Sat, 14 Apr 2001 07:30:01 +1000 (EST)
EB> From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
EB> Reply-To: mingw-dvlpr@lists.sourceforge.net
EB> To: mingw-dvlpr@lists.sourceforge.net


EB> --- Earnie Boyd <earnie_boyd@yahoo.com> wrote: > What do others
EB> (especially
EB> Danny) on this list think of this patch?
>> 
>> Earnie.
>> 
>> -------- Original Message --------
>> Subject: w32api and gcc -pedantic
>> Date: Fri, 13 Apr 2001 23:10:57 +0400
>> From: egor duda <deo@logos-m.ru>
>> Reply-To: egor duda <cygwin-patches@cygwin.com>
>> Organization: deo
>> To: cygwin-patches@cygwin.com
>> 
>> Hi!
>> 
>>   w32api headers currently contain a number of anonymous structs and
>> unions. So, gcc prints a bunch of warnings when invoked with -pedantic
>> on program which #include <windows.h>. this patch is to avoid those
>> warnings.

EB> My reading of C99 standard (section 6.7.2.1) is that nameless
EB> unions/structures
EB> are now part of standard.  The fix should go into GCC not the mingw
EB> headers. 
EB> GCC -pedantic -std=iso9899:199x should not raise warnings about unnamed
EB> structures; GCC -pedantic -std=iso9899:199409 should.

EB> I think the warnings should stay for now, since they are extensions to
EB> the currently supported standard.


Warnings should stay as long as we talk about user's code. But when it
comes to system header files, i believe (and my reading of various
existing standard headers make me believe so) that we should work
around such warnings. For example, many standard headers contain
fragments like this one:

#if defined(__STDC__) || defined(__cplusplus)
#define SIG_DFL ((void (*)(int))0)
#define SIG_IGN ((void (*)(int))1)
#define SIG_ERR ((void (*)(int))-1)
#else
#define SIG_DFL ((void (*)())0)
#define SIG_IGN ((void (*)())1)
#define SIG_ERR ((void (*)())-1)
#endif

so, it doesn't matter if we use compiler (or compile-time switch for
compiler) that doesn't support some feature or fires a warning seeing
it -- standard headers will compile cleanly.

if running gcc with '-pedantic' define some macro that could be tested
in standard headers, we could use it. But, afaik, it doesn't define
anything like it. Instead, gcc info recommends marking such code fragments
explicitly as '__extension__'.

My point is: standard headers shouldn't produce warnings whether you
compile them with new version of compiler or old one. It should matter for
user's code not for standard headers. 

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

