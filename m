From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH]: Extend ntsec behaviour
Date: Wed, 25 Apr 2001 03:41:00 -0000
Message-id: <20010425124055.N23753@cygbert.vinschen.de>
References: <20010425122030.L23753@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00157.html

On Wed, Apr 25, 2001 at 12:20:30PM +0200, Corinna Vinschen wrote:
>   But we can do this by ourselves. So my change results in the following
>   process token, assuming that I have set the admins group as my primary
>   group in /etc/passwd:
> 
>     User:
>     	S-1-5-21-1644491937-764733703-1343024091-1001  <- Yep, that's me
> 
>     Owner:
>     	S-1-5-21-1644491937-764733703-1343024091-1001  <- :-)
> 
>     Primary Group:
>     	S-1-5-32-544 :-)
> 
>     Suplementary Groups:
> 	S-1-5-21-1644491937-764733703-1343024091-513
> 	S-1-1-0
> 	S-1-5-32-544
> 	S-1-5-32-545
> 	S-1-5-5-0-170088991
> 	S-1-2-0
> 	S-1-5-6
> 	S-1-5-11
> 
>   As an interesting extension, I can set my primary group now to
>   each group which is in the tokens supplementary group list in
>   the running process by calling `setegid'.

I forgot to mention two interesting facts:

- This change is inherited to subprocesses even if they are non
  Cygwin process. That means, if you exec a native Windows tool
  it will create files with the owner and group set as in the
  process token. It's nice to see a native Windows tool behaving
  as if ntsec is on for it...

- The ability to set the real NT primary group by `setegid'
  allows implementing the newgrp(1) and sg(1) commands.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
