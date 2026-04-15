Return-Path: <SRS0=9Zje=CO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 032C54BA2E0E
	for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 17:50:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 032C54BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 032C54BA2E0E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776275447; cv=none;
	b=P+YNafCVkyMA5i92jicDRBOSoJivXmaa+m/FZlp4LqT+TRmrZXDZ+DZq9xUinAEUFfdJ13/vNOmnN9zz9z+FQ/44510fNXRYS2nMGaIU31FsIFGAzcxqwfR3ThU+NtmkaRTliJ16+Zv5Qok6W66Aj2Ur/oLRFuyulboJ3y2Oqb4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776275447; c=relaxed/simple;
	bh=0gb5BLDxqG+2ZougsLzuEik10nu9C1LKEegmSqW8IYs=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=uX6yJLaRK4rAKht8Fpt/zGmYpvFGbRRsW07LqlwdrE89rqdPjj4Vx+zXFovKpntOd936U4nxlz1bxx5C333s24qK0N9OTkRroGEztU0k4jXbcilwOpJi/SifhLpJbGvaFDEUC/3R9zfOrhS+NFWfR/147wqsHk+hFrsCFr9u8hs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 032C54BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mJxN8w1+
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260415175043536.QWRW.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 16 Apr 2026 02:50:43 +0900
Date: Thu, 16 Apr 2026 02:50:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-Id: <20260416025042.569579d45a2f186676afd2e7@nifty.ne.jp>
In-Reply-To: <20260416024738.1a525470ff3658b19dfd8249@nifty.ne.jp>
References: <20260415111123.5952-1-takashi.yano@nifty.ne.jp>
	<20260416024738.1a525470ff3658b19dfd8249@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776275443;
 bh=foDjy0XWJUWHw0J64uTvO+bqxa44C7T3dMn6L0M4kY4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mJxN8w1+e3VYPEyeRw9uYqxY2Tvw344darKXngjjeZuln1MeW24cmiimatOCYEd2JJX1Vx5z
 Xx9frPiLoAx4qMfnLbqV7t7QI3b6XeQpRIqsHUyRy5/RotTJqBd4Wma+q9BSlsSHr5pX22ZXvh
 C3lsOH6oiu69Z0AnkXaxBonG2Ipb2BxLNddHv6fHsPJ0oh228yAnyv9TQAzjNyd8BgEikgOQTL
 dTlsuASimEhjhVRGh0tuzVh4QAUBncUserwHVR2in68Dqablabw/+3M7vN/D/LmCzL/TBTampQ
 eO5DltJ7zGe49+EDX9RbN4RlJb5+YD8IKh9FFkx7/Isthq9Q==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 16 Apr 2026 02:47:38 +0900
Takashi Yano wrote:
> myself->wpid_debuggee_maybe = p.dwProcessId;

Oops!

myself->wpid_debuggee_maybe = pi->dwProcessId;

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
