Return-Path: <SRS0=x21U=XR=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
	by sourceware.org (Postfix) with ESMTPS id 3E4E13857C7B
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 12:30:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E4E13857C7B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E4E13857C7B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746102640; cv=none;
	b=BPaFlZOjbwPbhtMJulQFcNMugQJ5uamvaK8SKTR1BrCpy8sYsZASO1ah6V5JG5nvVWBOU56Axis8mFmn/qCWxwSjjuZGgfUZG+oxKX3ylB3XwUgG4VNCjdiQgMMrjWvFK+XujpK5a17MgmeKkoQ0D1yb0jiaistNKt9FrFhp3s0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746102640; c=relaxed/simple;
	bh=xP+qb+EiJI9a09r9qAt8oqx0hWsuJDCgybOIaCxdgl0=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=a3vzabocMrvx8FLZ6E8jfLQzRToBj47VdSrhcFrDusPPJBN7iMJ/r+QUDZOpKR9omWDQ5ZYjCiamAhI0+5dL6JMehzMVuKV98UfKhBcHs5TWwWGZHHTati1GbCjvm8/ovwhW8L3xrQaUk9bezgR0ufOsfI7wkF5pAQcEZLkfisE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E4E13857C7B
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout10.t-online.de (Postfix) with SMTP id EC051331
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 14:29:59 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uAT36-35uUDo0; Thu, 1 May 2025 14:29:56 +0200
Subject: Re: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
To: cygwin-patches@cygwin.com
References: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
 <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
 <09edeb3e-6c0c-74bb-75df-a7dd2bde2e5e@t-online.de>
 <9e95644c-c152-00ed-14d1-725252066fa6@t-online.de>
 <916eb947-c497-4485-b230-50a67c4e8b91@dronecode.org.uk>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <77d581c2-88ee-3ae1-a6f0-69c2d6bd641b@t-online.de>
Date: Thu, 1 May 2025 14:29:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <916eb947-c497-4485-b230-50a67c4e8b91@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1746102596-5FB27936-1F7FAEE8/0/0 CLEAN NORMAL
X-TOI-MSGID: 94dd8211-40df-4bd9-b37b-84ae07317830
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 30/04/2025 12:33, Christian Franke wrote:
>> Christian Franke wrote:
>>> Jon Turney wrote:
>>>> On 28/04/2025 16:43, Christian Franke wrote:
>>>>> A followup to:
>>>>> https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html
>>>>
>>>> Thanks!
>>>>
>>>> The SUS page for clock_settime() contains the following text:
>>>>
>>>>> [EINVAL]
>>>>>     The tp argument specified a nanosecond value less than zero or 
>>>>> greater than or equal to 1000 million. 
>>>>
>>>> ... so if we're going to validate tv_nsec, it seems that's the 
>>>> range to use
>>>>
>>>>
>>>
>>> Yes. The patch only checks the lower bound because the upper bound 
>>> is already correctly checked later in settimeofday().
>
> This is just prompts me to further questions: Is settimeofday() 
> specified to permit some kinds of non-normalized values?

settimeofday() is not part of POSIX, Linux settimeofday(2) only says:

"
EINVAL
Timezone (or something else) is invalid.
"

It is also usually missing in the docs that negative time_t values are 
accepted by gmtime() etc. This works on Cygwin and Debian:

$ date -u -d '0000-01-01' +%s
-62167219200

$ date -u -d @-62167219200 -Is
0000-01-01T00:00:00+00:00

