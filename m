From: Jason Tishler <Jason.Tishler@dothill.com>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: unlink() patch (was Cygwin CVS breaks PostgreSQL drop table)
Date: Wed, 18 Jul 2001 06:02:00 -0000
Message-id: <20010718090211.C431@dothill.com>
References: <s1szoa24dro.fsf@jaist.ac.jp>
X-SW-Source: 2001-q3/msg00020.html

Corrina,

On Wed, Jul 18, 2001 at 09:34:19PM +0900, Kazuhiro Fujieda wrote:
> >>> On Wed, 18 Jul 2001 13:01:54 +0200
> >>> Corinna Vinschen <cygwin-patches@cygwin.com> said:
> 
> > All: Would that be ok to change or would you like to keep the current
> >      behaviour?
> 
> I'd like to keep the current behaviour.  I know some UNIX
> applications unlink temporary files just after open to ensure
> that their disk space are reclimed when the processes terminate.

I would like to keep the current behavior too.

On Wed, Jul 18, 2001 at 02:44:33PM +0200, Corinna Vinschen wrote:
> Is anybody aware of an application which would really miserably
> fail if unlink() returns EBUSY? Besides `rm' of course ;-)

I just grep-ed through the PostgreSQL source for unlink().  Although,
there are only six places where the source actually checks the return
value from unlink(), I believe that returning EBUSY would confuse
PostgreSQL.

I'm sure that there are many other Unix apps that would have similar
problems and would need to be patched for Cygwin, if the unlink()
behavior is changed as you suggest.

Jason

-- 
Jason Tishler
Director, Software Engineering       Phone: 732.264.8770 x235
Dot Hill Systems Corp.               Fax:   732.264.8798
82 Bethany Road, Suite 7             Email: Jason.Tishler@dothill.com
Hazlet, NJ 07730 USA                 WWW:   http://www.dothill.com
