From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: Add some defines in winnt.h.
Date: Wed, 14 Jun 2000 14:02:00 -0000
Message-id: <20000614170228.C25422@cygnus.com>
References: <s1saegpq9xb.fsf@jaist.ac.jp> <20000614163549.A8265@cygnus.com> <3947F1DD.4A7AD955@vinschen.de>
X-SW-Source: 2000-q2/msg00102.html

On Wed, Jun 14, 2000 at 10:58:05PM +0200, Corinna Vinschen wrote:
>Chris Faylor wrote:
>> 
>> Since Mumit isn't around, I've taken the liberty of approving this patch.
>> It looks fine to me.
>> 
>> This is conditional on Mumit's approval when he returns, of course.
>
>Oops, I have also patched w32api by adding some needed
>defines in wincrypt.h two or three weeks ago. We must not
>forget them since they are needed to compile Cygwin.

Mumit has said that it is ok to make changes as long as they are posted
here.

It would be nice for someone to merge the two versions of w32api and mingw
but I guess that will have to wait until Mumit returns.

cgf
