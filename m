From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - allows selection of specific user
Date: Tue, 20 Nov 2001 20:32:00 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2794@cnmail>
X-SW-Source: 2001-q4/msg00238.html
Message-ID: <20011120203200.WWq-hXrQIUNgwKKGOYUJTCiypc3F1oqrjS90HpZAgHk@z>

Ah.  I see what you mean.  I've always done ifs like that, and never
considered that the braces would be a "thing".  If you or Corinna want, I'll
redo em and resubmit.  15th times the charm...

Mark

> -----Original Message-----
> From: Christopher Faylor [ mailto:cgf@redhat.com ] 
> Sent: Tuesday, November 20, 2001 10:35 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
> 
> 
> The code looks good to me, but it seems like you you're using 
> K&R formatting rather than GNU formatting, i.e., the curly 
> braces don't match the rest of the code.
> 
> This is pretty minor, and normally I would just apply the 
> patch, fix the couple of formatting glitches, and check this 
> in, however, since mkpasswd.c is sort of owned by Corinna, 
> I'll let her have final approval.
> 
> Btw, the ChangeLog entry looks fine.
> 
> Thanks for this patch.  I'm looking forward to getting it 
> into the main distribution.
> 
> cgf
