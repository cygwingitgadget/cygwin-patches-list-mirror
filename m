From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Set default DACL in setup.exe
Date: Mon, 06 Aug 2001 16:51:00 -0000
Message-id: <20010806195145.A21578@redhat.com>
References: <20010807001602.N23782@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00065.html

On Tue, Aug 07, 2001 at 12:16:02AM +0200, Corinna Vinschen wrote:
>Hi,
>
>for reasons written about in cygwin-developers (see thread
>"Silly ACL problems") I have patched setup.exe to create
>all files with full access for everyone on NT/W2K as long
>as the parent directory doesn't define propagated permissions.
>
>This is done by changing the default DACL in the process token.
>
>Ok to check in?

Sure.

cgf
