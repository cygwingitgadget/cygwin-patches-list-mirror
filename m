Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 64625386101D; Tue,  9 Apr 2024 21:24:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64625386101D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1712697891;
	bh=1LZuunWVJMQQTxNbNWVfvemCUanTvJLERHJMGBj31qs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=JU/2PSULZmcCJZWXWvHFlbI5nR17OTUGs2thwsM8BhvONQ/yfUawGj7EnUWTwbI6a
	 5GWHsIBNoWw2iAaVh1DmZLYPJY1wRsyQnJ4m45EKdpIl6Prkwu8WOOsZSR29w7Q8ds
	 J2r2SEMpCJTb6DmtebKwxbDq09SosCgf0ziBZgm4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C6A41A80DC7; Tue,  9 Apr 2024 23:24:49 +0200 (CEST)
Date: Tue, 9 Apr 2024 23:24:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc/<pid>/{cwd, root} links to <defunct> for cygrunsrv,
 daemons, and shells
Message-ID: <ZhWyIZYJVRrzmvJO@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0df79ac3-02ea-4180-8177-375407dee2a1@SystematicSW.ab.ca>
 <ZhU9yqAGCtJzcNGn@calimero.vinschen.de>
 <8180fe90-776b-4ba0-9752-09186a08d771@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8180fe90-776b-4ba0-9752-09186a08d771@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Apr  9 10:38, Brian Inglis wrote:
> On 2024-04-09 07:08, Corinna Vinschen wrote:
> > That's typically a permission problem.  On Linux you get something like
> > 
> >    ls: cannot read symbolic link '/proc/1/cwd': Permission denied
> 
> Thanks Corinna,
> 
> That now makes sense, as Cygwin ps -a and btop showed the processes,
> although procps and top did not, and other info is visible, I never thought
> about permissions as there were links, but I see from elevated admin sh:
> [...]
> so I think perms on these should be 440 or 550 not 444 or 555, but that may
> involve a lot of work to decide that for each entry?

Not really.  Have a look into fhandler/proc.cc, fhandler/process.cc,
etc.  We can add a permisions member to struct virt_tab_t and add
this as static info to every member in the list.  Doesn't sound overly
complicated to me (*nudge, nudge*).

Changing <defunct> to a "Permission denied" when trying to open a
virtual symlink may be a bit more involved, but maybe not very much.


Corinna
