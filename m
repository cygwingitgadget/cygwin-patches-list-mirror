From: Jason Tishler <jason@tishler.net>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: WriteFile() whacks st_atime patch
Date: Mon, 17 Sep 2001 06:37:00 -0000
Message-id: <20010917093848.J2272@dothill.com>
References: <1000218262.7293.272.camel@lifelesswks>
X-SW-Source: 2001-q3/msg00157.html

On Wed, Sep 12, 2001 at 12:24:21AM +1000, Robert Collins wrote:
> On Tue, 2001-09-11 at 06:22, Corinna Vinschen wrote:
> > On Mon, Sep 10, 2001 at 03:44:31PM -0400, Jason Tishler wrote: 
> > > Given the above problems, I have very mixed feelings about this patch.
> > > Is it worth pursuing or should I dropped it?
> > 
> > Frankly, I don't know.  My first guess is to prioritize correctness
> > over speed and with your patch the functionality seems to be at 
> > least `more correct'.  Would it perhaps make sense to change
> > that to something like:
> 
> I think correctness in this case is well worth it, as it's obviously
> causing some problems out there. However, it would be good to bench the
> difference building cygwin or something, to see the impact.
> 
> [snip]

Moved back to cygwin-developer (where I should have left this discussion
to begin with) ...

Jason
