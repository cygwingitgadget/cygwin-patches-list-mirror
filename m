From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>, <cygwin-patches@sourceware.cygnus.com>
Subject: RE: cygwin daemon/shm
Date: Mon, 17 Sep 2001 16:35:00 -0000
Message-id: <EA18B9FA0FE4194AA2B4CDB91F73C0EF08F185@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00162.html

> -----Original Message-----
> From: Corinna Vinschen [ mailto:cygwin-patches@cygwin.com ]
> 
> On Tue, Sep 18, 2001 at 08:08:16AM +1000, Robert Collins wrote:
> > On Tue, 2001-09-18 at 03:01, Corinna Vinschen wrote:
> > > just so that you don't feel alone :-)
> > 
> > Thank you. I was wondering... :}.
> 
> We're still here, just busy...

Chris had mentioned that privately. (Note the smiley above).
 
> > Ah, yes. Well I haven't benchmarked it, but FWIW my machine seems no
> > slower with it running.
> 
> You're talking about starting Cygwin processes?  Do they connect
> to the server already?

Yes, during dcrt startup, after signals are inited, a version check if
the daemon is performed. If no response is recieved, all daemon calls
are skipped and errors returned to the calling function. I'm thinking
about tweaking that, to perform that check at the first daemon call, as
this would avoid all delay associated with finding a dead daemon until a
daemon function was called. However this introduces more syncronisation.
It's a tradeoff really.
 
Rob
