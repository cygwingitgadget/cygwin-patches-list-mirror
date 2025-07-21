Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1D2233858D1E; Mon, 21 Jul 2025 13:58:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D2233858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753106287;
	bh=Fe/oaEiPCl6bu6Bufd3q+ua4HL97XNnH/cMMIscp8Wo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=QbMHNlOwb4F3FJqaAHgKY1BvQiHK4yR/lPdbCyNgHq2rb9LM69cOK6HJWRrokEI3J
	 yOKdos6A9PZY/y7uAhITj5MuvfBRzvyv43lERGGuf+m9OjcNakVlE2nBC+f2ih50s5
	 ZyqZtA2C3UkDUth0MCL3jPRHux3+CCRjHGpJcbjk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 55CE9A80DCD; Mon, 21 Jul 2025 15:58:05 +0200 (CEST)
Date: Mon, 21 Jul 2025 15:58:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] Cygwin: cygheap: Add locl()/unlock() method
Message-ID: <aH5HbW5DHssrkYXk@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
 <20250721134628.2908-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721134628.2908-2-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>


typo in the subject line: locl -> lock

On Jul 21 22:46, Takashi Yano wrote:
> ...so that cygheap can be locked/unlocked from outside of mm/cygheap.cc.
> 
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/local_includes/cygheap.h |  2 ++
>  winsup/cygwin/mm/cygheap.cc            | 22 +++++++++++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/cygheap.h b/winsup/cygwin/local_includes/cygheap.h
> index fed87ec2b..aa928bc55 100644
> --- a/winsup/cygwin/local_includes/cygheap.h
> +++ b/winsup/cygwin/local_includes/cygheap.h
> @@ -541,6 +541,8 @@ struct init_cygheap: public mini_cygheap
>    threadlist_t *find_tls (int, bool&);
>    sigset_t compute_sigblkmask ();
>    void unlock_tls (threadlist_t *t) { if (t) ReleaseMutex (t->mutex); }
> +  void lock ();
> +  void unlock ();

I'm sorry I didn't see this in my first review, but I have a suggestion:

Convert cygheap_protect to a static private init_cygheap member and make
lock/unlock inline methods.  No reason to have two function calls on the
stack.


Thanks,
Corinna
