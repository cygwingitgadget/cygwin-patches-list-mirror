From: DJ Delorie <dj@delorie.com>
To: khan@NanoTech.Wisc.EDU
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: (patch) munmap infinite loop fix
Date: Thu, 11 May 2000 15:31:00 -0000
Message-id: <200005112230.SAA27433@envy.delorie.com>
References: <200005112156.QAA30741@pluto.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00054.html

Applied.  Thanks!

> 2000-05-11  Mumit Khan  <khan@xraylith.wisc.edu>
> 
> 	* mmap.cc (list::erase): Increment loop counter.
> 	(map::erase): Likewise.
