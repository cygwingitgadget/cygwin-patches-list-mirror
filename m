Return-Path: <SRS0=XeBt=XQ=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id A8CEC3858D21
	for <cygwin-patches@cygwin.com>; Wed, 30 Apr 2025 11:33:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A8CEC3858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A8CEC3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746012834; cv=none;
	b=pK+jUYVpZjiY0R1LpRZ5Ii/trutCksKFnJinkJ14ET3kATCvb5I98Y045qnKRQnTgTQTPiI45OISN+TICn0X550+kKnznT94/8M/3CyflagpsHIUE3d38IvQd41rF0gBL9N2hhSWUxxqZykB/XQgi+GfWemdJjEAD8d57w50J/g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746012834; c=relaxed/simple;
	bh=l8xMhqXBT24sHCy3yi/ypcG6AFjj5eYJn2YHSmZ7fQ4=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=Y0kDNxBjEBOXf1fkIDvtGrmlcPgzb/SVdOUxxngjkFLBuGalz1HPt88059OCp6cluWWrDT/k9ol6jCMsA/QoSoxPokhTnup142yk0Kd8OstDgHmNyXIMvZ1N7rwpGYIgr2ETXM3ml1OfRu5RCJerIdOhn05oh41eRKGGqJSVHhA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A8CEC3858D21
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
	by mailout05.t-online.de (Postfix) with SMTP id F20B88D8
	for <cygwin-patches@cygwin.com>; Wed, 30 Apr 2025 13:33:52 +0200 (CEST)
Received: from [192.168.2.101] ([91.57.247.175]) by fwd88.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uA5hE-3bA0p60; Wed, 30 Apr 2025 13:33:48 +0200
Subject: Re: [PATCH] Cygwin: clock_settime: fail with EINVAL if tv_nsec is
 negative
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <f21927b5-defe-529d-3095-0c1f51e23eb7@t-online.de>
 <274da5b5-b94c-4ccc-8b58-713965a62e93@dronecode.org.uk>
 <09edeb3e-6c0c-74bb-75df-a7dd2bde2e5e@t-online.de>
Message-ID: <9e95644c-c152-00ed-14d1-725252066fa6@t-online.de>
Date: Wed, 30 Apr 2025 13:33:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <09edeb3e-6c0c-74bb-75df-a7dd2bde2e5e@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1746012828-4B7FD92D-924946D8/0/0 CLEAN NORMAL
X-TOI-MSGID: 69273fd2-4b3f-469a-88a4-d0449bd4f989
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Christian Franke wrote:
> Jon Turney wrote:
>> On 28/04/2025 16:43, Christian Franke wrote:
>>> A followup to:
>>> https://sourceware.org/pipermail/cygwin-patches/2025q2/013678.html
>>
>> Thanks!
>>
>> The SUS page for clock_settime() contains the following text:
>>
>>> [EINVAL]
>>>     The tp argument specified a nanosecond value less than zero or 
>>> greater than or equal to 1000 million. 
>>
>> ... so if we're going to validate tv_nsec, it seems that's the range 
>> to use
>>
>>
>
> Yes. The patch only checks the lower bound because the upper bound is 
> already correctly checked later in settimeofday().
>

... and pushed.

-- 
Regards,
Christian

