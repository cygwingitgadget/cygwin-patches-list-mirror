From: Corinna Vinschen <corinna@vinschen.de>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: rmdir says it isn't a directory about a read only directory.
Date: Thu, 25 May 2000 03:35:00 -0000
Message-id: <392D003F.81A81CA8@vinschen.de>
References: <s1sog5vw1l3.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00084.html

Kazuhiro Fujieda wrote:
> 
> rmdir() sets ENOTDIR to the errno about a read only directory
> like the following.
> 
> $ mkdir aaa
> $ chmod -w aaa
> $ rmdir aaa
> rmdir: aaa: Not a directory
> 
> The following patch can fix this problem.
> 
> 2000-05-25  Kazuhiro Fujieda <fujieda@jaist.ac.jp>
> 
>         * dir.cc (rmdir): Correct the manner in checking the target directory.

Patch applied.

Thank you,
Corinna
