From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: rmdir says it isn't a directory about a read only directory.
Date: Thu, 25 May 2000 12:49:00 -0000
Message-id: <20000525154916.A21792@cygnus.com>
References: <s1sog5vw1l3.fsf@jaist.ac.jp> <392D003F.81A81CA8@vinschen.de> <20000525133109.A2490@cygnus.com> <392D752E.F7F13BBB@vinschen.de>
X-SW-Source: 2000-q2/msg00087.html

On Thu, May 25, 2000 at 08:47:10PM +0200, Corinna Vinschen wrote:
>Yes, in fact there's a good reason:
>
>The (needed) use of GetFileAttributes a few lines above has let me
>overlooked that.
>
>Will you check that in?  You already have the patch.
>
>Chris Faylor wrote:
>>Is there any reason why we can't use the 'fileattr' element of the
>>path_conv class rather than calling GetFileAttributes again?

Done.

cgf
