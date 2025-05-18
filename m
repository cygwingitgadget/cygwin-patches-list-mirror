Return-Path: <SRS0=aTN+=YC=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	by sourceware.org (Postfix) with ESMTPS id 6E4AC3858D20
	for <cygwin-patches@cygwin.com>; Sun, 18 May 2025 13:32:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E4AC3858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E4AC3858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747575150; cv=none;
	b=Zm7NQYJHV08uJUFr+1694tdLHddSJjP62sUaPjB0btn2wR0iawU7t85iMsZUl34/X3aGQ9dyfH/XhjJGYB3cv3vSMDCSTCEZ1ADhtG0HKQKvfZVJJaBJcHfTrnccqxVUihKf4ldy7tMn9S3GeC6UUoJrZiUW8zeQkpKSa/TTRok=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747575150; c=relaxed/simple;
	bh=aOZY8qmo1QrZCepa8Z07OBoc9uFM+wFwcmT/U6gM0IA=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=w1pKtUiz6qlGy0+oa4za36HZiei0Qjw/jFhppFHNbSgbQ+pPTZyXVr2UYoEC6PlYU8oqoBe7C0kCd8K/RKsG9YmqcB08wClaSPyQvBzaBf4bcR17tMMqZinHV4noWU76fMKjeVLnwdeQw5ofkZJHloc5XXV49gASK4BfYsoJAgw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E4AC3858D20
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
	by mailout06.t-online.de (Postfix) with SMTP id DD74C1CD4
	for <cygwin-patches@cygwin.com>; Sun, 18 May 2025 15:32:27 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.253.158]) by fwd76.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uGe7s-1CYB5E0; Sun, 18 May 2025 15:32:25 +0200
Subject: Re: [PATCH] Cygwin: Only return true from try_to_debug() if we
 launched a JIT debugger
To: cygwin-patches@cygwin.com
References: <20250517140054.1826-1-jon.turney@dronecode.org.uk>
 <20250518151159.cb5a58b59f66bf90efa93826@nifty.ne.jp>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <72825f8a-1e48-6647-d1a9-c1bc09b79a52@t-online.de>
Date: Sun, 18 May 2025 15:32:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <20250518151159.cb5a58b59f66bf90efa93826@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1747575145-1B7FC5CE-1D9952E6/0/0 CLEAN NORMAL
X-TOI-MSGID: 9a7bde03-35d7-41fd-a4c7-aad80b5cff1b
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_BL,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> On Sat, 17 May 2025 15:00:53 +0100
> Jon Turney wrote:
>
>> This fixes constantly replaying the exception if we have a segfault
>> while a debugger is already attached, e.g. stracing a segv, see:
>>
>> https://cygwin.com/pipermail/cygwin/2025-May/258144.html
>>
>> (I'm tempted to remove the 'debugging' static from exception::handle()
>> and everything associated with it, since replaying the exception the
>> next half a million times it's hit seems really weird)
>>
>> (This would seem to make try_to_debug() less useful, as it then does
>> nothing if you're just run under gdb, but it's what the code used to
>> do...)
> ...
>
> Otherwise, LGTM. Please push.
>

The patch fixes the problem. The infinite loop does not longer occur. If 
a signal handler is present, it works again if run from strace. Same if 
run from gdb.

-- 
Thanks,
Christian

