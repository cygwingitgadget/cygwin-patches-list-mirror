From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch to dir.cc
Date: Fri, 20 Jul 2001 00:26:00 -0000
Message-id: <20010720092513.W730@cygbert.vinschen.de>
References: <911C684A29ACD311921800508B7293BA010A8A57@cnmail> <20010719193041.C7237@redhat.com>
X-SW-Source: 2001-q3/msg00028.html

On Thu, Jul 19, 2001 at 07:30:41PM -0400, Christopher Faylor wrote:
> This patch looks good to me but I'm not in a position to test it much.
> 
> Corinna, how does it look to you?

I checked it in as is.

Mark, could you please add a ChangeLog entry as the following next time?

=====
Fri 20 Jul 2001 09:15:00  Mark Bradshaw <bradshaw@staff.crosswalk.com>

        * dir.cc (readdir): Protect FindNextFileA against INVALID_HANDLE_VALUE.
=====

Thanks for tracking that down and the patch,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
