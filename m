From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Solve a problem triggered by duplicate names in /etc/passwd.
Date: Wed, 25 Apr 2001 05:54:00 -0000
Message-id: <20010425145439.T23753@cygbert.vinschen.de>
References: <s1ssnixnodp.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00160.html

On Wed, Apr 25, 2001 at 09:40:50PM +0900, Kazuhiro Fujieda wrote:
> The last patch of mine against `mkpasswd' can't solve another problem
> triggered by the duplicate entries of Administrator in /etc/passwd.
> The uid of processes executed by the local Administrator always
> becomes the uid of the domain Administrator (10500).
> 
> The following patch can solve this problem.
> 
> 2001-04-25  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* uinfo.cc (internal_getlogin): Return pointer to struct passwd.
> 	(uinfo_init): Accommodate the above change.
> 	* syscalls.cc (seteuid): Ditto.

Thanks, applied.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
