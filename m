From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Patch to syscalls.cc for statfs/df problem
Date: Fri, 09 Mar 2001 14:32:00 -0000
Message-id: <20010309233237.T3079@cygbert.vinschen.de>
References: <0G9Y00NJI7BV1O@dgismtp04.wcomnet.com>
X-SW-Source: 2001-q1/msg00162.html

On Fri, Mar 09, 2001 at 01:52:07PM -0700, Mark Paulus wrote:
> Enclosed is a patch to syscalls.cc which enables the use of
> the GetDiskFreeSpaceEx call in statfs().  It seems to work
> in my environment, except for one small problem.  It appears 
> that under WinME, it does not recognize the free space of 
> network mounted drives that have over 2GB of free space:
> e.g.
> 
> in dos:
> net use j: \\server\use
> 
> in cygwin:
> mount j:/ /jdrive
> 
> if you then do a df, and J: has more than 2GB free, then 
> it will show:
> Filesystem           1k-blocks      Used Available Use% Mounted on
> j:                     2097120         0   2097120   0% /jdrive
> 
> However, from the testing I have been able to do, it appears
> this is a failure of the GetDiskFreeSpaceEx call...

Hmmm, that's an interesting one. Is the network drive somehow
using quotas, perhaps?

Another one. Did you try your patch with UNC paths? I'm asking
because MSDN states that UNC paths must end with a backslash
when using this function (\\server\share\). It would be really
nice if you could have a look.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
