Return-Path: <SRS0=0NVs=7N=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 728FC4BA2E04
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 08:35:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 728FC4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 728FC4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767861316; cv=none;
	b=Th3y9pW67btYIIydoBMicCkR6B+nLCBGkwrqQktkYo1vQXM3jQAXaUw25pSMhrlW6aS1qvMNDt3m+Prf7dDNRfg5U/qIua1syaEmXblnz0HonAi/gUQZmQW9Fbb/CxCKuF8ev7CDjWXC+X4xN9plUQtgvbha0ECAJWW2lV33gho=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767861316; c=relaxed/simple;
	bh=l1ixnqoXpJAZiw/v4PC2nI2pwQHBIP8Wtn9chKwu4yM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=S81ESJY420G0/7lblWOOjiA5lwE2AcS6QAY61a6zoob99ssEwt3cPbyvttg5GPbvn9WYuf9hwV8g7SgUVt044NmkwedEK+mWYzpW4ViB//stw6uEtyqNzcKrJdzyqgqH9dgTaCU4ExuLed3aWKcY23lqrQ+stOwLslrin6xknOw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 728FC4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I7gJSk8y
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260108083513528.MVJP.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 8 Jan 2026 17:35:13 +0900
Date: Thu, 8 Jan 2026 17:35:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: flock: Do not lock fdtab in
 create_lock_in_parent()
Message-Id: <20260108173511.d2033aa8a0fe7b4e879af7bf@nifty.ne.jp>
In-Reply-To: <20260108083031.1364-1-takashi.yano@nifty.ne.jp>
References: <20260108083031.1364-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1767861313;
 bh=4YE2dYVjd9MAr2qCcPKK3g+yZbXesJKfkJHCN3rwqYI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=I7gJSk8y6rWDAylq69WhMKEUeBbq3HQorqDjENokzGZoaPouPwL0UVXCRmmsi3eqChn7o5/p
 I0JIt5fpZquG6Feidj4G12frJg2v5+EQzaYYF+mtjKeA1JVbxTedlWlNvcvHfSMqLba0nrVsca
 YY0o+mWwv6QgBJdopTk7VEETBErqNT39M87sWaXZWe3R5IbVOVLeeAlT25YvrvciJYU0Tx/JAM
 GMlDCzaE0ST5vC2/7cbrChaivn9dt/RtUxY85LCeQibtQbMPgkcCJoLluzvXCm9+xmFVHFVUTg
 WH9Vi0ZlA/+vU75SuKxiTAFp8JI3TntfCkzvJnDH3lj53vsQ==
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu,  8 Jan 2026 17:30:22 +0900
Takashi Yano wrote:
> Addresses: https://cygwin.com/pipermail/cygwin/2025-December/259187.html
> Fixes: df63bd490a52 ("* cygheap.h (cygheap_fdmanip): New class: simplifies locking and retrieval of fds from cygheap-
>fdtab.")

I forgot to change Fixes: tab. Sorry.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
