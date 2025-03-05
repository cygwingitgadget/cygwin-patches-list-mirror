Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9D4D53858C48; Wed,  5 Mar 2025 19:00:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9D4D53858C48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741201240;
	bh=q1K19c7HPxPMlT85QXMn1Rn7+A72fjTy+Qe4WQOeRWI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=o+vUzI6DQiSrJ4Z/AJFGMYL4930A6lAfpPBWu8f2Vnuz3QXnVP4Q3aFuqAndZhHLo
	 NyLupd8ykEIDFd4WSVohWL4ZnTR4N3oMvAbOEQJGpU4jxV8B9Xfdy43ySy0qtbrlUs
	 IAKpJIM/8xV7cXEt/yWsE4wn3ZmsxDNxGKw/MKTg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 37395A804B1; Wed, 05 Mar 2025 20:00:33 +0100 (CET)
Date: Wed, 5 Mar 2025 20:00:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix 'lost connection' issue in scp
Message-ID: <Z8ifURy5B8kF3Qjm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250305143420.6703-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250305143420.6703-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  5 23:34, Takashi Yano wrote:
> When transferring huge file using scp, the "lost connection" error
> sometimes happen. This is due to fhandler_pipe_fifo::raw_write()
> accidentally sends data that is not reported in th return value when
> interrupted by a signal. The cause of the problem is that CancelIo()
> responds success even if NtWriteFile() already sends the data.
> 
> The following testcase using plain Win32 APIs reproduces the issue.
> The output will be something like:
> W: 8589934592
> R: 9280061440
> Much more data was received than the sender thought it had sent.
> [...]
> Addresses: https://cygwin.com/pipermail/cygwin/2025-January/257143.html
> Fixes: 4003e3dfa1b9 ("Cygwin: pipes: always terminate async IO in blocking mode")
> Reported-by: Jay M Martin <jaymmartin_buy@cox.net>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc | 28 ++++++++++++++++++++--------
>  winsup/cygwin/release/3.6.0    |  3 +++
>  2 files changed, 23 insertions(+), 8 deletions(-)

Great job, go for it!


Thanks,
Corinna
