From: "Ralf Habacker" <Ralf.Habacker@freenet.de>
To: <cygwin-patches@cygwin.com>
Subject: RE: Patch for ssp on win2k
Date: Tue, 18 Sep 2001 05:20:00 -0000
Message-id: <000a01c1402b$461cd2b0$651c440a@BRAMSCHE>
References: <20010917131718.A10615@redhat.com>
X-SW-Source: 2001-q3/msg00163.html

> On Mon, Sep 17, 2001 at 09:45:42AM +0200, Ralf Habacker wrote:
> >on win2k ssp crashes sometimes while handling LOAD_DLL_DEBUG_EVENT
> caused by an
> >unhandled rv return value of ReadProcessMemory(). The patch fixes this.
>
> I didn't spend too much time investigating the code but it looks like this
> is a workaround rather than a fix.
Probably you're right. But because the current implementation contains already
lines
with "(unknown)" status, I have added an additional condition to produce this.
If you look that ssp is crashing without it, it is a fix.

If 'rv' is wrong then does that mean
> that ReadProcessMemory failed?  If so, that is the correct test for this.

I don't know if this a condition indicate a failure. rc contains an adress which
direct into the ntdll.dll.
Perhaps it means something other as used currently, but examinig the content
under that adress produces
no additional infos for me.

>
> cgf
>
