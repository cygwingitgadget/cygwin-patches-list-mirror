From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: pthread_cond*
Date: Fri, 16 Mar 2001 17:23:00 -0000
Message-id: <20010316202404.A2512@redhat.com>
References: <05e401c0ae24$e8194600$0200a8c0@lifelesswks> <20010316102348.D11518@redhat.com> <007701c0ae6c$f174ab70$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00189.html

On Sat, Mar 17, 2001 at 10:00:47AM +1100, Robert Collins wrote:
>Take two - return value for TimedWait function.

I've checked this in.

Btw, there was something strange about the patch.  Patch gave me errors
about missing 'diff' headers when I tried to install it.

Also, the ChangeLog was a little off.  There is no reason to include
cygwin/foo.cc in the cygwin/ChangeLog.  foo.cc is correct.  Also each
entry should be a sentence.

Thanks for the patch.  I am very happy to see someone working on
this stuff.

Btw, is there any reason for the __pthread and pthread implementation?
I wasn't involved in the original implementation and I've always wondered
why the original authors tried to do things this way.

cgf
