From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Fri, 09 Nov 2001 19:24:00 -0000
Message-id: <911C684A29ACD311921800508B7293BA010A8FF2@cnmail>
X-SW-Source: 2001-q4/msg00188.html

Ok.  I'll send one in as time allows.

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ] 
> Sent: Friday, November 09, 2001 8:40 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: patch to mkpasswd.c - allows selection of specific user
> 
> 
> On Fri, Nov 09, 2001 at 08:23:01PM -0500, Mark Bradshaw wrote:
> >Ah.  I'm a dummy.  I'm looking at the wrong thing.  How about this:
> >
> >Fri 9 Nov 2001 18:15:00  Mark Bradshaw <bradshaw@staff.crosswalk.com>
> >	* mkpasswd.c (main): New -u option to allow specifying a 
> >	specific user.  If specified groups aren't displayed.
> >	(enum_users): If specific user is specified, via -u option, 
> >	display only that user's record.
> 
> Looks ok.  The date is a little off.  It should either be:
> 
> 2001-11-09 or Fri  9 Nov 18:15:00 2001
> 
> but that's obviously no big deal.
> 
> I really do need an assignment for something of this length.  
> Especially if it adds new functionality.  Sorry.  I hate the 
> fact that I have to ask for this.
> 
> cgf
> 
