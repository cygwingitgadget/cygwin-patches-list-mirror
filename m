Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D327C3858D20; Mon, 10 Mar 2025 10:12:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D327C3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741601574;
	bh=nIQ36TMtDUeDz8IkB2/z+kAtoFGaFlLEVUq30BxcXdw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kJGgMBiH7O0tgNf/aKrmYWIUgeoSocHTAvTwDjtSRugY2akxgnCSfkLF6+z/7K6+N
	 sseCTLUX5aUIAi/g17rNQIwhdT/ItWw8l+fBhBseqx7unAk1RRjgHkOwSqQD+GzXB9
	 FYPZzMetyZcXwjSM+NijK7h1IFA439nJwSkIYuLA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C9886A804D4; Mon, 10 Mar 2025 11:12:52 +0100 (CET)
Date: Mon, 10 Mar 2025 11:12:52 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setaffinity: fix EACCES if pid of other
 process is used
Message-ID: <Z867JCGV3NeaSqcl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <7a77c9b6-20e4-538f-4b8d-e91be879988f@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a77c9b6-20e4-538f-4b8d-e91be879988f@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Mar  8 14:24, Christian Franke wrote:
> This fixes:
> 
> $ taskset -p 0x1 1234
> pid 1234's current affinity mask: fffffff
> taskset: failed to set pid 1234's affinity: Permission denied
> 
> Perhaps older Windows versions were more relaxed if PROCESS_SET_INFORMATION
> is granted.
> 
> -- 
> Regards,
> Christian
> 

LGTM.  Btw., do you have push permissions?  From what I can tell,
you already have an account on sourceware and it looks like you have
push perms.  Is your .ssh key up to date?

Wouldn't you like to join our cygwin-developers IRC channel as well?
https://cygwin.com/irc.html


Thanks,
Corinna
