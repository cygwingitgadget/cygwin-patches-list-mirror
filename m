From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: win95 and pshared mutex support for pthreads
Date: Wed, 25 Apr 2001 01:50:00 -0000
Message-id: <046b01c0cd64$dad1cc60$0200a8c0@lifelesswks>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010424232202.A23753@cygbert.vinschen.de> <20010424233314.B23753@cygbert.vinschen.de> <01ba01c0cd0c$26b7b850$0200a8c0@lifelesswks> <20010425101554.H23753@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00152.html

----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: "cygpatch" <cygwin-patches@cygwin.com>
Sent: Wednesday, April 25, 2001 6:15 PM
Subject: Re: win95 and pshared mutex support for pthreads


> On Wed, Apr 25, 2001 at 08:16:02AM +1000, Robert Collins wrote:
> > ----- Original Message -----
> > I wasn't sure so I _tested_ the output. And no overruns occured.
>
> It's not an overrun problem in first place.
>
> > Have you tested this Corinna?
>
> I have. My testcode:
>

oooh. Well I have no explanation: my routines were producing sensible
output. the overrun I referred to was overwriting the \0 at the end of a
string with the beginning of the next string (which is obviously
happening to you).

Thanks for fixing this.

Rob
