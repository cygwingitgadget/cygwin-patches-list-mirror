From: DJ Delorie <dj@delorie.com>
To: cgf@cygnus.com
Cc: egorovv@mailandnews.com, cygwin-patches@sourceware.cygnus.com
Subject: Re: [egorovv@mailandnews.com: inet_network]
Date: Wed, 19 Apr 2000 10:57:00 -0000
Message-id: <200004191757.NAA03992@envy.delorie.com>
References: <20000419134603.A15867@cygnus.com> <200004191752.NAA03943@envy.delorie.com> <20000419135549.D15867@cygnus.com>
X-SW-Source: 2000-q2/msg00013.html

> LoadDLLFunc should actually abort the process if it can't load the function.

Then we shouldn't use it for an undocumented function, which may not
be available in all versions of winsock.
