Return-Path: <SRS0=Q8Ip=ZS=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	by sourceware.org (Postfix) with ESMTPS id 20270385F01D
	for <cygwin-patches@cygwin.com>; Sat,  5 Jul 2025 17:37:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 20270385F01D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 20270385F01D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751737036; cv=none;
	b=pN4QMSy2fTxvIjAh0z3HwEWdizIjUEzM6QUuKBLhLk56ULcHEXQ7oAXdo3BPzII0BZGwzdD9/rbmR5tDx4hRYukGbVVcwyQWBlHF9Ilv1PNERh+1WRROfpNudmO7c9alVvZbNjBPCDuAXqFsE0IRmL9cD0CE5+S+cmpOa31o2WQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751737036; c=relaxed/simple;
	bh=gmd0XYZU4gV8QNGGeTVopBzoxcyLKQ+yQUX6FKYe1FY=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=U6z3/GuoqxbiOeq+QnBNyTDDg4THqc7tcBIPKMu6skJ4r869xxMCAC4mx0+MRhwP6fAnAOsI/v6j9pG75L7m3xTiHeUkL11+tfwQ/qT+AFKlC6TXhUXXh9m992DQxMrBC9mNMDrfUjUFIEHTazPlFhHMOpV8mYocfsXQHsCDUUg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20270385F01D
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout04.t-online.de (Postfix) with SMTP id CC512E3B2
	for <cygwin-patches@cygwin.com>; Sat,  5 Jul 2025 19:37:14 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uY6p7-2jikXQ0; Sat, 5 Jul 2025 19:37:13 +0200
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.19.02 and
 current Cygwin
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Reply-To: cygwin-patches@cygwin.com
References: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
 <8941f3e9-16ae-7130-0215-3c65dc3f9aaf@jdrake.com>
 <8e61bc54-b80f-cc69-6a54-4640cceff5cc@t-online.de>
Message-ID: <0f17f3d0-94c9-febe-ac77-0c9e28ba1c2c@t-online.de>
Date: Sat, 5 Jul 2025 19:37:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <8e61bc54-b80f-cc69-6a54-4640cceff5cc@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751737033-BF7FC4F8-898A428B/0/0 CLEAN NORMAL
X-TOI-MSGID: 45b5b5e7-c609-45da-a03d-64031da86b76
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Christian Franke wrote:
> Jeremy Drake via Cygwin-patches wrote:
>> On Tue, 1 Jul 2025, Christian Franke wrote:
>> -  fp            # WORKS,CI
>> +  fp            # FAILS     # TODO Cygwin: "terminated on signal: 
>> 11" (x86_64 on arm64 only), please see:
>> +                            # 
>> https://sourceware.org/pipermail/cygwin/2025-June/258332.html
>>
>> -  memcpy        # WORKS,CI  # (fixed in Cygwin 3.6.1: crash due to 
>> set DF
>> in signal handler)
>> +  memcpy        # FAILS     # TODO Cygwin: "terminated on signal: 
>> 11" (x86_64 on arm64 only), please see:
>> +                            # 
>> https://sourceware.org/pipermail/cygwin/2025-June/258332.html
>> +                            # (fixed in Cygwin 3.6.1: crash due to 
>> set DF in signal handler)
>>
>> These should be fixed now, by
>> b0a9b628aad8dd35892b9da3511c434d9a61d37f (or
>> cygwin-3.7.0-dev-161-gb0a9b628aad8)
>>
>
> Thanks for the positive feedback. Revised patch attached.
>

Pushed with another modification because procfs test works now.

