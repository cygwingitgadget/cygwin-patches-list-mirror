From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Cygwin Patches <cygwin-patches@sources.redhat.com>
Subject: Re: [PATCH] syscalls.cc for statfs/df under Win9x problem
Date: Tue, 13 Mar 2001 08:28:00 -0000
Message-id: <20010313172752.I569@cygbert.vinschen.de>
References: <20010313155155.C569@cygbert.vinschen.de> <0GA5006AG8XLMZ@dgismtp03.wcomnet.com>
X-SW-Source: 2001-q1/msg00183.html

On Tue, Mar 13, 2001 at 09:10:29AM -0700, Mark Paulus wrote:
> Yes, I did try it with UNCs, and it works fine.  I was having a 
> problem with the GetDiskFreeSpace() working correctly
> with UNC's, but GetDiskFreeSpaceEx() works great.

Ok, thanks for clarifying this.

> I will follow up on the rights assignment document.  I guess that
> will put this on hold for now...
> 
> And I will fix the formatting issues when I re-submit the patch,
> after I get the assignment taken care of.

I'm looking forward,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
