From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: win95 and pshared mutex support for pthreads
Date: Wed, 25 Apr 2001 01:52:00 -0000
Message-id: <047d01c0cd65$18c8aed0$0200a8c0@lifelesswks>
References: <00d001c0c8bc$d9f12400$0200a8c0@lifelesswks> <20010424232202.A23753@cygbert.vinschen.de> <01b001c0cd0b$cf997950$0200a8c0@lifelesswks> <20010425102017.I23753@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00153.html

---- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: "cygpatch" <cygwin-patches@cygwin.com>
Sent: Wednesday, April 25, 2001 6:20 PM
Subject: Re: win95 and pshared mutex support for pthreads


> On Wed, Apr 25, 2001 at 08:13:36AM +1000, Robert Collins wrote:
> > From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
> > > Robert,
> > >
> > > may I ask why your new reentrant functions ignore the pw_gecos
> > > field? You know that it's very important when using ntsec?
> >
> > I didn't realise that I ignored anything. If I missed copying a
field
> > across it will be because I wrote from a spec and their struct
> > definition, not the cygwin internals. - Sorry.
>
> No reason to apologize. I apologize. I was too harsh since I was
> working on my new ntsec related code and suddenly found an error
> in my own code which could have been handled by some _r function.
> When I saw that getpwxxx_r couldn't work I overacted somewhat.
>
> Corinna
>

Thanks. I hadn't noticed any harshness - just directness. Mind you I'm
pretty thick skinned after the last decade :]

Rob
