Return-Path: <SRS0=ne1q=V4=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 890773858D1E
	for <cygwin-patches@cygwin.com>; Sun,  9 Mar 2025 12:28:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 890773858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 890773858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741523308; cv=none;
	b=NuIehkugV+ofYZy/TANFI3yBM3PVI6xrobC6iVcGigggrl8wiFqZw+N5NcIOkr/ovbq2vaPF69hsTuimAKEYKkzb6xY2ef1i4N1i5BadDq3fTqlK9YxtxeW4YKy/79CP7yp+UlCeiyItX9wys+4WpEg34iL+nDPniVptMujQYdA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741523308; c=relaxed/simple;
	bh=md46VqrV7qRSVKLRKCO2tAvla/nxArpAy809to6m3Sk=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=saqc3lq60HFYWfnM0YeNvmQtBSBe/vWsYTdHHsEHXMBXhIdHZT1aSkCnEt507A0UKYVV7tRXq2V+xkCJSf1WLdB85wDd+lnuZ+NKlBk0q2xKUgjYvgaqSg7gINHFDQdzml1LyRE46q4HyIBxz2d0Y7pyP7fdpr7BT4JuM5n4bMo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 890773858D1E
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
	by mailout05.t-online.de (Postfix) with SMTP id 8F8CD3D4
	for <cygwin-patches@cygwin.com>; Sun,  9 Mar 2025 13:28:26 +0100 (CET)
Received: from [192.168.2.102] ([91.57.253.229]) by fwd85.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1trFlY-3YkhGa0; Sun, 9 Mar 2025 13:28:24 +0100
Subject: Re: [PATCH] Cygwin: signa: Redesign signal queue handling
To: cygwin-patches@cygwin.com
References: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <21db86b5-d9db-734b-7fea-922b18dab292@t-online.de>
Date: Sun, 9 Mar 2025 13:28:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1741523304-96FFA93D-E63EFA7F/0/0 CLEAN NORMAL
X-TOI-MSGID: 6b662683-2ba6-4f4b-b0ab-18a84fbe9367
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> ...
> With this patch prevents all signals from that issues by redesigning
> the signal queue, Only the exception is the case that the process is
> in the PID_STOPPED state. In this case, SIGCONT/SIGKILL should be
> processed prior to the other signals in the queue.
>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> Fixes: 7ac6173643b1 ("(pending_signals): New class.")
> Reported by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ...
>   void
>   pending_signals::add (sigpacket& pack)
>   {
> ...
> +  if (q->si.si_signo == pack.si.si_signo)
> +    q->usecount++;
> ...
>

This should possibly also compare the si.si_sigval fields. Otherwise 
values would be lost if the same real-time signal is issued multiple 
times with different value parameters.

The queuing might also be incorrect for real-time signals. Linux 
signal(7) says:
"If different real-time signals are sent to a process, they are 
delivered starting with the lowest-numbered signal."

-- 
Regards,
Christian

