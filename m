From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: patch to mkpasswd.c - allows selection of specific user
Date: Fri, 09 Nov 2001 17:18:00 -0000
Message-id: <911C684A29ACD311921800508B7293BA010A8FF0@cnmail>
X-SW-Source: 2001-q4/msg00184.html

I haven't done an assignment.  I figured this was a trivial change.  If you
want one I'll go ahead and send one in.

Here's a new Changelog....

2001-11-09  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	* mkpasswd.c: Add an option (-u) to only display a selected user.

Better?  I looked in the Changelog and modeled the new one after the few on
top, but I saw lots down below that used the same formatting I did.  

Mark

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ] 
> Sent: Friday, November 09, 2001 8:02 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: patch to mkpasswd.c - allows selection of specific user
> 
> 
> Looks nice.  Have you sent in your assignment?  I don't 
> remember if we've received one from you or not and the person 
> who could check for me won't be back in the office until Monday.
> 
> Also, I think you want to look into ChangeLog formatting a 
> little.  The text below is not right.  Compare it against the 
> description in http://cygwin.com/contrib.html and the 
> existing formats in ChangeLog.
> 
> cgf
> 
> On Fri, Nov 09, 2001 at 06:55:22PM -0500, Mark Bradshaw wrote:
> >This patch allows a person to specify that only information for a 
> >particular user should be returned by mkpasswd.  It doesn't 
> affect way 
> >mkpasswd gets its information, but only restricts what is 
> actually output.
> >
> >I had it go ahead and stop requesting more users when it had a user 
> >specified AND got a match.  I guess it could be rewritten to only 
> >request info on a specific user.  I'm just not sure how.  Oh well.
> >
> >This patch worked fine on my win2k machine.
> >
> >Mark
> >
> >=============================================
> >Fri 9 Nov 2001 18:15:00  Mark Bradshaw <bradshaw@staff.crosswalk.com>
> >
> >        * mkpasswd.c : Add -u option to allow specifying 
> only one user
> >
> >=============================================
> 
