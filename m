From: Robert Collins <robert.collins@itdomain.com.au>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire streamas a  header
Date: Tue, 27 Nov 2001 16:32:00 -0000
Message-ID: <1006907495.2048.25.camel@lifelesswks>
References: <20011127230925.GA5830@redhat.com> <000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com> <1006906033.2048.23.camel@lifelesswks> <20011128002122.GA6919@redhat.com>
X-SW-Source: 2001-q4/msg00269.html
Message-ID: <20011127163200.V1BIoGUdeMoCxapSpXfN4ZIlIcSnxAos84uWF0ChIx0@z>

On Wed, 2001-11-28 at 11:21, Christopher Faylor wrote:
> >> So, my new internal rule is that the above is ok but foo != 0 is
> >> "wrong".
> >
> >Why? I parse (foo) and if (foo != 0) are the same IFF foo is a simple
> >type (which includes pointers to objects). if (foo != NULL) is the same
> >as these two IFF foo is a pointer to an object. So NULL is a special
> >case, and thats useful in C, with it's relatively weak type checking.
> >C++ however has much stronger type checking, so I don't see the value in
> >a manual extra check like that. 
> 
> Why?  For the reasons that both Gary and I mentioned.  It's self
> documenting?

Granted. I don't really care, I made a single comment and have been
responding ever since. Forget it. Use whichever syntax you like.
 
> >> When I test a character, I use c != '\0' and when I test a floating
> >> point value, I do f != 0.0.
> >
> >Which is wrong BTW. To test floating point you want (abs (f) > confidence). 
> 
> Are you really so desne as to miss my point?  Apparently so.

Ha! flamebait.

What was your point? That in C++ one should write all equality
comparisons as foo == or foo != zerovaluedvariableofthesametype for
clarity?

Fine. I don't have a problem with that - although there are corner
cases.

I _ONLY_ had an issue with NULL vs 0.

Rob
