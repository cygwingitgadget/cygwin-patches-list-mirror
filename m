From: Chris Faylor <cgf@cygnus.com>
To: Corinna Vinschen <corinna@vinschen.de>
Cc: cygpatch <cygwin-patches@sourceware.cygnus.com>
Subject: Re: symlink changes
Date: Fri, 31 Mar 2000 12:05:00 -0000
Message-id: <20000331150508.F1576@cygnus.com>
References: <38E4F407.3AB20C82@vinschen.de>
X-SW-Source: 2000-q1/msg00030.html

On Fri, Mar 31, 2000 at 08:52:55PM +0200, Corinna Vinschen wrote:
>- The other problem was that in chown the path was evaluated with
>  SYMLINK_FOLLOW. This isn't the same behaviour as under linux.
>  I have patched it, so that now a chown on a symlink changes
>  user/group of the symlink instead of the linked file, equal to
>  linux. This is done by using SYMLINK_IGNORE as parameter to
>  path_conv.

I believe that linux has an "lchown" call as well as a "chown" call.
I'd prefer to implement lchown and leave chown alone.  It would also
be nice to implement fchown (and fchmod?) while we're at it.

cgf
