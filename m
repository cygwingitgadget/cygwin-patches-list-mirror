Return-Path: <cygwin-patches-return-6905-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6515 invoked by alias); 14 Jan 2010 10:26:20 -0000
Received: (qmail 6496 invoked by uid 22791); 14 Jan 2010 10:26:18 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 14 Jan 2010 10:26:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 5C26D6D417D; Thu, 14 Jan 2010 11:25:57 +0100 (CET)
Date: Thu, 14 Jan 2010 10:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: dup3/O_CLOEXEC/F_DUPFD_CLOEXEC
Message-ID: <20100114102557.GB3428@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20100113212537.GB14511@calimero.vinschen.de>  <4B4E96D3.90300@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B4E96D3.90300@byu.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00021.txt.bz2

On Jan 13 21:00, Eric Blake wrote:
> According to Corinna Vinschen on 1/13/2010 2:25 PM:
> > Eric, you asked for it in the first place, do you have a fine testcase
> > for this functionality?
> 
> For dup3, fcntl(F_DUPFD_CLOEXEC), and pipe2, yes.  For open, accept4, and
> others, you'll have to use your imagination, but it is is similar.
> [...]

Thanks for the testcase.

> > -	  newfh->close_on_exec (false);
> > +	  /* The O_CLOEXEC flag enforces close-on-exec behaviour. */
> > +	  if (flags & O_CLOEXEC)
> > +	    newfh->set_close_on_exec (true);
> 
> Is that a typo?
> 
> > +	  else
> > +	    newfh->close_on_exec (false);
> 
> If not, why not just newfh->close_on_exec (!!(flags & O_CLOEXEC)), instead
> of the if-else?

There's a difference.  set_close_on_exec() calls SetHandleInformation()
via one or more intermediate calls to fhandler_base::set_no_inheritance().
close_on_exec() only sets the flag in the fhandler status flags.  The
if-else avoids two or more unnecessary function calls in the dup/dup2 case.

> > -  debug_printf ("dup2 (%d, %d)", oldfd, newfd);
> > +  debug_printf ("dup3 (%d, %d, %d)", oldfd, newfd, flags);
> 
> I'd prefer %#x for flags, rather than %d (two instances in this function).

Changed to %p.

> >    if (newfd == oldfd)
> >      {
> >        res = newfd;
> >        goto done;
> >      }
> 
> I see how you are filtering this case out in dup3(), but I wonder if it
> would be easier to make this function assume that newfd!=oldfd (in other
> words, make both dup2 and dup3 do the appropriate special casing, so this
> function doesn't have to do any).  More on that below.

Right, more on that below.

> > +++ winsup/cygwin/fcntl.cc	13 Jan 2010 21:22:13 -0000
> > @@ -49,6 +49,15 @@ fcntl64 (int fd, int cmd, ...)
> >  	  res = -1;
> >  	}
> >        break;
> > +    case F_DUPFD_CLOEXEC:
> > +      if ((int) arg >= 0 && (int) arg < OPEN_MAX_MAX)
> > +	res = dup3 (fd, cygheap_fdnew (((int) arg) - 1), O_CLOEXEC);
> > +      else
> > +	{
> > +	  set_errno (EINVAL);
> > +	  res = -1;
> > +	}
> > +      break;
> 
> Why not consolidate the two branches, and write this as:

Yes, good thinking, but...

> case F_DUPFD:
> case F_DUPFD_CLOEXEC:
>   if ((int) arg >= 0 && (int) arg < OPEN_MAX_MAX)
>     res = dup3 (fd, cygheap_fdnew (((int) arg) - 1),
>                 (cmd == F_DUPFD_CLOEXEC) * O_CLOEXEC);

Ouch, no, thanks.  I'd rather ?: it.

> > +++ winsup/cygwin/fhandler.cc	13 Jan 2010 21:22:13 -0000
> > +++ winsup/cygwin/fhandler_fifo.cc	13 Jan 2010 21:22:14 -0000
> > @@ -94,7 +94,9 @@ fhandler_fifo::open (int flags, mode_t)
> >      {
> >        char char_sa_buf[1024];
> >        LPSECURITY_ATTRIBUTES sa_buf =
> > -	sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
> > +	flags & O_CLOEXEC
> > +	? sec_user_nih ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid())
> > +	: sec_user ((PSECURITY_ATTRIBUTES) char_sa_buf, cygheap->user.sid());
> 
> In addition to cgf's comment about this repetition, is it any more compact
> to write:
> 
> ((flags & O_CLOEXEC) ? sec_user_nih : sec_user) ((PSECURITY_ATTRIBUTES)
> char_sa_buf, cygheap->user.sid());

Yeah, but I rather not do it.  I'll create an inline function for this
anyway.

> > @@ -131,7 +131,25 @@ dup2 (int oldfd, int newfd)
> >        set_errno (EBADF);
> >        return -1;
> >      }
> > -  return cygheap->fdtab.dup2 (oldfd, newfd);
> > +  return cygheap->fdtab.dup3 (oldfd, newfd, 0);
> 
> If you fix fdtab.dup3 above to omit the oldfd==newfd, then you need to add
> something like this before trying dup3:
> 
> if (oldfd == newfd)
>   {
>     cygheap_fdget cfd (oldfd);
>     if (cfd < 0)
>       {
>         set_errno (EBADF);
>         return -1;
>       }
>     return oldfd;
>   }

Done.  errno is already set in cygheap_fdget, though.

> > +}
> > +
> > +int
> > +dup3 (int oldfd, int newfd, int flags)
> > +{
> > +  if (newfd >= OPEN_MAX_MAX)
> > +    {
> > +      syscall_printf ("-1 = dup3 (%d, %d, %d) (%d too large)", oldfd, newfd, flags, newfd);
> 
> Again with the %#x instead of %d for flags.

With %p.

> > +      set_errno (EBADF);
> > +      return -1;
> > +    }
> > +  if (!cygheap->fdtab.not_open (oldfd) && oldfd == newfd)
> 
> Is not_open() expensive?  If so, reverse the order of the conditionals for
> speed.

Reordered and not_open replaced with cygheap_fdget.

> > +    {
> > +      syscall_printf ("-1 = dup3 (%d, %d, %d) (newfd==oldfd)", oldfd, newfd, flags);
> > +      set_errno (EINVAL);
> > +      return -1;
> > +    }
> > +  return cygheap->fdtab.dup3 (oldfd, newfd, flags);
> 
> According to spec, Linux dup3(-1,-1,0) can fail with either EBADF or
> EINVAL; I haven't tested that on Linux yet, but am assuming that your
> choice of EBADF for this condition was intentional?

Erm... EINVAL, and yes, it was intentional, per the Linux man page:

  ERRORS
    [...]
    EINVAL (dup3()) flags contain an invalid value.  Or, oldfd was equal to
	   newfd.

The case dup3(-1,-1,0) isn't catched here but in dtable::dup3.  It
will return EBADF due to the first not_open() 

> As long as we are exporting dup3, why not also pipe2, accept4, mkostemp,
> and mkostemps?

That's very easy to answer:  Because http://cygwin.com/acronyms/#SHTDI
and I have only so much time.  I'm just trying to lay the groundwork
here.  I'm not at all opposed to patches adding the still missing
functionality.

I'll send a revised patch soon.


Thanks for the thorough review,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
