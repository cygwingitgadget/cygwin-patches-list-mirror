From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Sun, 16 Dec 2001 21:14:00 -0000
Message-ID: <NCBBIHCHBLCMLBLOBONKAEPACHAA.g.r.vansickle@worldnet.att.net>
References: <15c601c1868b$543c7930$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00327.html
Message-ID: <20011216211400.OebW9Vos5wh7yL7tvHf3R9BdlTRvuA2zTfcvQCdju-U@z>

> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com
> [ mailto:cygwin-patches-owner@cygwin.com]On Behalf Of Robert Collins
> Sent: Sunday, December 16, 2001 5:43 PM
> To: cygwin-patches@cygwin.com; Jan Nieuwenhuizen
> Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf
> packages]
>
>
> Strangely enough, building from CVS works fine for me - w32api seems
> fine.
>

With the exception of <cstdlib> that gcc isn't finding for me in the generated
inilex.cc, I can second that emotion.  I think you must have something pretty
badly broken in your build environment somehow, Jan.  Are you sure you have both
the current "mingw runtime" stuff and a current *full* CVS tree of cygwin?  The
setup build pulls in a bunch of header directories from the cygwin tree as well
as your regular mingw stuff, so it might be some issue there.

--
Gary R. Van Sickle
Brewer.  Patriot.
