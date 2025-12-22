Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F31294BA2E05; Mon, 22 Dec 2025 10:48:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F31294BA2E05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766400491;
	bh=n2Wsz9d2u44E9p00X90aTBdeDwMI/uXSai6GwtnhAno=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=K/BZ3pwbalFwZ8JMxZxm83PrL+XBDPW80SKgtqzVamANkYohd8OMZh+bU6XzhJwCe
	 vrBlnSBV1qDPB/R4epDyWce8VOadGPrXHK6PNEqSd8Nkd8YL9zhomMCYMB9EOL/JVa
	 AL9cZdlN8xWPEY8qxThG9jTCCChs6V9in3YTP0qE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 25E52A80D4B; Mon, 22 Dec 2025 11:48:09 +0100 (CET)
Date: Mon, 22 Dec 2025 11:48:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Refactor workaround code for pseudo
 console output
Message-ID: <aUkh6WFkebCZl5YN@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251219131732.1433-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251219131732.1433-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 22:17, Takashi Yano wrote:
> Currently, there are four separate workarounds for pseudo console
> output in pty_master_fwd_thread. Each workaround has its own 'for'
> loop that iterates over the entire output buffer, which is not
> efficient. This patch consolidates these loops and introduces a
> single state machine to handle all workarounds at once. In addition,
> the workarounds are moved into a dedicated function,
> 'workarounds_for_pseudo_console_output()' to improve readability.
> 
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pty.cc | 301 +++++++++++++++++-----------------
>  1 file changed, 147 insertions(+), 154 deletions(-)

There's just one typo missing, but you don't have to send a new version for
that:

> +	  /* Workaround for rlwrap in Win11. rlwrap treats text between
> +	     NLs as a line, however, pseudo console in Win11 somtimes
                                                             sometimes

> +#define CSIH_INSERT "\033[H\r\n"
> +#define CSIH_INSLEN (sizeof (CSIH_INSERT) - 1)
> +[...]
> +#define CONSOLE_HELPER "\\bin\\cygwin-console-helper.exe"
> +#define CONSOLE_HELPER_LEN (sizeof (CONSOLE_HELPER) - 1)

My personal preference would be to define these macros prior to the
function, but that's a style question I'm not sure we should enforce.
Whatever makes more sense to you. 

Other than those, LGTM. In terms of the macros, no new version required,
just go ahead, whether you move them or not.


Thanks,
Corinna
