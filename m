From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Sat, 10 Nov 2001 15:09:00 -0000
Message-id: <911C684A29ACD311921800508B7293BA010A8FFB@cnmail>
X-SW-Source: 2001-q4/msg00192.html

I've gone ahead and rewritten the mkpasswd patch so that only the specific
user that is desired is actually queried for.  This should significantly
speed up seek times on large domains.  I'd like to add another function to
get the particulars for the specific user, and then separate the code that
actually prints the user information out of the enum_users function into a
separate function.  This way both the "get em all" and the "get one"
functions print in the same way, making it easier to maintain I'd think.

Sound okay?

Mark

> -----Original Message-----
> From: Mark Bradshaw
> Sent: Friday, November 09, 2001 10:24 PM
> To: 'cygwin-patches@cygwin.com'
> Subject: RE: patch to mkpasswd.c - allows selection of specific user
> 
> 
> Ok.  I'll send one in as time allows.
> 
> > -----Original Message-----
> > From: Christopher Faylor [ mailto:cgf@redhat.com ]
> > Sent: Friday, November 09, 2001 8:40 PM
> > To: cygwin-patches@cygwin.com
> > Subject: Re: patch to mkpasswd.c - allows selection of specific user
> > 
> > 
> > On Fri, Nov 09, 2001 at 08:23:01PM -0500, Mark Bradshaw wrote:
> > >Ah.  I'm a dummy.  I'm looking at the wrong thing.  How about this:
> > >
> > >Fri 9 Nov 2001 18:15:00  Mark Bradshaw
> <bradshaw@staff.crosswalk.com>
> > >	* mkpasswd.c (main): New -u option to allow specifying a 
> > >	specific user.  If specified groups aren't displayed.
> > >	(enum_users): If specific user is specified, via -u option, 
> > >	display only that user's record.
> > 
> > Looks ok.  The date is a little off.  It should either be:
> > 
> > 2001-11-09 or Fri  9 Nov 18:15:00 2001
> > 
> > but that's obviously no big deal.
> > 
> > I really do need an assignment for something of this length. 
> > Especially if it adds new functionality.  Sorry.  I hate the fact 
> > that I have to ask for this.
> > 
> > cgf
> > 
> 
