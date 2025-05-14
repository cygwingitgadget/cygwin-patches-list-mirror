Return-Path: <SRS0=0Q2p=X6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id 747123858039
	for <cygwin-patches@cygwin.com>; Wed, 14 May 2025 13:23:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 747123858039
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 747123858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747228989; cv=none;
	b=F6YLEyKzK1rXDoyEIdn1a+Ka4nqsHzuij8lRO+sGnLoUNw9H0NYe18NK+uRsDYrh4B6FI1bwqHPk3Kpese8W8l+TM5XjVzaOjSrzRCcfcBLE6Gq48onH7FNIe4EvxLqiye+uA5C91ighgnVmKaKdGRhpPipeNEjwJNnc7LaFEw0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747228989; c=relaxed/simple;
	bh=VSs3wAj3hVpyoAB27dt4biBa11PT0sNY0oXNrlYj3BI=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=aD9Z9R7PKuWGRXVG3C3l9/YXRkcQl+YK3invVm7PYIAh4SU4Q30vmNFGUxybHW2aTvoMPPxGr0/7SxEJaASj3Lgiefqf/3bUS9KAnuJurrSA1u7eohV/MLH9nUxfGsSdxiYebUKtAY6rjSjTNpSlwEbe0nD3VJcvBU2/BmcZvv0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 747123858039
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout02.t-online.de (Postfix) with SMTP id 0A50910F9
	for <cygwin-patches@cygwin.com>; Wed, 14 May 2025 15:23:07 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.253.158]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uFC4f-1scNyC0; Wed, 14 May 2025 15:23:05 +0200
Subject: Re: [PATCH] Cygwin: kill(1): skip kill(2) call if '-f -s -' is used
To: cygwin-patches@cygwin.com, cygwin-patches@cygwin.com
References: <16c95bad-2310-e66c-d538-403321033d2c@t-online.de>
 <20250415164029.c118309bc33c25f4b404b48d@nifty.ne.jp>
 <4356587f-51ed-302d-03f1-7415590813f6@t-online.de>
 <20250502203144.ca3ba0953ce5bb9f97267920@nifty.ne.jp>
 <1c5aa56e-63e0-c989-4f67-cd77f0c769d1@t-online.de>
 <20250503155357.178e47383611df1a76f784f9@nifty.ne.jp>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <51fef89a-15d0-7494-1906-4a8b3b05d391@t-online.de>
Date: Wed, 14 May 2025 15:23:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250503155357.178e47383611df1a76f784f9@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1747228985-0B7FC520-DD49A8B2/0/0 CLEAN NORMAL
X-TOI-MSGID: 9c46091b-fed8-42de-a234-411949c609a4
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

sorry for the delay.

On Sat, 3 May 2025 15:53:57 +0900, Takashi Yano wrote:
> Hi Christian,
>
> On Fri, 2 May 2025 16:09:48 +0200
> Christian Franke wrote:
>> ...
> I have a problem with
> stress-ng --mprotect 1 -t 5 -v
>
> It sometimes hang due to a cause which does not seem to be a
> cygwin bug.
>
> stress-ng seems to use SIGALRM to stop processes. In mprotect
> case, SIGARLM is armed before stopping SIGSEGV. What I observed
> is:
>
> 1. SIGARLM is armed.
> 2. stress_handle_stop_stressing() is called.
> 3. Just after stress_handle_stop_stressing() is called, SIGSEGV
>     occurs inside the stress_handle_stop_stressing().
> 4. SIGSEGV handler is called and longjmp() is executed.
> 5. stress_handle_stop_stressing() can not continue because
>     longjmp() does not return.
>
> Therefore, timeout (SIGARLM) processing in stress-ng fails.
>
> Please try
> while true; do stress-ng --mprotect 1 -t 1 -v; done
> with cygwin-3.7.0-0.88.gb7097ab39ed0 (Test). In my environment,
> stress-ng hangs in dozens of minutes.
>
> Could you please have a look?

With many iterations, I could reproduce the hang. Your explanation is 
likely correct.

SIGSEGV should be set in the sa_mask of SIGALRM (and other) handlers. I 
could file an upstream issue if desired.

-- 
Regards,
Christian

