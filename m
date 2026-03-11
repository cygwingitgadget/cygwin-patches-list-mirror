Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 688DA4BB5886; Wed, 11 Mar 2026 15:13:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 688DA4BB5886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1773242011;
	bh=JgiV+YFCyfvxekSdRSDtav79jASb5OBsWwt9crQdM6Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OZzMzIAOvTVQfVBBTF9dSqo96N/akmhKfVAfbsd6Fs0nOzAms/TRCJgKvi4DespRR
	 OYqjLcV8AnCwnwgOs8092ZGrrDCHfo6ALMFfYhSPVMgf1Aib7IrhEjZgFJ18rMa0Lm
	 4B746q+G75DZqjrd+wezjRV3Hq+FLaMPql04fX5s=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7B123A806F4; Wed, 11 Mar 2026 16:13:29 +0100 (CET)
Date: Wed, 11 Mar 2026 16:13:29 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: signal: Implement fake stop/cont for
 non-cygwin process
Message-ID: <abGGmbr9b4_jkEB3@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
 <20260310085041.102-4-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310085041.102-4-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 10 17:50, Takashi Yano wrote:
> Currently, the following command in bash cannot make `cat | cmd`
> foreground correctly, and also cannot be terminated by Ctrl-C.
> 
>   $ cat |cmd &
>   $ fg
>   $ (Ctrl-C)
> 
> This is because, bash does not recognize the process `cmd` as stopped
> by SIGTTIN, and does not send SIGCONT not only to `cmd` but also to
> `cat`.
> 
> To solve this problem, this patch implements fake stop/cont for non-
> cygwin process such as `cmd`. Even with this patch, the process `cmd`
> does not enter into stopped state because non-cygwin process itself
> does not handle cygwin signal, the but stub process for `cmd` enters
                                 ^^^^^^^
				 but the?




> into stopped state instead by SIGTTIN.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/exceptions.cc | 19 ++++++++++++++++++-
>  winsup/cygwin/spawn.cc      |  2 +-
>  2 files changed, 19 insertions(+), 2 deletions(-)

Neat.  LGTM.


Thanks,
Corinna
