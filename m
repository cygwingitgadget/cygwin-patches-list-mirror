Return-Path: <SRS0=9WkO=XN=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id 5BA113858C60
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 21:13:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BA113858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BA113858C60
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745788391; cv=none;
	b=Nbe/qv4Ki+dTGKrvWy6jNPIBN0YgZCcYaySBsv+gC/eeamp+kErNuTJq8FxyAtBdJRZyeVi5Oxejpa2TEaTKsaV4NOnGK7KhJe26CYAbKoLTNNslMBTaDhn3paVldAgrYVAyS8mKku+WXCY5U0HvWpR1iPSbkGkl5jr6EGNon/c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745788391; c=relaxed/simple;
	bh=mkikbqOIxdl53SnAqzeuvakWSfISqZiS4kR+Nm2P3+g=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=Bl5AaziZMSq0Qtz+LJqe614QiNRw/6UBTwqNJNsnhbNFQpdfMsfnH2dnPY3AO8HTCs2zHLzKaUt2Lccp+8d2Q62UNSKokuMgLiY/DribNg6pCMoz+LtoWLGpL/4zu3zXXHllpYpdej/QiGBcjh+xTwmSGSMQnov9sbrPGfjL15Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BA113858C60
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout05.t-online.de (Postfix) with SMTP id 28353863
	for <cygwin-patches@cygwin.com>; Sun, 27 Apr 2025 23:13:09 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u99JD-3fT1JQ0; Sun, 27 Apr 2025 23:13:07 +0200
Subject: Re: [PATCH 0/4] Add stress-ng to CI (v2)
To: cygwin-patches@cygwin.com
References: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
 <42dbf82c-f7d5-446a-bd28-ecf44c3e814b@dronecode.org.uk>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <71163709-deed-4228-aabd-c431a331b1ff@t-online.de>
Date: Sun, 27 Apr 2025 23:13:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <42dbf82c-f7d5-446a-bd28-ecf44c3e814b@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1745788387-68FF69D9-F55C5771/0/0 CLEAN NORMAL
X-TOI-MSGID: b674da4c-6d38-4f08-80da-d07d54a65124
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 20/04/2025 20:25, Jon Turney wrote:
>> Jon Turney (4):
>>    Cygwin: CI: Pass the just-built cygwin to a subsequent job
>>    Cygwin: CI: Run stress-ng
>>    Cygwin: CI: Make stress test terser
>>    Cygwin: CI: Disable stress-ng clock test
>
> OK, I pushed v2 of this.

Sorry for the delay and thanks for accepting the script.


>
> Please feel free to suggest changes to turn on additional tests etc.

Will do.

I'll add a check for unexpected "panic" output from Cygwin to report 
failure then. Example:

$ ./cygstress dev
 >>> SUCCESS: dev
 >>> SUCCESS: All 1 stress test(s) succeeded

$ stress-ng --dev 1 -t 1
stress-ng: info:  [40534] setting to a 1 sec run per stressor
stress-ng: info:  [40534] dispatching hogs: 1 dev
       0 [main] stress-ng 40537 C:\cygwin64\bin\stress-ng.exe: \
       *** fatal error in forked process - 
pthread_mutex::_fixup_after_fork \
       () doesn't understand PROCESS_SHARED mutex's
       ... etc ...
stress-ng: info:  [40534] skipped: 0
stress-ng: info:  [40534] passed: 1: dev (1)
stress-ng: info:  [40534] failed: 0
stress-ng: info:  [40534] metrics untrustworthy: 0
stress-ng: info:  [40534] successful run completed in 1.17 sec


> Any insight into what's going on with the 'clock' test?

No, as I could not reproduce it (on a real machine) yet. Possibly an 
effect which only happens if run in a VM?

-- 
Regards,
Christian

