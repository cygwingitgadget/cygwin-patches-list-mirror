From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire streamas a  header
Date: Tue, 27 Nov 2001 16:17:00 -0000
Message-ID: <000101c177a1$e96ed780$2101a8c0@NOMAD>
References: <1006904553.2048.20.camel@lifelesswks>
X-SW-Source: 2001-q4/msg00266.html
Message-ID: <20011127161700.zAMCsZWjGiXgb-C7mDh_nlj6q0vPhaETrnA6mizeQY4@z>

> On Wed, 2001-11-28 at 10:09, Christopher Faylor wrote:
> > References?  A simple google search for 'NULL C++ deprecated' didn't
> > unearth this information.
>
> Deprecated may have been too strong a word. Anyway, references:
>
> The C++ annotations - http://www.icce.rug.nl/documents/cpp.shtml
> Specifically...
> http://www.icce.rug.nl/documents/cplusplus/cplusplus02.html#an78

This must predate the ratification of the standard:

"2.5.3: NULL-pointers vs. 0-pointers
[snip]  Indeed, according to the descriptions of the pointer-returning
operator new 0 rather than NULL is returned when memory allocation fails."

When new fails, it doesn't return anything, but rather throws an exception
now.  (Well, unless you use the (std::nothrow) syntax which I've never seen
used and in fact just found out about).  Oops, now it's my turn to document!
;-):  Chuck Allison here: http://www.freshsources.com/newcpp.html

Anywhoo, tell you guys what:  I'll roll all four permutations and whoever
checks it in can pick which patch or patches they want ;-).

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337
