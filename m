Return-Path: <SRS0=5EGA=XP=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout11.t-online.de (mailout11.t-online.de [194.25.134.85])
	by sourceware.org (Postfix) with ESMTPS id CA9CE3858C60
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 08:31:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA9CE3858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CA9CE3858C60
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.85
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745915506; cv=none;
	b=wYouEs8QkYW/d0C1OxrHKWmdrGleVHNVgOoPFKwAYOaiQtf6dHAFUa0v0BWvYuOiTqaIywyFjd27EpvQPtQImcvr0JQVtHwuBv5dsjJsV2oQmU0OI+n/RsVbc+PVlRviR+UmSwYxpiTqWTJs4ktW/Mz3625nvQKBbKWwwQp/ZZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745915506; c=relaxed/simple;
	bh=m/Ty9GxhC4yKK60LjJh/DZZ/JZbzew57Yb1jATW5eY0=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=Zl681BBKXuKjGV+LnnQkpwadq11/yN5uX1kN5g/DeG/vD07kRiwZf4Z/+YHYM8a3agzPkiPVXGQaZ1on7jDqy7Ig82BZ6pKeSqB1SY9Irgw6lYxjelqJEWN0SHSq2kIsYFBpOVwxIkcYiW6YhCFtrzPmKxYElhljQnKB9O2S8T8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA9CE3858C60
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
	by mailout11.t-online.de (Postfix) with SMTP id 55A181040
	for <cygwin-patches@cygwin.com>; Tue, 29 Apr 2025 10:31:43 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd88.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u9gNS-02SL5s0; Tue, 29 Apr 2025 10:31:42 +0200
Subject: Re: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
To: cygwin-patches@cygwin.com
References: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
 <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <09edeb3e-6c0c-74bb-75df-a7dd2bde2e5e@t-online.de>
Date: Tue, 29 Apr 2025 10:31:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1745915502-FA7FB92D-84DC4CB8/0/0 CLEAN NORMAL
X-TOI-MSGID: c7067301-8c3a-47a9-b98a-f02571eeff46
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 28/04/2025 16:43, Christian Franke wrote:
>> A followup to:
>> https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html
>
> Thanks!
>
> The SUS page for clock_settime() contains the following text:
>
>> [EINVAL]
>>     The tp argument specified a nanosecond value less than zero or 
>> greater than or equal to 1000 million. 
>
> ... so if we're going to validate tv_nsec, it seems that's the range 
> to use
>
>

Yes. The patch only checks the lower bound because the upper bound is 
already correctly checked later in settimeofday().

-- 
Regards,
Christian

