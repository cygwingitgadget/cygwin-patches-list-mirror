From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: Re: exceptions.cc (call_signal_handler_now)
Date: Mon, 09 Apr 2001 05:30:00 -0000
Message-id: <3AD1AB3E.675C33B6@yahoo.com>
References: <3ACC7EFA.D650E2D3@yahoo.com> <20010408204539.A23313@redhat.com>
X-SW-Source: 2001-q2/msg00020.html

Christopher Faylor wrote:
> 
> I think that I came up with a way to avoid "externalizing" this function.
> It's a kludge, but as far as I can tell, it seems to work with both the
> newer (3.1) and older (2.95.3) gcc's.
> 
> It's in CVS now.  If this doesn't work for you, I'll break down and
> pollute the global name space.
> 

It works. :)

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

