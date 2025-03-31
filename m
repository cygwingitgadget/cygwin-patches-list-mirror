Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E9FCD3858D33; Mon, 31 Mar 2025 20:02:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E9FCD3858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1743451333;
	bh=2ExJxPq0lphccWO9vERTa+cq8Li1eV6/wceW0KNixKw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fg0ZyQLe0SFTyhLO3nHUcQ3grFMx6PXsoJNiyqJOFESic5Q2/lIVEzAgsdSY6R5hc
	 YqcFewZ9pd+nYV3yOxvjxrwefK6s+Mkl/szT4IotGPn6vUkCqeq4v5r+86p8U2nxRc
	 LaYtxTxR7/NP1Uy4xC3BdXSiSxpcoYnm5KVcviYE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1DCC3A80C9C; Mon, 31 Mar 2025 22:02:05 +0200 (CEST)
Date: Mon, 31 Mar 2025 22:02:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Mar 31 10:19, Corinna Vinschen wrote:
> Jeremy, I don't think you have push perms to the Cygwin repo.
> 
> If you want to push your own patches and are willing to review patches
> on this list occassionally (especially when I'm on one of my longish
> vacations), see the handy dandy little form at
> https://sourceware.org/cgi-bin/pdw/ps_form.cgi
> 
> Project should be Cygwin, approver is my email address I'm using in
> the Cygwin logs.
> 
> In terms of the current patchset, just tell me if you want to use it
> as test of your new rights on sware, or if I should push it for you.

Thank you, I approved your request on sware.  You now have
write-after-approval permissions, so please continue to send patches to
cygwin-patches first and wait for approval from Takashi, Jon or me.


Thanks,
Corinna
