From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: problems related to mount_info.
Date: Wed, 07 Jun 2000 14:58:00 -0000
Message-id: <20000607175753.E17648@cygnus.com>
References: <s1su2f5qmsh.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00095.html

This patch looks terrific.  You've made changes that I've been
contemplating for some time.

I'll install it once I've finished with the net release.

Thanks for all of your hard work.

cgf

On Thu, Jun 08, 2000 at 05:05:50AM +0900, Kazuhiro Fujieda wrote:
>The methods of the `mount_info' class operates mount entries in
>the registry without regularizing paths. I was amazed by this
>manner as the following.
>
>   $ mount
>   Device              Directory           Type         Flags
>   ...
>   C:\text             /text               user         textmode
>   ...
>   $ umount /text
>   umount: No such file or directory
>
>I failed to notice that I had created the mount entry as the
>following by mistake.
>   $ mount 'C:\text' /text/
