From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Re: sys/stat.h constants patch
Date: Tue, 27 Mar 2001 19:50:00 -0000
Message-id: <20010327225115.A29310@redhat.com>
References: <20010327222942.A1918@dothill.com>
X-SW-Source: 2001-q1/msg00258.html

On Tue, Mar 27, 2001 at 10:29:42PM -0500, Jason Tishler wrote:
>The attached patch "properly" initializes sys/stat.h constants such as
>S_IXUSR.  I quote properly because I'm not sure what is the best way to
>correct this problem.  I tried a couple of permutations and ended up
>with this one.
>
>Nevertheless, without this patch the interesting lines in
>winsup/cygwin/lib/_cygwin_S_IEXEC.cc end up as follows after cpp:
>
>    const unsigned _cygwin_S_IEXEC = _cygwin_S_IEXEC ;
>    const unsigned _cygwin_S_IXUSR = _cygwin_S_IXUSR ;
>    const unsigned _cygwin_S_IXGRP = _cygwin_S_IXGRP ;
>    const unsigned _cygwin_S_IXOTH = _cygwin_S_IXOTH ;
>    const unsigned _cygwin_X_OK = _cygwin_X_OK ;
>
>instead of:
>
>    extern const unsigned _cygwin_S_IEXEC = 0000100 ;
>    extern const unsigned _cygwin_S_IXUSR = 0000100 ;
>    extern const unsigned _cygwin_S_IXGRP = 0000010 ;
>    extern const unsigned _cygwin_S_IXOTH = 0000001 ;
>    extern const unsigned _cygwin_X_OK = 1 ;

Hmm.  I wonder how my test cases ever worked! And, I wonder why
_cygwin_X_OK is defined correctly.

I have chosen a different method for fixing this, which I've checked
in.  Basically, I got rid of the 'const'.  It didn't seem to be
actually doing what I hoped it should be doing.

Thanks for noticing this.  This would have been disastrous if it
had been released in 1.3.0.

cgf
