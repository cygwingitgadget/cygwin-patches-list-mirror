From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [Jason.Tishler@dothill.com: Strange Cygwin 1.1.1 mv Behavior]
Date: Tue, 23 May 2000 13:11:00 -0000
Message-id: <20000523161132.A25145@cygnus.com>
References: <20000523143453.B22579@cygnus.com> <200005231923.PAA24195@envy.delorie.com> <392AE52B.1AF55456@dothill.com>
X-SW-Source: 2000-q2/msg00079.html

On Tue, May 23, 2000 at 04:08:11PM -0400, Jason Tishler wrote:
>BTW, I noticed another 1.1.1 HOME directory anomaly:
>
>H:\>set home
>HOME=H:\
>...
>
>H:\>bash
>bash-2.03$ pwd
>/home/jt/
>        ^
>        +--- extra slash

This should be fixed in tonight's snapshot.  I noticed this anomaly
this morning.

cgf
