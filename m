From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceptions.cc (call_signal_handler_now)
Date: Sun, 08 Apr 2001 17:45:00 -0000
Message-id: <20010408204539.A23313@redhat.com>
References: <3ACC7EFA.D650E2D3@yahoo.com>
X-SW-Source: 2001-q2/msg00015.html

I think that I came up with a way to avoid "externalizing" this function.
It's a kludge, but as far as I can tell, it seems to work with both the
newer (3.1) and older (2.95.3) gcc's.

It's in CVS now.  If this doesn't work for you, I'll break down and
pollute the global name space.

cgf

On Thu, Apr 05, 2001 at 09:19:38AM -0500, Earnie Boyd wrote:
> 
>2001-04-05  Earnie Boyd  <earnie_boyd@yahoo.com
>
>	* exceptions.cc (call_signal_handler_now): Remove the static declaration
>	to allow -finline-functions option to work.
