Return-Path: <SRS0=8NMK=ZQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id D62D23857810
	for <cygwin-patches@cygwin.com>; Thu,  3 Jul 2025 10:53:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D62D23857810
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D62D23857810
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751540021; cv=none;
	b=WeTAd5/yxNeliD0ifjhnAKFUtLbjXKgA4I0oYulE9bHEt+zRL8vTZr0XuudD4pxiokCse5EkJfqWGTNCG10ngnd5N6thvFnXyiGKxk33L4EEHqIcEqbZTHTpt4lEbwZXsc3Q0A8u+Bs67fw74r24X71j4tlFcB3aUUWAntSRO+I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751540021; c=relaxed/simple;
	bh=h8Qz7NRF0lIOUpT1VhGfbuto23ovYKDb1b0y+Umzol8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qkmQPpQ8q8fwPW2kusrBjFulqvwYUOdPWC1S0lw+WMVowsamHkRCy4j/axVHDD9A3/WR9zQEo7KO+cd4HSMJrnij61I/KkB6rOBzwA/Zr2qMaCI5Ig2r/P46HSPTbrj6mszcmNGEyVRjl4swdfz5ee9xRgMrwGtALwFCiNhj7MY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D62D23857810
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZUg/IFd1
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20250703105337794.QVRX.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 3 Jul 2025 19:53:37 +0900
Date: Thu, 3 Jul 2025 19:53:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
Message-Id: <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
In-Reply-To: <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
	<9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
	<20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
	<259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1751540017;
 bh=F220vOH2f8DEeSU//9V1y5FrpCvI+tcsDvhigj2LiRU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZUg/IFd15RSP5/cH0H88I/2eYmYsGO63ZVyf8wkAMrnEvpvsvaDVVg4i2Dwb/R/dvOMzp9xg
 Km9GzQs0QAJZBTPmYBAIR6YWxtUnhLkv1PLqjFtR+SZnuf/epfUvoegU2/Q2YZnKQWlZbXntVD
 BFs8VsuwW1GIIolqUKSRcPY5JLeTI9BlqzpUMYCB/u+p0HMxmSewMA8nUDm6egxka2kTc0CTvZ
 cEYcmDB4/KNO7L6jAeMcZwQvMh6POZ/X0kXazhIsPEtn90DHAzqKmkfLetQ28FaUKzLouFYITr
 St4JRpAbh/Fz1v2sBdsMGZz3Vpwj9TWKy2S8G3zEIR3BRX/Q==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 3 Jul 2025 11:15:44 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 3 Jul 2025, Takashi Yano wrote:
> 
> > On Tue, 1 Jul 2025 14:01:45 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > 
> > > thank you so much for this patch! I released a new Git for Windows
> > > version including it:
> > > https://github.com/git-for-windows/git/releases/tag/v2.50.0.windows.2
> > 
> > I noticed this patch needs additional fix.
> > Please apply also
> > https://cygwin.com/pipermail/cygwin-patches/2025q3/014053.html
> 
> Thank you for the update!
> 
> I am curious, though: Under what circumstances does this patch make a
> difference? I tried to deduce this from the diff and the commit message
> but was unable to figure it out.

In my environment, the command
cat | /cygdrive/c/windows/system32/ping -t localhost
in Command Prompt cannt stop with single Ctrl-C.
ping is stopped, but cat remains without the sencond patch, IIRC.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
