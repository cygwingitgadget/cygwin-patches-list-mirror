From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Tue, 04 Dec 2001 05:29:00 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2828@cnmail>
X-SW-Source: 2001-q4/msg00291.html
Message-ID: <20011204052900.Vr1BtsM9einPW0JjupW6_qGXbO7mKJSr37Kr6J9DMos@z>

I can do that, but it'll probably be a while before I can get back to you on
it.  Things are a bit crazy at work.  If that's ok with you guys then I'll
do it.

Mark

> -----Original Message-----
> From: Corinna Vinschen [ mailto:cygwin-patches@cygwin.com ] 
> Sent: Tuesday, December 04, 2001 5:24 AM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
> 
> 
> On Mon, Dec 03, 2001 at 11:22:54PM -0500, Christopher Faylor wrote:
> > On Mon, Dec 03, 2001 at 09:24:47PM -0500, Mark Bradshaw wrote:
> > >It just occurred to me that the patch I submitted for mkpasswd.c 
> > >causes one of its error messages to be a bit misleading.  
> If you ask 
> > >mkpasswd for a user that doesn't exist it will say:
> > >"NetUserEnum() failed with error 2221.
> > >That user doesn't exist."
> > >
> > >While the error number is correct, and the explanation on 
> the second 
> > >line is right, it's not actually NetUserEnum that's been called to 
> > >determine that. I don't know if you care about this, but maybe the 
> > >following patch could be thrown in to make that error a bit more 
> > >generic (and correct).
> > 
> > I agree that the user doesn't have to know about 
> NetUserEnum but the 
> > error message should be something like "mkpasswd: user 
> doesn't exist".
> > 
> > Some of the messages are like this already.  Are you interested in 
> > genercizing the rest of the mkpasswd warnings?
> > 
> > cgf
> 
> I agree.  It would be nice(tm) to have an error message as the above
> "mkpasswd: user doesn't exist" or, if actually an error 
> occurs, to have a "mkpasswd: <Win32 error message>".  That's 
> not only useful for mkpasswd but for all tools calling Win32 
> error directly.
> 
> Corinna
> 
> -- 
> Corinna Vinschen                  Please, send mails 
> regarding Cygwin to
> Cygwin Developer                                
> mailto:cygwin@cygwin.com
> Red Hat, Inc.
> 
