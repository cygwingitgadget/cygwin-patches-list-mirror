From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R Van Sickle" <tiberius@braemarinc.com>, <cygwin-patches@sourceware.cygnus.com>
Subject: Re: [PATCH] Update 2 - Setup.exe property sheet patch
Date: Thu, 20 Dec 2001 13:17:00 -0000
Message-ID: <03f301c1899b$ae6deb60$0200a8c0@lifelesswks>
References: <000601c18994$10e82920$2101a8c0@BRAEMARINC.COM>
X-SW-Source: 2001-q4/msg00345.html
Message-ID: <20011220131700.dZ3uoojBIjrh6ekAHiOaQpSwZQB9F0aFZVD4GA73m5s@z>

----- Original Message -----
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
>
> "Once virtual, always virtual", i.e., it isn't necessary to add
"virtual" to
> any overridden virtual functions, and in fact it's not possible to
> "unvirtualize" once virtualized.  I do try to maintain them as a
stylistic
> convention, but even I fall short sometimes ;-).  Thanks for patching
that.

My understanding is that this is not 100% the case. Or more
pedantically - in a class derived from a a class with virtual functions,
those virtual functions wil get overriden, but if not declared virtual
themselves, any further derivations will not. I believe that the
technique of doing this to allow inlining of code calling references to
an object is called 'final classes'.

> > 2) See download.cc - is next_dialog still used, and should a
> > fail result
> > in the previous behaviour?
> >
>
> I believe it is still used in a few places (some of the "do_xxx"'s).
That
> whole mechanism is one of the next things to go.  As far as behavior
is
> concerned, I'm trying hard to specifically *not* change any at this
point,
> but simply to get the new property page and class foundation laid
("simply"
> he sez ;-)).  So you're saying that a download failure isn't being
handled
> properly?

I think that 2 things are broken:
1) A local install doesn't.
2) A failure during download may not behave correctly - but I don't
know.

Rob
