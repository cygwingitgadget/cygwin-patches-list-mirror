From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 17:11:00 -0000
Message-id: <20010207201149.A20901@redhat.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com> <3A81E3BC.BF96D3CB@yahoo.com> <200102080056.TAA02750@envy.delorie.com>
X-SW-Source: 2001-q1/msg00060.html

On Wed, Feb 07, 2001 at 07:56:25PM -0500, DJ Delorie wrote:
>>>Is this just to get it to use the local includes, rather than the
>>>installed ones?
>>
>>No.  It won't build without it with the 2.95.2-7 gcc.
>
>Is this related to the patches Chris just added to gcc to make it find
>the win32 headers by default?n

Possibly.  I don't know if I screwed up 2.95.2-7 or not for the non-cross
case.

cgf
