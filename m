From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com, Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: X_OK redefinition protection.
Date: Fri, 20 Apr 2001 10:14:00 -0000
Message-id: <3AE06E7E.13717609@yahoo.com>
References: <3ADEFDEF.626A46EC@yahoo.com> <20010420123732.A24555@redhat.com>
X-SW-Source: 2001-q2/msg00132.html

Christopher Faylor wrote:
> 
> On Thu, Apr 19, 2001 at 11:02:07AM -0400, Earnie Boyd wrote:
> >I've also sent the sys-unistd file to newlib.
> >
> >Earnie.
> >2001-04-19  Earnie Boyd  <earnie@users.sourceforge.net>
> >
> >       * include/sys/file.h (X_OK): Remove redefinition warnings when
> >       including both sys/unistd.h and sys/file.h.  Make the definition
> >       consistent with sys/unistd.h.
> 
> I've checked in an alternate patch for this.
> 
> I don't think there is any reason to protect F_OK, W_OK, and R_OK.
> Those definitions haven't changed for years.  The real problem was that
> I somehow got the #ifdef wrong.
> 
> Are you actually seeing problems with F_OK redefinition?
> 

No, just with X_OK.  I just chose to protect the group so that if Cygwin
decides to do something similar to any of the others it's already
covered.  Why are they defined in both anyway?

Earnie.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

