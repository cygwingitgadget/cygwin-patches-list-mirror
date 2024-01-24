Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id ADA683858293; Wed, 24 Jan 2024 15:57:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ADA683858293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706111848;
	bh=g2nReTAQF32yHOQqXg8C8ZCXtCCTlhsX+OUHrmpVAeI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=D5r7JBprzjQ0Tl3rn+p4Z39PZCNLTqgWs4HcGxkXOmwlAAEcitsJof5j3ggY+i9iw
	 1BBGJNGaSu9zIePJr391dYtwlsMdmtWHOySX9YEFt/aoJDzKR37NpsrKOKI2QK/oGd
	 lNP78kPNyIuLX0LZo3sxiFgtCibPXxSvWddF8kXQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C2D14A80B93; Wed, 24 Jan 2024 16:57:26 +0100 (CET)
Date: Wed, 24 Jan 2024 16:57:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pthread: Fix handle leak in pthread_once.
Message-ID: <ZbEzZsNcGIF_vp-A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240124134448.39071-1-takashi.yano@nifty.ne.jp>
 <ZbEhVg3ApRhrWF1Z@calimero.vinschen.de>
 <20240124234807.2cb091ad7b315af944bbfe66@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124234807.2cb091ad7b315af944bbfe66@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 24 23:48, Takashi Yano wrote:
> On Wed, 24 Jan 2024 15:40:22 +0100
> Corinna Vinschen wrote:
> > (You don't have to CC me, btw., I only get the same mail twice then
> > and I look into this mailing list constantly anyway)
> 
> Perhaps, CC: is added automatically by git send-email if
> Reviewed-by: exists. I'll try --no-cc option next time.

No worries.  No reason for jumping through hoops, just for an extra
mail.


Thanks,
Corinna
