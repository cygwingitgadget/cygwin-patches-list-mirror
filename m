Return-Path: <cygwin-patches-return-1542-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 17443 invoked by alias); 28 Nov 2001 00:32:52 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 17406 invoked from network); 28 Nov 2001 00:32:49 -0000
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream
	as a  header
From: Robert Collins <robert.collins@itdomain.com.au>
To: cygwin-patches@cygwin.com
In-Reply-To: <20011128002122.GA6919@redhat.com>
References: <20011127230925.GA5830@redhat.com>
	<000001c1779c$e1fe2fa0$2101a8c0@NOMAD> <20011127235226.GA6537@redhat.com>
	<1006906033.2048.23.camel@lifelesswks>  <20011128002122.GA6919@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: Thu, 25 Oct 2001 04:47:00 -0000
Message-Id: <1006907495.2048.25.camel@lifelesswks>
Mime-Version: 1.0
X-OriginalArrivalTime: 28 Nov 2001 00:32:48.0873 (UTC) FILETIME=[34E32D90:01C177A4]
X-SW-Source: 2001-q4/txt/msg00074.txt.bz2

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
