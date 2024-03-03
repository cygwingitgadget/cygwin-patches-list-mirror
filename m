Return-Path: <SRS0=DLLh=KJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0002.nifty.com (mta-snd00009.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id B9A7B3858C55
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 11:36:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B9A7B3858C55
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B9A7B3858C55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709465807; cv=none;
	b=wGs+GZxURJjSs7FHZsQ3Mzx2Xl1jNXcfFf8UcAAHtEXsO3TIjkJ4Sbm8wbQthpPiO1ESu3sbd+INDgTf8yindix1ag2+JRMOKK7tVdnGca/E7RSnnmjHQHpzD9GAGd+yzKX+mWqaD9s96e0GeIGKjit7dIWvV0Iszr5vEh/IDBc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709465807; c=relaxed/simple;
	bh=xH+nKIXmWKpCZvuZjJIEQv132SfbyvuFXItbE0rtWzI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version; b=Dy1BWj1QvxsmwZETA175no1T3WIiU8cagy/LBWTZsArcucleuv32Y3/ikHntFS/doB2p6lL4DgrAoh4Y/P9fngAJEH3Xl+vm09IvPXIK1dgemtEaL5cnk6nH4wxQdVOIPkrActJhR0rTxdzfKNgsSN8Qqqnx+/K4EP9UrgoAMZg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by dmta0002.nifty.com with ESMTP
          id <20240303113641980.FLXZ.56322.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 3 Mar 2024 20:36:41 +0900
Date: Sun, 3 Mar 2024 20:36:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-Id: <20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
In-Reply-To: <87a5nfbnv7.fsf@Gerda.invalid>
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
	<b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
	<87a5nfbnv7.fsf@Gerda.invalid>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, 03 Mar 2024 11:39:40 +0100
ASSI wrote:
> Takashi Yano writes:
> >> After noticing that we enumerate all the processes (which is an expensive
> >> operation) just to skip all of the non-Cygwin ones anyway, I wonder if it
> >> wouldn't be smarter to go through the internal list of cygpids and take it
> >> from there, skipping the `SystemProcessInformation` calls altogether.
> >
> > Yeah, that makes sens. I'll submit v2 patch.
> 
> Keep in mind that there may be different independent Cygwin
> installations running on the same nachine.

That's possible. But how can we know that is a process in another
installaion of cygwin?

If it is difficult, I think it is not so nonsense to treat it as
same as non-cygwin process.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
