From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: uid and gid for domain accounts.
Date: Sun, 15 Apr 2001 07:12:00 -0000
Message-id: <20010415161230.T20490@cygbert.vinschen.de>
References: <s1sofu2oyxc.fsf@jaist.ac.jp> <3AD5E2A6.A0B35CD1@yahoo.com> <s1slmp5q390.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00066.html

On Fri, Apr 13, 2001 at 05:20:27AM +0900, Kazuhiro Fujieda wrote:
> >>> On Thu, 12 Apr 2001 13:15:18 -0400
> >>> Earnie Boyd <earnie_boyd@yahoo.com> said:
> 
> > Sounds great, when can we expect the patches?
> 
> Just now.
> 
> 2001-04-13  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* mkgroup.c (enum_groups): Use RID + offset specified an additional
> 	argument as ID.
> 	(usage): Add description of -o option.
> 	(longopts, opts): Add specifications of -o/--id-offset option.
> 	(main): Add -o option. Invoke enum_groups with specified offset.
> 	* mkpasswd.c (enum_users): Just like mkgroup.c.
> 	(usage, longopts, opts): Ditto.
> 	(main): Add -o option. Invoke enum_users with specified offset
> 	only against domain accounts.


Thanks Kazuhiro, I have just checked it in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
