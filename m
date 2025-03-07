Return-Path: <SRS0=l6Rb=V2=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by sourceware.org (Postfix) with ESMTPS id 682B63858D1E
	for <cygwin-patches@cygwin.com>; Fri,  7 Mar 2025 16:16:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 682B63858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 682B63858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.84
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741364174; cv=none;
	b=Xuy1J4QkJn/G8n6vSrMk2CeyO0zvK4xGdOvuqDZi2xWO07PKGvhc0uwxgEi0KLNq28st8frLKj4g6/Deizs/ZUUULQ55UIPkfcJxVy/a0+k+dk0ZQQXvpPmxJXNKz0eSjhktEkSUcoR2BSJmdtY3vjdDp62hxuQ/j2+vIb1h9og=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741364174; c=relaxed/simple;
	bh=P1+0nSqz93EUtJxgstgkntpIyxxZp85q5SeGyt2goNo=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=OwIES6Aa6QJPR4ul/SY+Nr7vu6aqswPO9R6Z9F6OK7Okyz23yQdrDNQiS0YjzWmDNiI1+g6I+EGiCv3Ta7ML/kSQ5fyNa+bTzUHBVhf9jeFAbBWMVyurFn14yX9TedWw88cEZeUb+glrgCQ/9QSa9933KCI2ezYdknbsv9M/yjc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 682B63858D1E
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout09.t-online.de (Postfix) with SMTP id 107B31A4
	for <cygwin-patches@cygwin.com>; Fri,  7 Mar 2025 17:16:12 +0100 (CET)
Received: from [192.168.2.102] ([91.57.253.229]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tqaMt-2DSFjk0; Fri, 7 Mar 2025 17:16:11 +0100
From: Christian Franke <Christian.Franke@t-online.de>
Subject: Re: [PATCH] Cygwin: signa: Redesign signal queue handling
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
Message-ID: <44b53668-4b2d-df88-e536-cac008c8cfb2@t-online.de>
Date: Fri, 7 Mar 2025 17:16:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250307121626.1365055-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1741364171-4F7FDAEF-56F601CB/0/0 CLEAN NORMAL
X-TOI-MSGID: 78fef7ba-4965-4a51-8890-b470ea680e5e
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_BL,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> The previous implementation of the signal queue behaves as:
> 1) Signals in the queue are processed in a disordered manner.
> 2) If the same signal is already in the queue, new signal is discarded.
>
> Strictly speaking, these behaviours do not violate POSIX. However,
> these could be a cause of unexpected behaviour in some software. In
> Linux, some important signals such as SIGSTOP/SIGCONT do not seem to
> behave like that.
>
> With this patch prevents all signals from that issues by redesigning
> the signal queue, Only the exception is the case that the process is
> in the PID_STOPPED state. In this case, SIGCONT/SIGKILL should be
> processed prior to the other signals in the queue.
>
> Addresses:https://cygwin.com/pipermail/cygwin/2025-March/257582.html
> ...

A quick test with many runs of 'lostsig' testcase with or without 
'taskset 0x1' no longer shows any problems. No SIGALRM were lost (not 
required), [SIGTERM] is always printed after all [SIGALRM] (not 
required), SIGCONT is never lost. The previous 'timersig' testcase also 
still succeeds.



-- 
Thanks,
Christian

