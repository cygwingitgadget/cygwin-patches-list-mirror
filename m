From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFD, PATCH]: Set "hidden" attribute when creating files/dirs/symlinks with trailing dot
Date: Mon, 12 Nov 2001 03:18:00 -0000
Message-ID: <20011112121756.H2618@cygbert.vinschen.de>
References: <20011112014116.B2618@cygbert.vinschen.de> <20011112024721.GB28017@redhat.com> <002501c16b28$38f79ca0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00202.html
Message-ID: <20011112031800.8j0vCb083IJKGXXAzPGCkSDHaXmJof9XHCNQcsigPgM@z>

On Mon, Nov 12, 2001 at 02:15:02PM +1100, Robert Collins wrote:
> I don't like it. If I'm browsing the cygwin directory tree via explorer,
> I should see everything by default - otherwise _why_ am I browsing that
> tree?

Hmm, you don't like it and that's ok but the question "why am I
browsing...?"  is somewhat confusing.

When you "browse" a tree using `ls' it's the same situation.  If
you don't like ls to hide the hidden files (beginning with a dot),
you give the option -a.  In Explorer it's the same situation.  If
you don't like Explorer to hide the hidden files (having the HIDDEN
attribute) you set the option "Show hidden files and folders".
So, what's the difference?  In both cases it's a user decision.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
