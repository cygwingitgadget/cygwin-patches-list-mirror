Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9471B3858CDB; Mon, 10 Mar 2025 13:57:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9471B3858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741615029;
	bh=1/Lu1uBQloSdjSLm+yXga6oJPzeA0kcrsgpz9N+FzOI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pD2gpHdx3aYAQTG2Ao+emQ9719SWoKXDYJXqgh7f1rmXi0RcAx58K80CJq7LqDcXT
	 7F83gDlziAv7B8oaw46wMvYdtWEz6ixPM/jKKzl7cHFu2EXKd7g9lyf623gM2Vdx9T
	 nkAwVs3yoY6Q5VoDh13lykhtsHoRbUqM6lgQgMEs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 627EDA8057B; Mon, 10 Mar 2025 14:57:07 +0100 (CET)
Date: Mon, 10 Mar 2025 14:57:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setaffinity: fix EACCES if pid of other
 process is used
Message-ID: <Z87vs2ZjpkjGSScg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7a77c9b6-20e4-538f-4b8d-e91be879988f@t-online.de>
 <Z867JCGV3NeaSqcl@calimero.vinschen.de>
 <1f697dc3-003d-42d5-5a09-8095f3824446@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f697dc3-003d-42d5-5a09-8095f3824446@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar 10 13:47, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Mar  8 14:24, Christian Franke wrote:
> > > This fixes:
> > > 
> > > $ taskset -p 0x1 1234
> > > pid 1234's current affinity mask: fffffff
> > > taskset: failed to set pid 1234's affinity: Permission denied
> > > 
> > > Perhaps older Windows versions were more relaxed if PROCESS_SET_INFORMATION
> > > is granted.
> > > 
> > > -- 
> > > Regards,
> > > Christian
> > > 
> > LGTM.  Btw., do you have push permissions?  From what I can tell,
> > you already have an account on sourceware and it looks like you have
> > push perms.  Is your .ssh key up to date?
> 
> I got push permissions to (at least) Cygwin setup repo in August 2022, but
> apparently the ssh login no longer works. The debug output shows that the
> correct (3072 RSA) pubkey is passed.

You were moved to an inactive state due to, well, inactivity.

I just asked the sware overseers to move you back to active.  You should
be able to push your patch now.

> > Wouldn't you like to join our cygwin-developers IRC channel as well?
> > https://cygwin.com/irc.html
> 
> Possibly, but need to refresh my knowledge first as it's been a long time
> that I used IRC - IIRC 20+ years :-)

Well, we pull you through ;)


Thanks,
Corinna
