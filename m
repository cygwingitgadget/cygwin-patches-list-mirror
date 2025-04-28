Return-Path: <SRS0=zXwX=XO=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
	by sourceware.org (Postfix) with ESMTPS id 23C863858C60
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 15:40:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 23C863858C60
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 23C863858C60
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.84
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1745854847; cv=none;
	b=G4+M4R4DmP6oSCsgXc1dlucWO0Di13Pyw8ajyCVgWUt4qNze+HGDTXqpszG+n6gYvFmEWhQB36AZ7Bo71qjxX2nH0BC24dO8smNKHhRv0kQPRfVrpRIFZJnwOLFlyyYm6ETjGYnR3Rs3lk4kFOGC/Mvf+6zcfh6xj7LHxGAQT5s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1745854847; c=relaxed/simple;
	bh=JB0//Uem54CnbzTlE8W3/giiUwIfqdBI+iDfzx93gsY=;
	h=From:Subject:To:Message-ID:Date:MIME-Version; b=lDrU/0JpWJnuve5saiuFe+tblKNHfGywC4G0gJFur4W3aKJaaacXM4bGbLi5D6j8+4P8KfO9GR1+j2Jfh+/6RBQ9IBpHefuXOP5gjhajUTuEML3Q8gLwXtJhrHumpBIIbLEuRRHZzn3gXpz33MO+HHvdFWsD8JK8jjJJJn1vCNY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 23C863858C60
Received: from fwd84.aul.t-online.de (fwd84.aul.t-online.de [10.223.144.110])
	by mailout09.t-online.de (Postfix) with SMTP id 912E2F12
	for <cygwin-patches@cygwin.com>; Mon, 28 Apr 2025 17:40:44 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd84.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1u9Qb5-1EOINc0; Mon, 28 Apr 2025 17:40:44 +0200
From: Christian Franke <Christian.Franke@t-online.de>
Subject: Re: [PATCH 0/4] Add stress-ng to CI (v2)
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20250420192510.3483-1-jon.turney@dronecode.org.uk>
 <42dbf82c-f7d5-446a-bd28-ecf44c3e814b@dronecode.org.uk>
 <71163709-deed-4228-aabd-c431a331b1ff@t-online.de>
Message-ID: <33a241ac-817a-a80b-4d30-cc1691b73e3e@t-online.de>
Date: Mon, 28 Apr 2025 17:40:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <71163709-deed-4228-aabd-c431a331b1ff@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1745854844-997F9A64-A956FB3E/10/3626336762 SUSPECT URL
X-TOI-MSGID: 1fa782e0-aac1-4de1-a795-364912ca3d09
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_BL,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Christian Franke wrote:
> Jon Turney wrote:
> ...
>
>> Any insight into what's going on with the 'clock' test?
>
> No, as I could not reproduce it (on a real machine) yet. Possibly an 
> effect which only happens if run in a VM?
>

It possibly only happens when run with admin privileges. Is this the 
case during CI tests?

If yes, the error message
"clock_settime was able to set an invalid negative time for timer 
'CLOCK_REALTIME'"
occurs because clock_settime(CLOCK_REALTIME, &t) with t={-1,-1} should 
fail but succeeds, see:
https://github.com/ColinIanKing/stress-ng/blob/V0.18.12/stress-clock.c#L297

Cygwin then calls Win32 SetSystemTime() for (time_t)-1:

   $ date -u -Is -d @-1
   1969-12-31T23:59:59+00:00

which likely succeeds as stress-ng prints the interesting timestamp 
"00:00:00.-99".

tv_sec = -1 is possibly valid but tv_nsec = -1 is not. I will post a patch.

-- 
Regards,
Christian

