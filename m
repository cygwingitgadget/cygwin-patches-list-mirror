From: Robert Collins <robert.collins@itdomain.com.au>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Cc: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: WriteFile() whacks st_atime patch
Date: Tue, 11 Sep 2001 07:23:00 -0000
Message-id: <1000218262.7293.272.camel@lifelesswks>
References: <20010910154431.A792@dothill.com> <20010910222228.X937@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00126.html

On Tue, 2001-09-11 at 06:22, Corinna Vinschen wrote:
> On Mon, Sep 10, 2001 at 03:44:31PM -0400, Jason Tishler wrote: 
> > Given the above problems, I have very mixed feelings about this patch.
> > Is it worth pursuing or should I dropped it?
> 
> Frankly, I don't know.  My first guess is to prioritize correctness
> over speed and with your patch the functionality seems to be at 
> least `more correct'.  Would it perhaps make sense to change
> that to something like:

I think correctness in this case is well worth it, as it's obviously
causing some problems out there. However, it would be good to bench the
difference building cygwin or something, to see the impact.

> open(): 	CreateFile();
> 		if (O_WRONLY || O_RDWR)
> 		  GetFileTime();
> 
> read():		ReadFile();
> 		if (O_RDWR)
> 		  GetFileTime();
> 
> write():	WriteFile();
> 
> close():	if (O_WRONLY || O_RDWR)
> 		  SetFileTime();
> 		CloseHandle();
> 
> ???

No, Jason's code is fine, the race is multi-process...

proc a appends data to file foo, while proc b (say tail -f
/var/log.foo.log) reads from it. 

ie,
in a, GetFileTime(), write, context switch
in b, ReadFile(), context switch
in a, SetFileTime(), puts it back too early. In extreme cases that could
be arbitrarily log :[.

Also your example above was _worse_, consider
proc a,
open, 
write,
sleep(999)
close.

st_atime is clobbered for the whole sleep() call, and that is
potentially a long time for some programs.

Rob

