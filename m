From: Robert Collins <robert.collins@itdomain.com.au>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire streamas a  header
Date: Tue, 27 Nov 2001 14:13:00 -0000
Message-ID: <1006899141.2048.2.camel@lifelesswks>
References: <3C035977.BF151D0A@syntrex.com> <000601c17772$7c5ecfd0$2101a8c0@d8rc020b> <20011127184223.GA24028@redhat.com>
X-SW-Source: 2001-q4/msg00259.html
Message-ID: <20011127141300.sGS7FT3pH05TeZ9WHYP8sw3TFJOdNUpwLyzcv_reFWE@z>

On Wed, 2001-11-28 at 05:42, Christopher Faylor wrote:

> >Ah, better yet.  Jeez you guys are clever ;-).  But how about we make it:
> >
> >	while (((l = s->gets ()) != 0) && (*l != '\0'))
> >
> >in the interest of making it a bit more self-documenting?
> 
> Actually, how about not using != 0.  Use NULL in this context.
> 
> I don't think that *l is hard to understand, fwiw.

I think *l is ok. As for 0 vs NULL, in C++ NULL is deprecated, 0 is the
correct test for an invalid pointer.

Rob
