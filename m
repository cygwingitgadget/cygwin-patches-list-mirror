From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: 'Corinna Vinschen' <cygwin-patches@cygwin.com>
Subject: RE: patch to dir.cc
Date: Fri, 20 Jul 2001 09:01:00 -0000
Message-id: <911C684A29ACD311921800508B7293BA010A8A67@cnmail>
X-SW-Source: 2001-q3/msg00029.html

Oh.  Oops.  Sorry about the missing ChangeLog entry.  I could've sworn I put
on in my email, but I guess I patched that too. <grin>  I'll get it right
next time...

Mark

-----Original Message-----
From: Corinna Vinschen [ mailto:cygwin-patches@cygwin.com ]
Sent: Friday, July 20, 2001 3:25 AM
To: cygwin-patches@cygwin.com
Subject: Re: patch to dir.cc


On Thu, Jul 19, 2001 at 07:30:41PM -0400, Christopher Faylor wrote:
> This patch looks good to me but I'm not in a position to test it much.
> 
> Corinna, how does it look to you?

I checked it in as is.

Mark, could you please add a ChangeLog entry as the following next time?

=====
Fri 20 Jul 2001 09:15:00  Mark Bradshaw <bradshaw@staff.crosswalk.com>

        * dir.cc (readdir): Protect FindNextFileA against
INVALID_HANDLE_VALUE.
=====

Thanks for tracking that down and the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
