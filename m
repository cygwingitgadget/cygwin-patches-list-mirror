Return-Path: <SRS0=YyD5=3S=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id C9EF63852221
	for <cygwin-patches@cygwin.com>; Fri, 18 Nov 2022 08:23:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C9EF63852221
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1668759783; bh=m2CbIBH1nUXYdezybBsqjJJg6HyVk77VfJraTWs0db0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=AHcULjSCgaLFUuMLgIZVpcj2Kvxcy9NfR9UdwMOKvZF2UVIab/GqqaMVBw9FZTDW1
	 ZKjSqKKJLmYCGbrknp0CfzKMteAb5w5QO0q0Tnmi29mRhoRAhd8h0NWNkhPyupchM3
	 vc0jHmjQAgFzMQIYz49FUKHH3CZrx3ll88Vl3rgMTqFtMCzrJsZvk5+J/EUnA1Dyoj
	 pMfqJJKBjHYSvFJoTgtak4ADnEIuFaIoPU8Zf0Kb6JnNp9d6dMGw1kiBvFzDNWBJFJ
	 zgSRg+pO0XTRx2sQKbMR2BAxQY4VN4SRgEpN7fvdgYK1GdfD8hhxS6VYBV0JbtEJVb
	 s32lrGKF/wMqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1pAcG41LMx-00yPnz; Fri, 18
 Nov 2022 09:23:03 +0100
Date: Fri, 18 Nov 2022 09:23:01 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: Re: [PATCH] Cygwin: pty: Fix 'Bad address' error when running 'cmd.exe
 /c dir'
In-Reply-To: <Y1ZazH6objN99mSz@calimero.vinschen.de>
Message-ID: <s1268p66-18rs-9q3r-07oo-11o128pp06po@tzk.qr>
References: <20221022053420.1842-1-takashi.yano@nifty.ne.jp> <6EED0655-71E5-43B4-988D-B5935AED8EC0@gmx.de> <20221022151247.1b1cf1e3fc13d4c3dabc2191@nifty.ne.jp> <n4on0p20-970q-8693-7n50-4q22370s7rr5@tzk.qr> <Y1ZazH6objN99mSz@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QzSV8cPgEE3deh8UaFTuniSyt/i4DevjOr7iltIH7Ry6K2VdvDw
 SSlp3mk8ke/h34Jz1W4BM2OxNfxZMQrM/o0OAuE36/SZGZOHgQuiO6B73oGbcs/jOxtv6sO
 YnaNA6LxeU65OnK4Nm2H/NAO2ErRmRkAGSKZxYdyntvA9XHzQyCJeNX1fIsOTjNZSEIeTwU
 DmyZrUObK0B290bTgezEQ==
UI-OutboundReport: notjunk:1;M01:P0:qd39JOJQrh0=;X20EH4P0cXyne/UvWjLajHTwsLs
 VNLM4W1rYIxoyhZIbRExzVAp8kI4bY8xIaHlgpGTm7ACj7NsWlbMSBOdTSoCnnCF8zAbXSUmM
 RzeqwmKE65SgtpomLMiMS8irnh8W1m8cGB3m+kmv254r9pijlUjj6F8ZodRArXthDsIiVSxwO
 kly/CF0KOx+PhzAeLBi+uhAeWH6p592iqt//KbHdZW00AOm1KS3w19NT93wXVN3HdrZrkgrdw
 OWYdbUz9Yoh2780+EmhC8aTeO7l4TlT60MzS5wc0TfwXB1oC92BeFeLInGI2ybEZ9eaPsl40b
 fKYe4pw2/idC4LdJwiCR0lvdXzWg44h7SkXBbXEKD81BW/jY4/Xg0A8mcQQ7m52zQzfkmSVSC
 z27okGne7DOPiXA29mtLDQrL+36CV/IprjQBZDN3So5BAgLJfA58vmgvBhT0EUMpAwdSILWyy
 nCCGXYroKKHJZomt7EsGnktQufLNqLYz1UZom7KMBvt62Ki8/pZOFHgjHeC1rTuYYlVfP3jwZ
 6RnYHKwxCZcYk+geShgBJtoT1MwjIjdHE621emUWGHfYtRB26v6tgstIsUYN6PcwpcVA1g1RV
 RpbrSjnqonud6CcNKTAfgRnH+Iqr25yuI40f1dNhrGDrxV+zdiZX3SWu6Qu30SXFDbWgdTRDq
 ZvUIpHPfDQqDjus8smVqs4q6++RHr0gKJqhLPRaFFCtd51QDp6M2JqIZVtsNX7fhkK64IZGvp
 L0pU+Nn/tGJ/qrxAofBqtYNzKLgl+Q/TdePOq8i17/bVKvzlBDmdfB5WxuixJ0Khu3J2vuAnl
 sA7MfHfrg/0WXBnmsZBSvyMB1dbO727Dv/maoXYscX6aEuzI1om78zkf2Nfd975DpygDkbu/y
 /Au2ydHupDJeZvZXsAHCw+IUBW6HtDOEZP0R1oiSWUkRT3huZcArnhCdaeogdIVl1ya6iJtFm
 TtliXg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 24 Oct 2022, Corinna Vinschen wrote:

> However, two points:
>
> - I'm wondering if the patch (both of yours) doesn't actually just cover
>   a problem in child_info_spawn::worker().  Different runpath values,
>   depending on the app path being "cmd" or "cmd.exe"?  That sounds like
>   worker() is doing weird stuff.  And it does in line 400ff.
>
>   So, if the else branch of this code is apparently working fine for
>   "cmd" per Takashi's observation in
>   https://cygwin.com/pipermail/cygwin-patches/2022q4/012032.html, how
>   much sense is in the if branch handling "command.com" and "cmd.exe"
>   specially?  Wouldn't a better patch get rid of this extra if and
>   the null_app_name variable instead?

I never understood why the pcon code was allowed to be so Hydra-like as to
sprawl into corners far, far beyond `winsup/cygwin/fhandler*`.

FWIW I would be in favor of getting rid of this special handling (unless
it causes a regression). Given the recent experience, I expect Takashi to
want to work on this without any interference from my side.

Ciao,
Dscho
