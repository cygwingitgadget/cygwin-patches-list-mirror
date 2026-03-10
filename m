Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:29])
	by sourceware.org (Postfix) with ESMTPS id D3B974B9DB52
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 10:18:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3B974B9DB52
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D3B974B9DB52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773137912; cv=none;
	b=Z1Waen5mIXm9UHWo/Uu6/bfy2fUDeTvbZl2T8fPhda4Mthn6VTA+gDadusFsK8GoB/zJa8BpjxB2uX4nBj6TOAYKXv4mOi5YXNgCCgaO0iUSXRNqGKLFJQhB/CsifmpfolmN8EECyFpFpHk+rq8ciCt52bH12+BVqh8KEwn81nM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773137912; c=relaxed/simple;
	bh=hEkxr10VCzhQKF85hqFsH7AcmVPEJ+Lv4wbgUxQ5S4Y=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=R2B52KQvtE3a7QHAAd1FJXZbizk4agLtNHnmiSjOvb0UXkcWNY2b81HOnXljebxBeaNIwa493AmFVOkJxeHltkbYSwcMcsbQ5wszNDBvrpY5k/R+JP8Q0UPkYPN89beRRr+nlnyTHm2sK4XnqE58qeKPYeImF2Z3moiHY3hZBcw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3B974B9DB52
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=DHwIWf1v
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260310101829903.NOCQ.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 19:18:29 +0900
Date: Tue, 10 Mar 2026 19:18:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] A few fixes for signal
Message-Id: <20260310191827.a6fd63c877d2999652760049@nifty.ne.jp>
In-Reply-To: <CALWcw=EXF-MgsJ+=GYuVwUeQdAdKsxsSPu=J_KNvavCm6mGnKQ@mail.gmail.com>
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
	<CALWcw=EXF-MgsJ+=GYuVwUeQdAdKsxsSPu=J_KNvavCm6mGnKQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773137909;
 bh=6mtyOs22kbOCuEAc64jAebI2vDnl+JeGz3F2Tao8tFY=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=DHwIWf1vDQCIuAJQGMIn+Cm27oA2+aqXw7TFlb/TL0OC5nVdGdxR9EZBm9bc+fRLByIcpISI
 ZGTmygo9kJybkhN6bO0BsRZbSPhFICvKidp5NwPmXW8PpXZtlk3EvJ+74ew2UewomS+nrTJysk
 DX+D2lq83j4uelMneSVGOWGDa+1gMdQALi1T1KnmYmZEZ/xzi7ZmneZDdE/5b7CBbr07olvvJi
 F3+8Fk+yJolHK4OcfWGyt2OmNQL8/uEfRfjsQTk5HzlmVuC2NAP+ocV7uZXMhxWit7NfjHjBw2
 fbrGqzh7XyD/ZF/UT79xZ3uVpjsuvAbjFhy3kgnLuZLOh/jg==
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 10 Mar 2026 10:39:05 +0100
Takeshi Nishimura wrote:
> On Tue, Mar 10, 2026 at 9:51 AM Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> >
> > Takashi Yano (3):
> >   Cygwin: signal: Wait for `sendsig` for a sufficient amount of time
> >   Cygwin: signal: Do not wait for sendsig for non-cygwin process
> >   Cygwin: signal: Implement fake stop/cont for non-cygwin process
> >
> >  winsup/cygwin/exceptions.cc | 19 ++++++++++++++++++-
> >  winsup/cygwin/sigproc.cc    |  8 ++++++--
> >  winsup/cygwin/spawn.cc      |  2 +-
> >  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> What if the non-Cygwin process is MSYS2, or UWIN?

They are simply non-cygwin process for CYGWIN, even though they have
signal handling. Cygwin cannot interoperate with them.

Cygwin signal works only the processes that loads the same cygwin1.dll.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
