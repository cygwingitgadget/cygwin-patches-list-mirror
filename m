Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2008B3858D34; Wed, 27 Nov 2024 17:06:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2008B3858D34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732727168;
	bh=0VAqIU25Xu5Ria2SvxWyvF0LiaiU+T+MMWakc5XC8Gc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=CtSCJAtW3XUzJ2XjG1AcZ8G3Huo98828z4D4HnPO8c3wmWdzxj4ceJv7IiitSFEbo
	 s+GwQG6pJy/Y1AVui8shkUCgbjp6BNm3OYtOpdP+z9mJTdMgmEokXTjJn8pK2tzCtf
	 cNW2d2rr/nTKZ9pU9KW/GRwjZpr+7QDctU7GtHe8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 18A42A80E4D; Wed, 27 Nov 2024 18:06:06 +0100 (CET)
Date: Wed, 27 Nov 2024 18:06:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/7] Fix issues when too many signals arrive rapidly
Message-ID: <Z0dRft_uZx0Us36k@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
 <Z0dQaXYCFSet-Zv7@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0dQaXYCFSet-Zv7@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 27 18:01, Corinna Vinschen wrote:
> On Nov 26 17:54, Takashi Yano wrote:
> > Takashi Yano (7):
> >   Cygwin: signal: Fix deadlock between main thread and sig thread
> >   Cygwin: signal: Handle queued signal without explicit __SIGFLUSH
> >   Cygwin: signal: Cleanup signal queue after processing it
> >   Cygwin: signal: Optimize the priority of the sig thread
> >   Cygwin: signal: Drop unnecessary queue flush
> >   Cygwin: cygtls: Prompt system to switch tasks explicitly in lock()
> >   Cygwin: Document several fixes for signal handling in release note
> 
> For the time being, patches 1, 2 and 5 are already good to go.

Please push only to the main branch for now.  Let's cherry-pick
them to 3.5 only when finished.


Thanks,
Corinna
