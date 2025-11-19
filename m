Return-Path: <SRS0=EBeo=53=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.227.177])
	by sourceware.org (Postfix) with ESMTPS id 84566384D15F
	for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2025 08:38:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 84566384D15F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 84566384D15F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.177
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1763541492; cv=none;
	b=kamwwflGHvfELnKGyqOfURQlYtUD1TxZpfCPUhSOMR2BK0xxQkLlPQG8jFEO+8gZGuTsVyZ7ciw/3qZ94ShYTGkdBmm5rnrteZ+CLZd2YkCtDJDdf4Pjsmh/fTP21vXMts7NSpe+q7Omn/d4EGiLCqdClEKoGc7/9GLmTCSeuAc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1763541492; c=relaxed/simple;
	bh=nvXCOB5NcFUqhPxMsormFqw2OsNP/PTag1rWubJSSIo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=KTMWa6TAN1peBo5Em8qrKn5w1yHPuHXJbyMxCECR8Rre4QKd4ICluspsRv96iR3bmOixgA+903rP+BKx5mP2KT1MvKJjgDpJdTghZ1eBdkyBw7p0YhoBD+ElZYN4+iQ52pnBzUoI3A1u91ADojUiryITBe8vVZ9q3Sc6X8A6nJ8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 84566384D15F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=p8/YGqYq
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20251119083808532.GURN.62593.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 19 Nov 2025 17:38:08 +0900
Date: Wed, 19 Nov 2025 17:38:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Simplify creating invisible console
Message-Id: <20251119173807.1e541c0a8853a2880d00cfa9@nifty.ne.jp>
In-Reply-To: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
References: <20251118124034.1097179-1-corinna-cygwin@cygwin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1763541488;
 bh=/VKTClA0XHhVCeUAf8XY4iBw8TNqLDX1LakN8bvUKEQ=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=p8/YGqYqVHr9q4xoJsJ4SNEKlDfXxr9oFxL6974qVOkMThdoZRvoXQtkbBxQuIoMRH1HurSP
 VpTELqULRf8U6Glbg48ikZnV43AOznyOjjLj7INJq0kiu3C4cYW9GUg7HeSYcXlYvnq9yM//lt
 yp2Spjp+EHoNZ2vRC2L9m/PNvqy/WJnq2DWtGFlhxd6h0raMEg2EhCMHLekhauEeWUWJCUhDAf
 j1/XZsjGfAFKkIUmbESJrfVyT8r0VAeRFEWz5xtGytyXBQnUGAdkuo8Puqe66FOIB72BfV6z6x
 U+HOksel49vRyZChrP7XCx1BnFuzxkQhgydb6Dqnqycm9lhA==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Nov 2025 13:40:32 +0100
Corinna Vinschen wrote:
> From: Corinna Vinschen <corinna@vinschen.de>
> 
> Starting with Windows 11 24H2, the new function AllocConsoleWithOptions()
> introduces what we're desperately missing since Windows 95: a simple
> call to create an invisible console.
> 
> Reintroduce the old fhandler_console::create_invisible_console method we
> have been using once up to Windows Vista, and use it now to call
> AllocConsoleWithOptions() on systems supporting this shiny new function.
> 
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> 
> Corinna Vinschen (2):
>   Cygwin: wincap: add wincap entry for Windows 11 24H2
>   Cygwin: console: (re-)introduce simple creation of invisible console
> 
>  winsup/cygwin/autoload.cc               |  1 +
>  winsup/cygwin/fhandler/console.cc       | 21 ++++++++++++--
>  winsup/cygwin/local_includes/fhandler.h |  1 +
>  winsup/cygwin/local_includes/wincap.h   |  2 ++
>  winsup/cygwin/wincap.cc                 | 37 ++++++++++++++++++++++++-
>  5 files changed, 58 insertions(+), 4 deletions(-)

Both patch LGTM. I also confirmed that new create_invisible_console
works fine in Win11 25H2.

Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
