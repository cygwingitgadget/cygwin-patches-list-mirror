From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for ssp on win2k
Date: Mon, 17 Sep 2001 10:16:00 -0000
Message-id: <20010917131718.A10615@redhat.com>
References: <000501c13f4c$c0d03720$806707d5@BRAMSCHE>
X-SW-Source: 2001-q3/msg00159.html

On Mon, Sep 17, 2001 at 09:45:42AM +0200, Ralf Habacker wrote:
>on win2k ssp crashes sometimes while handling LOAD_DLL_DEBUG_EVENT caused by an
>unhandled rv return value of ReadProcessMemory(). The patch fixes this.

I didn't spend too much time investigating the code but it looks like this
is a workaround rather than a fix.  If 'rv' is wrong then does that mean
that ReadProcessMemory failed?  If so, that is the correct test for this.

cgf
