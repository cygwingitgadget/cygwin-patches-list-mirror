From: Robert Collins <robert.collins@itdomain.com.au>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Fri, 03 Aug 2001 06:01:00 -0000
Message-id: <996843821.24208.3.camel@lifelesswks>
References: <20010731203820.U490@cygbert.vinschen.de> <20010803144012.X23782@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00044.html

On 03 Aug 2001 14:40:12 +0200, Corinna Vinschen wrote:
> Could anybody comment on that patch and if there's perhaps a
> need to put some stuff in to make it thread save? Or if the
> patch slows down Cygwin intolerably?
> 
> If nobody complains I will apply that patch on Monday, otherwise.
> 
> Corinna
> 
> On Tue, Jul 31, 2001 at 08:38:20PM +0200, Corinna Vinschen wrote:
> > Hi,
> > 
> > the following is a PRELIMINARY patch which I created while waiting
> > for a loooong build. It checks the modification time on /etc/passwd
> > and /etc/group to reread them if neccessary.
> > 
> > It's preliminary since it completely ignores thread issues.
> > 
> > Could somebody have a look what is needed to make it thread safe?
> > 
> > Thanks in advance,
> > Corinna
> > 
> > ChangeLog:
> > ==========
> > 
> > 	* grp.cc (class grp_check): New class. Make `group_state'
> > 	a member of class grp_check.
> > 	(read_etc_group): Set `curr_lines' explicitely to 0.
> > 	* passwd.cc (class pwd_check): New class Make `passwd_state'
> > 	a member of class pwd_check.
> > 	(read_etc_passwd): Set `curr_lines' explicitely to 0.
> > 
> > Index: passwd.cc
> > ===================================================================
> > RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
> > retrieving revision 1.27
> > diff -u -p -r1.27 passwd.cc
> > --- passwd.cc	2001/07/26 19:22:24	1.27
> > +++ passwd.cc	2001/07/31 18:00:27
> > @@ -13,6 +13,7 @@ details. */
> >  #include <pwd.h>
> >  #include <stdio.h>
> >  #include <errno.h>
> > +#include <sys/stat.h>
> >  #include "cygerrno.h"
> >  #include "security.h"
> >  #include "fhandler.h"
> > @@ -40,7 +41,31 @@ enum pwd_state {
> >    emulated,
> >    loaded
> >  };
> > -static pwd_state passwd_state = uninitialized;
> > +class pwd_check {
> > +  pwd_state state;
> > +  time_t    last_modified;
> > +
> > +public:
> > +  pwd_check () : state (uninitialized), last_modified (0L) {}
> > +  operator pwd_state ()
> > +    {
> > +      struct stat st;
> > +
> > +      if (!stat ("/etc/passwd", &st) && st.st_mtime > last_modified)
> > +	{
> > +	  state = uninitialized;
> > +	  last_modified = st.st_mtime;
> > +	}
> > +      return state;
> > +    }
We're reentrant here because of the stat() call. You need to alter the
read_etc_passwd(function to not recurse forever (as is done for the
fopen call - thats the passwd_state !=initilizing test). (Or have you
tested for that particular race?)
Rob

> > +  void operator = (pwd_state nstate)
> > +    {
> > +      state = nstate;
> > +    }
> > +};
> > +
> > +static pwd_check passwd_state;
> > +
> >  
> >  /* Position in the passwd cache */
> >  #ifdef _MT_SAFE
> > @@ -140,6 +165,7 @@ read_etc_passwd ()
> >      if (passwd_state != initializing)
> >        {
> >  	passwd_state = initializing;
> > +	curr_lines = 0;
> >  
> >  	FILE *f = fopen ("/etc/passwd", "rt");
> >  
> > -- 
> > Corinna Vinschen                  Please, send mails regarding Cygwin to
> > Cygwin Developer                                mailto:cygwin@cygwin.com
> > Red Hat, Inc.
> 
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.

