Return-Path: <SRS0=zjkU=SY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.114])
	by sourceware.org (Postfix) with ESMTPS id 2B5CE3858D26
	for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 12:03:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B5CE3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B5CE3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.114
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732881789; cv=none;
	b=D4PbjsU8b3FHKzJ25isYLxv2X8GFQVUewCDnRdFCuqppOiR5H/JGPXNM+QTyR6dMucJ/rQuWC5n74T4lhDW72rxYL+Hq//FWOVWAZ5ruEDWLyXqroBeD3/67rj7sB7+cgirrjI0iYw8PHLDCWmmDCSrsA89zQkzaOwJRc2CxWA8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732881789; c=relaxed/simple;
	bh=dukHDIbkRkyPoOKlXi1o1cDshv57zu8zS80yhsenQqw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=L2m9Do80X8E0s44o9iBRw/R/G4PHsXrgyAhTh0UYDAsFrxY0dNzsrsvZ8IAzjJHgNgzdW1sk1VEWQjBawdQMV101Poh35yPQMU8iL6jSdfMxN7BDDqGOpl4IlhV8UCtXkDLJil+2hAaNFLe9IDL41OvL5JPPKZxw0/DMBxqpBTk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B5CE3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oWRIiC+7
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20241129120307481.ITUQ.44461.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 29 Nov 2024 21:03:07 +0900
Date: Fri, 29 Nov 2024 21:03:06 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 6/7] Cygwin: cygtls: Prompt system to switch tasks
 explicitly in lock()
Message-Id: <20241129210306.a98b246a7da58d52b3a4a06c@nifty.ne.jp>
In-Reply-To: <Z0dQH6Ur71VzX_7q@calimero.vinschen.de>
References: <20241126085521.49604-1-takashi.yano@nifty.ne.jp>
	<20241126085521.49604-7-takashi.yano@nifty.ne.jp>
	<Z0dQH6Ur71VzX_7q@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732881787;
 bh=p3ZH/j9R7OfppsZXhzksM6uAgFpNBo/iw3y33ZfmHsM=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=oWRIiC+7HyD5Voz3UIzi44kWGiv4CpqylbNWBqJDDuaeKzu/lBqSn0Ek/5mFOZBzep0rWv8m
 Dx1TZ8K6sN6hNlEbQ7tlFwwjH2biYyjy3GEfPuPkYdf8MvhuUSV/SfLB/6WVG9K3kMCitM58AZ
 oWJdevn/yZeEm7cINRcl8a5KyPkZjjcG0fSPGZHmrzkHREh8+e37NcwUHrkrXis9V7dU4/pnRL
 P+0G2NXDXxQq+JY6iLdqm1SGumuqGkBdwl2WLyvkpBsSQGBnCXWIfOSFxlbb11Eax7enoeJbMJ
 BfjXaqj3iokei92e1uXmRt516XXkIN9UzZNOS0oUNVfeoOww==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 27 Nov 2024 18:00:15 +0100
Corinna Vinschen wrote:
> On Nov 26 17:55, Takashi Yano wrote:
> > This patch calls Sleep() in lock() in order to increase the chance
> > of being unlocked in other threads. The lock(), unlock() and locked()
> > are moved from sigfe.s to cygtls.h so that allows inline expansion.
> 
> When doing the locking in C++, we should really make stacklock volatile.
> That affects especially the unlock and locked methods, where you'll
> never know how gcc optimizes away.

OK. I have added volatile to stacklock. Please see v3 patch.

> spinning should be volatile as well, but it's up to you if you already
> add that, or if we only do this when we add the SIGKILL patches.

The variable spinning does not concern directly for this patch,
so could you please include that in your longjmp patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
