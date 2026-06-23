Return-Path: <SRS0=gf06=ET=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 927A14BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 07:41:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 927A14BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 927A14BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782200468; cv=none;
	b=jd8M0e0jTLcuyp4lWBKXSPLYLL09ovPyj1FEKeRFIF3xLhDYd1bJasLgX+YiOx/U+sqq9kmkUhp5YTHrMrCCr13t207GORK9CfdeylLgM0L/V6S9k5cyzpIIYiDnbJEdsxg2yDzNYxfyoCv7nu4ZRLp6P+ILKRNKeyA1oqM3beE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782200468; c=relaxed/simple;
	bh=OwF8wBtwP4/xKAG5u5nvgq26WNDArQNuQ8+PhN0Hlfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Jw38bSv2BaspRBLNPOq6PGHvKc2mrH/2PZgdtRhqwZNq+qW26jp8VeioPPxVY1sqxYhvfjSfRcdwGXGnp+f6A9CN7zaain9Uau1psA6k4SUNV9aGUz2Z6MbS7/gOTylyQPtT+9BPK2ZnW2e0DE4/T2F0IJ3kxPxKDRJMd7nyEeA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 927A14BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65N7uA1Q017308
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 00:56:10 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdpgyNU4; Tue Jun 23 00:56:05 2026
Message-ID: <e24b66b2-4518-4fff-8b05-1fb349a1b491@maxrnd.com>
Date: Tue, 23 Jun 2026 00:41:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in
 transfer_input()
To: cygwin-patches@cygwin.com
References: <20260612124728.38921-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260612124728.38921-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/12/2026 5:47 AM, Takashi Yano wrote:
> In transfer_input(), CR and NL in the data transferred to nat-pipe
> is treated as follows:
>    1) If pseudo console is activated, convert NL to CR.
>    2) If pseudo console is disabled, convert CR to NL.
> This conversion is necessary to ensure non-cygwin apps can handle
> CR/NL as expected. Therefor, CR and NL should be treated as the
> same way in accept_input() if the data is sent to nat-pipe.

The above block is fine.

> Usually, when pseudo console is activated, the input data for non-
> cygwin app is not treated by accept_input. However, accept_input()
> handle the input data in pseudo console enabled mode, only in a
> very short duration when pseudo console is about to setup, because
> master::write() calls line_edit() in the pcon_start mode. If pseudo
> console is disabled, accept_input() handles them, however usually
> ICRNL flag is set, so line_edit() do this conversion. However, if
> this flag is not set, the conversion added by this patch is needed
> as well.

This block I'm having a bit of trouble to follow.  Can you possibly 
reword to describe it in more orderly fashion?

> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/pty.cc | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index ef79ea679..30918c2f3 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -690,6 +690,14 @@ fhandler_pty_master::accept_input ()
>   	  p = mbbuf;
>   	  bytes_left = nlen;
>   	}
> +
> +      char *p0 = p;
> +      if (get_ttyp ()->pcon_activated)
> +	while ((p0 = (char *) memchr (p0, '\n', bytes_left - (p0 - p))))
> +	  *p0 = '\r';
> +      else
> +	while ((p0 = (char *) memchr (p0, '\r', bytes_left - (p0 - p))))
> +	  *p0 = '\n';
>       }
>   
>     if (!bytes_left)

The code of the patch looks LGTM.  Let me know what you think about my 
comments when you can.

..mark

