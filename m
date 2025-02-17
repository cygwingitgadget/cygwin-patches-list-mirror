Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DF3063858C50; Mon, 17 Feb 2025 10:08:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DF3063858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739786898;
	bh=ZuNcUcFMUNawiYH+cqnr6dXmEq+i8+56DsMEfLMqPAA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=q2P37SJljOOjcxxJH5VyrjARvxbowXyjXwDhPH4VCNqGf+ozsfgXp7Ff7JlMougtE
	 kPhe+3WBY/tY1F1tV4H4qgmzOWpkF/2F1dWkbF95a+eRk1SozhjiuYSFfMHc0J7nSK
	 0kKDuJlXii4yDO4cvCUwOhm/2bd/+zapox15cJzs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D96AEA817D5; Mon, 17 Feb 2025 11:08:16 +0100 (CET)
Date: Mon, 17 Feb 2025 11:08:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: WinAPI spawn() not used by Cygwin posix_spawn()? Re: [PATCH]
 Cygwin: Add spawn family of functions to docs
Message-ID: <Z7MKkIbgMh0C5snl@calimero.vinschen.de>
Reply-To: cygwin@cygwin.com
Mail-Followup-To: cygwin@cygwin.com, cygwin-patches@cygwin.com
References: <20250216214657.2303-1-mark@maxrnd.com>
 <CAPJSo4VH0MufLhpgPiD1GV1gFsbTLdtOKrP82eaA_Yv_DHPXEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPJSo4VH0MufLhpgPiD1GV1gFsbTLdtOKrP82eaA_Yv_DHPXEQ@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 16 23:33, Lionel Cons via Cygwin wrote:
> On Sun, 16 Feb 2025 at 22:47, Mark Geisert <mark@maxrnd.com> wrote:
> >
> > In the doc tree, change the title of section "Other UNIX system
> > interfaces..." to "Other system interfaces...".  Add the spawn family of
> > functions noting their origin as Windows.
> 
> re spawn() family: Cygwin posix_spawn() seems to rely on the rather
> inefficient vfork(), while Opengroup intended it to be an API to
> Windows spawn().
> 
> Is there a technical limitation why Cygwin posix_spawn() cannot use
> WinAPI spawn() directly?

The requirements of posix_spawn and their helper functions are so
that we can't easily fulfill them without doing the fork/exec
twist.

See https://man7.org/linux/man-pages/man3/posix_spawn.3.html.
Windows CreateProcess() is not quite the same as Linux clone().

However, if you think you can come up with a version only running the
spawnve function and thus speed up Cygwin, feel free to send patches.


Corinna
