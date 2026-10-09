Return-Path: <SRS0=GLxl=H7=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id D144B4BA543C
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 04:38:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D144B4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D144B4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791520722; cv=none;
	b=IY6Hf8yhElCSRKnTomVu6zp58sfNTEs7dScrjTkcRKdFEN0d08ITm7/pQOJ79Yqj5yoHSzQiRafY/iw+ED+mx3ofr7ywmzbpDUwSvPsYHyx8BwP1g7+ZFjCcVtDawg5NsK23lqTcg2sOvlt/PFunId459GBY+BPa20JiGUfdvtc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791520722; c=relaxed/simple;
	bh=/OfP97YzvgZvFxwt9TtK8rWJPnaQ76yDyUswviB0OOY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vbiCQ/Rjb/y/ZtH7MOHnI6f9r1HWlDzS6QlEtX8zP1Qw+L1dgHzOsX4CtlO1xl6NqF33WlMjSyZ//2jAkb7JXiQRTFB3D7XKrQsksINFYiJ/vgu2qLy3cJUlce9FgEE+kGBqmudsQwBXnvgpnFMEGgoaAaQMzI6PKDs+jSEd558=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kjNEFJe8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D144B4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kjNEFJe8
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261009043837808.QVVE.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 9 Oct 2026 13:38:37 +0900
Date: Fri, 9 Oct 2026 13:38:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: sequencer: Implement /dev/sequencer
Message-Id: <20261009133836.b9c96eec087ebb9d54784b0e@nifty.ne.jp>
In-Reply-To: <d3b28759-be02-418b-af63-ef9d7169de42@dronecode.org.uk>
References: <20261007192542.1049-1-takashi.yano@nifty.ne.jp>
	<b087383d-0d79-4ecb-88a4-42b0fecf0602@maxrnd.com>
	<d3b28759-be02-418b-af63-ef9d7169de42@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1791520717;
 bh=zSWb3oGR7uAKqgpPIwTWSkje9Pd8Vx7Vw87VGjAHYlg=;
 h=Date:From:To:Subject:In-Reply-To;
 b=kjNEFJe8iyZ7s2FQRf2Y6Br5WUCBejBVcfjqRIUvUXDtlDwgWTLjZX/O4KbeYjNIOTfbrUv9
 W7KluvRoDBxkWJXr1CcNPubaUV6lU/9eXMtIP+3GMvfT9kqA7FJnsid1fLcxFJzFhjpZUl8kNg
 dd6oPD3T7OQhctZiaWa6PDTZuzkb2tkex51ZfhubgAD2DI/gpqaWlyKtF93m8eXJBdowk3JJaD
 4IAfQXSatm2tnvfOqFcJ9TVNkQBwHsB9rgBY2rOcjTDSu7uXEf00M34N7P6WY0nywiyo//MYYQ
 9TFe1GgQIJ/Ngr5ksypbb/sEQXe/SPI6x4/edLYHPnLeeddw==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark, Jon,

Thanks for having a look.

On Thu, 8 Oct 2026 11:29:41 +0100
Jon Turney wrote:
> On 08/10/2026 03:57, Mark Geisert wrote:
> > Hi Takashi,
> > 
> > On 10/7/2026 12:25 PM, Takashi Yano wrote:
> >> This is an experimental implementation of /dev/sequencer for the
> >> external MIDI devices. Currently, only output is supported.
> >>
> >> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> >> ---
> >> v2: Use archetype.
> >>
> >>   winsup/cygwin/Makefile.am               |   1 +
> >>   winsup/cygwin/autoload.cc               |   7 +
> >>   winsup/cygwin/devices.cc                | 847 ++++++++++++------------
> >>   winsup/cygwin/devices.in                |   1 +
> >>   winsup/cygwin/dtable.cc                 |   3 +
> >>   winsup/cygwin/fhandler/sequencer.cc     | 452 +++++++++++++
> >>   winsup/cygwin/local_includes/devices.h  |   1 +
> >>   winsup/cygwin/local_includes/fhandler.h |  53 ++
> >>   8 files changed, 954 insertions(+), 411 deletions(-)
> >>   create mode 100644 winsup/cygwin/fhandler/sequencer.cc
> > I'm not familiar with how Cygwin defines its devices so I may be out to 
> > lunch with this observation, but...
> > 
> > Isn't devices.cc built by cygwin/scripts/gendevices?  cygwin/Makefile.in 
> > seems to show that.  Maybe I'm oversimplifying what's really going on 
> > (and am, thus, out to lunch).
> 
> This is correct, but the file is checked in for "historical reasons".
> 
> (since it requires the obscure 'shilka' tool from the cocom package to 
> regenerate. In pre-git times I think it was possible do a build without 
> it, but the way git arranges timestamps prevents that).

What happens if devices.cc is removed from git repository itself?
Will anything problematic happen?

Anyway, for reviewer's convinience, I'll remove diff for devices.cc
from the patch. v3 will be available shortly.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
