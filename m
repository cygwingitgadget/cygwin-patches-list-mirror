From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Cc: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 05:20:00 -0000
Message-id: <3B559AB3.B93C5DA5@yahoo.com>
References: <20010717221042.A426@dothill.com> <20010718130154.E730@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00016.html

Corinna Vinschen wrote:
> 
> BTW, I have a naive question related to unlink. I had just another
> look into SUSv2 and to my surprise it defines the following error
> code:
> 
> [EBUSY]    The file named by the path argument cannot be unlinked
>            because it is being used by the system or another process
>            and the implementation considers this an error.
> 
> which basically means, if we try to unlink a file and that fails,
> we wouldn't have to force it by ugly tricks (delqueue) but just
> return EBUSY and Cygwin would still be SUSv2 compliant.
> 
> All: Would that be ok to change or would you like to keep the current
>      behaviour?
> 

I vote for EBUSY.  The delqueue has the potential to be more harmful
than good.

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

