From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: patch for cygpath
Date: Tue, 07 Aug 2001 10:05:00 -0000
Message-id: <20010807190516.D28586@cygbert.vinschen.de>
References: <C2D7D58DBFE9D111B0480060086E963504AC5262@mail.gft.de> <20010807115941.F27996@redhat.com>
X-SW-Source: 2001-q3/msg00070.html

On Tue, Aug 07, 2001 at 11:59:41AM -0400, Christopher Faylor wrote:
> I don't have much of an opinion on this patch however it seems to
> needlessly complicate cygpath for minimal gain.
> 
> I also don't see why cygpath would need to output the windows version of
> windows/system.  That sort of bypasses the "cyg" part of things.
> 
> However, I'm willing to be overruled if people have a strong opinion
> about this.

I think the patch is ok. The -W and -S options are not symmetrically
as it's for the rest of the path handling and the patch changes that.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
