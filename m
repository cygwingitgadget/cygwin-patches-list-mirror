From: Robert Collins <robert.collins@itdomain.com.au>
To: Gary R Van Sickle <tiberius@braemarinc.com>
Cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entirestreamas a  header
Date: Tue, 27 Nov 2001 16:35:00 -0000
Message-ID: <1006907654.2048.27.camel@lifelesswks>
References: <000101c177a1$e96ed780$2101a8c0@NOMAD>
X-SW-Source: 2001-q4/msg00270.html
Message-ID: <20011127163500.KKkE5vicDn59f9vgX6Ih54QwrqDknecIDB6klrzjDo4@z>

On Wed, 2001-11-28 at 11:16, Gary R Van Sickle wrote:
> > On Wed, 2001-11-28 at 10:09, Christopher Faylor wrote:
> > > References?  A simple google search for 'NULL C++ deprecated' didn't
> > > unearth this information.
> >
> > Deprecated may have been too strong a word. Anyway, references:
> >
> > The C++ annotations - http://www.icce.rug.nl/documents/cpp.shtml
> > Specifically...
> > http://www.icce.rug.nl/documents/cplusplus/cplusplus02.html#an78
> 
> This must predate the ratification of the standard:
> 
> "2.5.3: NULL-pointers vs. 0-pointers
> [snip]  Indeed, according to the descriptions of the pointer-returning
> operator new 0 rather than NULL is returned when memory allocation fails."
> 
> When new fails, it doesn't return anything, but rather throws an exception
> now.  (Well, unless you use the (std::nothrow) syntax which I've never seen
> used and in fact just found out about).  Oops, now it's my turn to document!
> ;-):  Chuck Allison here: http://www.freshsources.com/newcpp.html

Thank you for the reference. Setup currently builds with exceptions
disabled, which is a bit of a handicap. I was going to raise this soon
anyway :}.
 
> Anywhoo, tell you guys what:  I'll roll all four permutations and whoever
> checks it in can pick which patch or patches they want ;-).

Code comfortable for you. I won't reject patches using NULL, or not
using ==/!= 0. 

Rob
