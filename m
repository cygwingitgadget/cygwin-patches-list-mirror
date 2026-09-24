Return-Path: <SRS0=CSO5=HQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 29D324BB3BEE
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 11:57:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 29D324BB3BEE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 29D324BB3BEE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790251062; cv=none;
	b=DHdjb7cVRr7y0FjwkFzFXFk1INLcrHKo8FG1plt0Y/zETGhDdybFCYkpBWujk56K1wkvd3T5yy5jo9W2rT3Yp9l6+fugGygVIydE1soWNrLB+HSqiFlzBqaYuhmFD7zXJ0BO86jhEL30i4E6kFKvPkYX0iQAT4noOknVeysiBtg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790251062; c=relaxed/simple;
	bh=LMWyK992mvuMqL9hBFCwG9E31sNq+flroFLCrOcoeMk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=M6wxzR/vL202q1YUBjuiXZ+dSZbZ2/gfi4KHxgrSAMaJ7/3TIEa/09CpF6xp7zDLkMR5YN/DgTrtiNSRnl5TMI3+4GiPJyHCrlUNxZAgGaztfSndJYc9iwurfZ/TGer9OJ4VRUarDtBFpJ7bk37XjMQzcVdIBNtdMOM/kCwSvrM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LkR90bqJ
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 29D324BB3BEE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LkR90bqJ
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260924115736139.PGSV.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 20:57:36 +0900
Date: Thu, 24 Sep 2026 20:57:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: console: Abort setting disable_master_thread
 when no con.owner
Message-Id: <20260924205734.63288b0bc8a3a26a79d9cc4a@nifty.ne.jp>
In-Reply-To: <4acddc15-292c-f7bd-10d2-ecc055176f23@gmx.de>
References: <20260923223230.3504-1-takashi.yano@nifty.ne.jp>
	<4acddc15-292c-f7bd-10d2-ecc055176f23@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790251056;
 bh=4dK8v/oCAgFxX+95HwQdzjiDX0sPiSuoiYZobmPAYq0=;
 h=Date:From:To:Subject:In-Reply-To;
 b=LkR90bqJJgU864U33A5jWZWHx6s2X1XgksAbPpblnXf94fk9I+Dj6riOEeHsdBvTVylWB2Y/
 ndFcNb/cJ8HCLC7T78FkX5sdlMBjBlOyUNJv6YXDDlC5Wp1KsH05GIxzVtNTojWmC8hGRutEya
 ZylN0iKXoqnx2WUWhK4Y1ejUZeFX33sB6Wo9F9jMX7yq3qSAlAz7hYf+ENcsvtM7rpuEfvOoo9
 mILlwZKFjI7WtOOdxQEMomyPKur6C9bu63GSbTv1I47y8OFach3Iein/liuXqxBvwAjm4yMyqn
 VUDT2HUOVJXFax+PYYcM+n2RdmmcARy4CG09za6qBMpAlaNA==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Thu, 24 Sep 2026 09:47:19 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 24 Sep 2026, Takashi Yano wrote:
> 
> > With the commit 733d5a953fa9 ("Cygwin: console: Ensure the master
> > thread runs only when it is supposed to"), the process which calls
> > set_disable_master_thread() hangs if the con.owner already exited,
> > because set_disable_master_thread() waits for cons_master_thread
> > accepting the status change and reflecting the current status to
> > master_thread_suspended. With this patch, set_disable_master_thread()
> > is aborted if the owner process no longer exists to avoid this
> > hang.
> > 
> > Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260037.html
> > Fixes: 733d5a953fa9 ("Cygwin: console: Ensure the master thread runs only when it is supposed to")
> > Reported-by: Jay Libove Alzina <libove@felines.org>
> > Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Treat the absence of the master thread the same as suspension.
> > v3: Handle the crash of owner process.
> > v4: Put my concept together based on Johannes's.
> > v5: Abort waiting for master_thread when quering owner process fails.
> >     need_console_handler() simply returns need_console_handler.
> >     Rename master_thread_exited() to master_thread_unavailable().
> >     Set con.is_processed_input before asserting ENABLE_PROCESS_INPUT,
> >     and unset it after clearing ENABLE_PROCESS_INPUT.
> 
> Thank you for addressing all my concerns! From my point of view, this
> patch is ready.

Thanks for the final review. I'll push this patch after the patch:
[PATCH v18] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
because this depends on that.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
