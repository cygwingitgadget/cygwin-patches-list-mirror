From: Dave Sainty <dave@dtsp.co.nz>
To: cygwin-patches@cygwin.com
Cc: dave@dtsp.co.nz, cgf@redhat.com
Subject: Re: Patch to make setrlimit() more forgiving 
Date: Fri, 05 Jan 2001 01:22:00 -0000
Message-id: <c53b6146210f758b9d4c01253397f610@NO-ID-FOUND.mhonarc.org>
References: <20010104214112.A32564@redhat.com>
X-SW-Source: 2001-q1/msg00007.html

Christopher Faylor writes:

> It looks good but I need a ChangeLog.
> 
> cgf
> 
> On Fri, Jan 05, 2001 at 03:38:43PM +1300, David Sainty wrote:
> >Attached is a simple patch that prevents setrlimit() failing with an error
> >when the operation would not have changed anything.  This allows all
> >resource types to be set, so long as the setting is identical to the current
> >pseudo-settings.

Certainly :)  Sorry, I'm sure there was some FAQ I was meant to read
before posting patches :)

Fri Jan 5 15:38:43 2001  Dave Sainty <david.sainty@dtsp.co.nz>

	* resource.cc: Allow all null setrlimit() operations to succeed
