From: Christopher Faylor <cgf@redhat.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [Fwd: w32api and gcc -pedantic]]
Date: Mon, 16 Apr 2001 08:12:00 -0000
Message-id: <20010416111311.C15438@redhat.com>
References: <3ADAF2AA.2AE1A652@yahoo.com> <116167418985.20010416182520@logos-m.ru>
X-SW-Source: 2001-q2/msg00075.html

On Mon, Apr 16, 2001 at 06:25:20PM +0400, egor duda wrote:
>Warnings should stay as long as we talk about user's code. But when it
>comes to system header files, i believe (and my reading of various
>existing standard headers make me believe so) that we should work
>around such warnings. For example, many standard headers contain
>fragments like this one:
>
>#if defined(__STDC__) || defined(__cplusplus)
>#define SIG_DFL ((void (*)(int))0)
>#define SIG_IGN ((void (*)(int))1)
>#define SIG_ERR ((void (*)(int))-1)
>#else
>#define SIG_DFL ((void (*)())0)
>#define SIG_IGN ((void (*)())1)
>#define SIG_ERR ((void (*)())-1)
>#endif
>
>so, it doesn't matter if we use compiler (or compile-time switch for
>compiler) that doesn't support some feature or fires a warning seeing
>it -- standard headers will compile cleanly.
>
>if running gcc with '-pedantic' define some macro that could be tested
>in standard headers, we could use it. But, afaik, it doesn't define
>anything like it. Instead, gcc info recommends marking such code fragments
>explicitly as '__extension__'.
>
>My point is: standard headers shouldn't produce warnings whether you
>compile them with new version of compiler or old one. It should matter for
>user's code not for standard headers. 

I agree with this.  I believe that there is actually code in gcc already
that suppresses certain types of errors in system headers.

I think we would be confusing the user unnecessarily if we warn them about
something that the theoretically should have no control over.

IMO, system headers should not produce warnings, ever.

cgf
