Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 38FBB3858D34; Thu,  9 Jan 2025 19:19:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 38FBB3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736450396;
	bh=lgzX42RHuT2VLBUSO1K+Pu931PS5IVd7XiHR/B+dvoA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sATSew8Av1qlZI8PEmZA7IbL0fgjVkPERZYCuuIMU/NAw1BdEU9h7IStNocU30lrf
	 Xz18zW+SBs561x2l2HJzHFNzO6pnvtv5DBx0GL7Pqe3USLWsdqer0XkV3xOAodMmYK
	 lbw8xhst93g4YdkwKpbpiUAP7wN8qGUCc7cv7n/4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8EC2DA80C3B; Thu,  9 Jan 2025 20:19:54 +0100 (CET)
Date: Thu, 9 Jan 2025 20:19:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when
 __SIGFLUSHFAST is sent
Message-ID: <Z4AhWrXpbQYVZ4Gl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp>
 <Z36eWXU8Q__9fUhr@calimero.vinschen.de>
 <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
 <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Jan  8 18:05, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 9 Jan 2025, Takashi Yano wrote:
> 
> > On Wed, 8 Jan 2025 16:48:41 +0100
> > Corinna Vinschen wrote:
> > > Does this patch fix Bruno's bash issue as well?
> >
> > I'm not sure because it is not reproducible as he said.
> > I also could not reproduce that.
> >
> > However, at least this fixes the issue that Jeremy encountered:
> > https://cygwin.com/pipermail/cygwin/2024-December/256977.html
> >
> > But, even with this patch, Jeremy reported another hang issue
> > that also is not reproducible:
> > https://cygwin.com/pipermail/cygwin/2024-December/256987.html
> 
> Yes, this patch helped the hangs I was seeing on Windows on ARM64.
> However, there is still some hang issue in 3.5.5 (which occurs on
> native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
> seems to be somewhat reliable at triggering this, but it's hardly a
> minimal test case ;).

Can you perhaps bisect 3.5.5 to tell us which signal-related patch
exactly has introduced this specific hang?  It may give us a clue.


Thanks,
Corinna
