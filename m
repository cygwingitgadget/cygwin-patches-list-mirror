From: Christopher Faylor <cgf@redhat.com>
To: Cygwin-Patches <cygwin-patches@sources.redhat.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 09:39:00 -0000
Message-id: <20010718123925.A15332@redhat.com>
References: <20010717221042.A426@dothill.com> <20010718130154.E730@cygbert.vinschen.de> <3B559AB3.B93C5DA5@yahoo.com> <20010718144433.I730@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00023.html

On Wed, Jul 18, 2001 at 02:44:33PM +0200, Corinna Vinschen wrote:
>Is anybody aware of an application which would really miserably
>fail if unlink() returns EBUSY? Besides `rm' of course ;-)

I believe that configure/libtool might actually rely on this behavior.
I think it is way too late in the game to remove this functionality.

cgf
