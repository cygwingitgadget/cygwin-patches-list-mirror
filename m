From: DJ Delorie <dj@delorie.com>
To: egorovv@mailandnews.com
Cc: cgf@cygnus.com, cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Wed, 19 Apr 2000 10:52:00 -0000
Message-id: <200004191752.NAA03943@envy.delorie.com>
References: <20000419134603.A15867@cygnus.com>
X-SW-Source: 2000-q2/msg00011.html

> Occasionally (building Apache) I found that though <arpa/inet.h> declares 
> inet_network, it is not implemented. 
> 
> Here is my proposal which makes use of an undocumented wsock32.dll entry.

If it's undocumented, we should gracefully handle the case where it
isn't in the DLL.  Could you add some code that detects the failure of
LoadDLLFunc and returns a suitable error code if the function isn't
defined?  That would be better than a core dump.
