Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 37B244BA2E09; Wed, 25 Mar 2026 19:24:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 37B244BA2E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774466646;
	bh=ijVgHTm1vvPBjPq5NsVLZfZre9Xi4qzoMm+XmYOuYjU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Apvh2sn4+F+GP7xBlwmSBwofqKbyEolRv2j5WTkRXCQSt/+D2YrVWrLqtJ4esqdJC
	 Es2kkg9O7FR9YZ6QULC+6BCMbHwnp/pT8TNBDEWx9i48WmTINK3FYJG3Ce6cSDFcs9
	 U7+86jQocCbH9u2cdk1K22kYzukzF19UgBGxy5W0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5C6A4A805DF; Wed, 25 Mar 2026 20:24:04 +0100 (CET)
Date: Wed, 25 Mar 2026 20:24:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Clear discard_input flag on master write()
Message-ID: <acQ2VPnZkh2TSNNd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260325130734.65955-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325130734.65955-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar 25 22:07, Takashi Yano wrote:
> Currently, the first transfer_input() after Ctrl-C does not work
> because discard_input flag remains asserted. This can cause loosing
> typeahead input for non-cygwin app after Ctrl-C. With this patch,
> the discard_input flag is cleared on master write() because the
> input is new valid input after discarding input.
> 
> Fixes: 4e16e575db04 ("Cygwin: pty: Discard input already accepted on interrupt.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 0c50e50f5..c05462d1f 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2224,6 +2224,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>  
>    push_process_state process_state (PID_TTYOU);
>  
> +  get_ttyp ()->discard_input = false;
> +
>    if (get_ttyp ()->pcon_start)
>      { /* Reaches here when pseudo console initialization is on going. */
>        /* Pseudo condole support uses "CSI6n" to get cursor position.
> -- 
> 2.51.0

LGTM.


Thanks,
Corinna
