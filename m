Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:23])
	by sourceware.org (Postfix) with ESMTPS id D94AC4BA2E18
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 19:38:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D94AC4BA2E18
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D94AC4BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:23
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772307510; cv=none;
	b=NcqY2S0xpjCSlXha9FT2rUJg3weWOElLWk++oLLD5xPvmuhnK3xFrkCs+y3UROiEIiSqoHO/6zcYOe9JuLbH76FPIL3tRqJxMabiGNVCMNJIEIwPI4A7kHnYv80B35k1Nk+j7M1udErSW0Z89EjwDFU+7yPJXkYAleXlbTfEGmE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772307510; c=relaxed/simple;
	bh=Sdt5vcRqym+aFd4bXR2sL/aOcRr4CHsPtTpYTR4fgBM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=MW665txV5+FcKpRLtfSdb+DzT3NZxyicrHvcRmDDej2XiCXShMeaAMifUPKD94waJSuAXNp4XdnfKlKQOTft4q1JHcqpcb8aaspfa4GCuE92ekQbw0h947lKiomQmUYYGn9CpNpv7YWJfqPShwMUIoBEndvOrxk3NOsUtZm+f1A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D94AC4BA2E18
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bCuxeyzj
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20260228193828060.ETXA.47114.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 1 Mar 2026 04:38:28 +0900
Date: Sun, 1 Mar 2026 04:38:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Improve CSI6n handling in pcon_start state
Message-Id: <20260301043827.b937d0fdb76ac24a48f5d22c@nifty.ne.jp>
In-Reply-To: <0a2f7645-9bee-4b99-a0a8-dd6552ee5dfb@towo.net>
References: <20260223080106.330-1-takashi.yano@nifty.ne.jp>
	<00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de>
	<0a2f7645-9bee-4b99-a0a8-dd6552ee5dfb@towo.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772307508;
 bh=Gcn6Mlx1dqWj4dlSnloB5C5aM/IFFQWL9xv1tbtzJs0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=bCuxeyzj3l/HTjA5AmwFiQoL+oDHjiPcXkfyOebfCcgDPvjGAygSzs15zV6LRaDXX9Wj4Mv6
 ox8C4gD8rCM6k2P+wfaTLnnwQvzQFunqZv31ikJigOwZj8On1sf0ZVXVtj0Ed1ESeEe2siqWTX
 i8kBsoju15y6J7NIAJeTZwVahGc7CVtOtICNYUXkbwlcVgfhx7C8GmGxTwlBF2K8PNZXKWx9d6
 L2rnBlv271nF9Ki0AYxBD8dR4GcWqbD3WSv5rpFd1b637sFb3MLEH3y5sRMfYZBehFhIAnzzmf
 FUW6lJTYLJeuA+IZAc5riWS0G4NjFM4HTxLlFzSuAFswty3Q==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Thomas,

On Sat, 28 Feb 2026 14:19:30 +0100
Thomas Wolff wrote:
> 
> Am 27.02.2026 um 18:58 schrieb Johannes Schindelin:
> > Hi Takashi,
> >
> > On Mon, 23 Feb 2026, Takashi Yano wrote:
> >
> >> Previsouly, CSI6n was not handled correctly if the some sequences
> >> are appended after the responce for CSI6n. Especially, if the
> >> appended sequence is a ESC sequence, which is longer than the
> >> expected maximum length of the CSI6n responce, the sequence will
> >> not be written atomically. With this patch, pcon_start state
> >> is cleared at the end of CSI6n responce, and appended sequence
> >> will be written outside of the CSI&n handling block.
> I encounter stray CSI6n when I invoke wsl.exe via execl(p) within a 
> forkpty child and I was puzzled why that occurs.
> Could it be related to this issue (and hopefully fixed by the patch)?

pty sends CSI6n to check if the terminal has CSI6n capability
before calling CreatePseudoConsole(). This is because,
CreatePseudoConsole() waits for CSI6n response forever so
it hangs if terminal does not respond to CSI6n. The check
result is cached, so the check will not be done in the second
time.

Isn't this the 'stray CSI6n'?

Do you have any problem with this 'stray CSI6n'?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
