From: Chris Faylor <cgf@cygnus.com>
To: DJ Delorie <dj@delorie.com>
Cc: egorovv@mailandnews.com, cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Wed, 19 Apr 2000 10:56:00 -0000
Message-id: <20000419135549.D15867@cygnus.com>
References: <20000419134603.A15867@cygnus.com> <200004191752.NAA03943@envy.delorie.com>
X-SW-Source: 2000-q2/msg00012.html

On Wed, Apr 19, 2000 at 01:52:08PM -0400, DJ Delorie wrote:
>
>> Occasionally (building Apache) I found that though <arpa/inet.h> declares 
>> inet_network, it is not implemented. 
>> 
>> Here is my proposal which makes use of an undocumented wsock32.dll entry.
>
>If it's undocumented, we should gracefully handle the case where it
>isn't in the DLL.  Could you add some code that detects the failure of
>LoadDLLFunc and returns a suitable error code if the function isn't
>defined?  That would be better than a core dump.

LoadDLLFunc should actually abort the process if it can't load the function.

cgf
