Return-Path: <SRS0=Ctoq=WW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w02.mail.nifty.com (mta-snd-w02.mail.nifty.com [106.153.227.34])
	by sourceware.org (Postfix) with ESMTPS id EAEC33857C67
	for <cygwin-patches@cygwin.com>; Fri,  4 Apr 2025 12:06:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EAEC33857C67
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EAEC33857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743768374; cv=none;
	b=gaXj80VMWLpdLBSpJ4qv28wVacA+JjcTYj0FVfAZGZQDZ/WGLxwJ2GRxV9aDDWW0pUZIRsYeClO4iDukojg+2tnXfgYlRaZVsR3xG3LN8wAoDvehMGKBpMElqYYyeTbk76X0rU0XYw/efhPAD++TNmhcZxB7USV1r4PbjehXKjA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743768374; c=relaxed/simple;
	bh=rFPCPzXglQH9KEolhQyhfIlaN2aoRJO8i69+JvLp82E=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=HzC9fw6iXVpRLrQpmR5Xnl4WQX0PqA9cFDj2Xk0eLFPHo9qBWWxww9lpdBaVpIlh6m5o7CCJ/gvuHTrrvnVvo67ziY3nDJdIMCKvwz2A9Q4cl2cxzLmd6K8exVzAgcWGDGdRK9gd+DxkNillYwb8BMnhnoR96JWKkprxy8+fOY0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EAEC33857C67
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZbgbxRkx
Received: from HP-Z230 by mta-snd-w02.mail.nifty.com with ESMTP
          id <20250404120610596.KGYC.37742.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 4 Apr 2025 21:06:10 +0900
Date: Fri, 4 Apr 2025 21:06:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fork: Call pthread::atforkchild () after other
 initializations
Message-Id: <20250404210609.b0d38a4cac7e195ad20a9ced@nifty.ne.jp>
In-Reply-To: <C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
References: <20250403083756.31122-1-takashi.yano@nifty.ne.jp>
	<969eeb56-fb62-b279-f8d0-02dc7f679859@gmx.de>
	<ec45497d-a248-1056-4993-da137267b7c5@jdrake.com>
	<20250404105839.6652c8849bfb169d669f3799@nifty.ne.jp>
	<C262E1A5-1B14-4D38-AE47-2EC7709DB6D1@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1743768370;
 bh=OiyVvtVsFhH/A4pisKfzMO5aWw6147d3qnOQnV9opm0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ZbgbxRkxGWIn/e9I62qbsXCfue2g7Qfb6zoMZ2dHGxW0LX0ORdR5lXWCPWul9gfj+SKOpFvF
 8FzknR3eeWJGLXAHXb9aSIbQnduJHPqoJB99IplUQT4dInQ/oaeKktp3yDyyB0PfbgsawTfV+H
 wNvCaA+PZW4/PJHkVev/iWo9CY/BOfYNQn80iCLa6aqcRg7YYNfNgOQnxrdXi9ELYPvBCaOuUo
 keUTspTDx573qaAVUiRvveN+cunT+p524+F+pJ+XCiFALXkVOz/oJy0n/l+in+LiO2OaWi6riQ
 iZ1nN1oVAKemXVxOfchF5Dn0B2awwfs5J/EKSFFYOJASRaAA==
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 04 Apr 2025 07:27:09 +0200
Johannes Schindelin wrote:
> Is Jeremy's guess "if raw_write doesn't need to wait (ie, there's room in the
> pipe for the write) it doesn't hit the signal stuff" correct? If so, it would be good to add that part to the commit message because the commit would otherwise still be incomplete.

That's not correct. Indeed, raw_write() waits for room in the pipe,
however, it does not matter in this case. The probelm occurs at
cygwait() which waits for pipe mutex as already mentioned in the
commit message.

> Also: referring to 7ed9adb356df may be technically correct, but human readers have a much easier time when that shortened commit OID is accompanied by some human-readable information, such as the string obtained via `git show --format=reference` (see <https://git-scm.com/docs/git-show#_pretty_formats>).

Do you mean "the commit 7ed9adb356df (Cygwin: pipe: Switch pipe
mode to blocking mode by default, 2024-09-05)"?
Not just "the commit 7ed9adb356df"?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
