Return-Path: <SRS0=5fL3=ZI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id B923C385783C
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 11:03:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B923C385783C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B923C385783C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750849424; cv=none;
	b=KXt7ulZCDpRuDeFkli0Ps46BbztMw90rfLjpSnglVtMESHdyRlrTdoZGg9bqKJY23CwauCVx3UFJIKrhuNTkke8UzE/4xpdIO5+hVnfY8qJtx5qywIPM/+0mVqRbnWagFxOZbf+Tj0hMsFnad4ZXBNxNXyWuzr0uh/iOiTjjSG0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750849424; c=relaxed/simple;
	bh=JRFEsvUDST0yiJ2C+TMse0cFgykUtccTIlJh18q2HOA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=WKu13yzrD80shK7w0tJwnLNNCr+TEK+E4W3ikHOBeVWz5EUlJrLK5QpsQrlvzFE2LqYhQA8iTUNc9+JZJBALLzGhRpQt6J2+l/pw8xxxddU62ledshbEQFIeKrC6LaqdmHTSDtL3jqGkFdaFwyYjWyJfJ3BoSl/i039DEWdUDZ4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B923C385783C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q/Ay958Q
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20250625110342103.ZEAH.84842.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 20:03:42 +0900
Date: Wed, 25 Jun 2025 20:03:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250625200341.5c0d893a7d129ead53c89338@nifty.ne.jp>
In-Reply-To: <701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750849422;
 bh=EQEuA5aj60NqRmwuVE3KSe3sfhoFkRvzgjP4ErmkyUU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Q/Ay958Q5SrWaGFCfHH+tmn2fQptogUu3MQr6tQFyBjjekMlmFHppKxstkyGXaXRSJFe9IkQ
 mqd75hA1U1KdbpIOpI6sewDyDSzGKtox3xCM47oU9lGnQ5fjy2v1/FwRqqHWH6AQOmZEyYd5l0
 0GfydZ38m25zjWpD1nYEVwUqdtdOO7KPqOIbqqCUFwIxQ0X3F6xmcyeOs8oIrYIpW5lsJAlnsM
 JbEP8IxF2GvclgY1uY+B0RycRcOd6JuckHoMq7RkDus/D4xMJfNEhuKS/rq9y2AP3CEybjB+9D
 /g47MDIq0hY0GeU5rvwEWkDGdV/ltDvG6octH5LSMrD0ouMQ==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025 07:59:54 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Jun 2025, Takashi Yano wrote:
> 
> > I found the patch blocks non-blocking write in some condition.
> 
> Could you please describe these conditions?

Just try to write more data than pipe space at once.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
