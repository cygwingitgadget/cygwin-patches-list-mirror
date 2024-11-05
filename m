Return-Path: <SRS0=8qcp=SA=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id 4913E385840F
	for <cygwin-patches@cygwin.com>; Tue,  5 Nov 2024 11:37:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4913E385840F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4913E385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730806676; cv=none;
	b=EauQ/7ht9zP/D1MV/epldcpHwBeVnIuHHoUC0OGSiWW6XRya765+Px3OPmzfjhEtFFZ/kyJF6TyZjrht+dWEGSQSCCgLRd49e2i9OyScIYvuKaCOYWXLLNRKzaJESs4nJp9LWwbG6bPdw6cTqhZxYu8FUMKMZa5tyZYA68AzdDU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730806676; c=relaxed/simple;
	bh=XlljRMGHBVEOX3WbTRRiIeehPRkWYBMmivEBlmWU6H8=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=YpML2mO3SbUdRKxucD7eYmoiSXafKwMhoYUzOyor+dQEHSA6mh8OzSqqs3Xqtem//lVTMXxMKkcWawXndMaAL31zD531Gh98Zo0QBzWTjba/wQAOQvD5ZMUxUY8BRWKxIeHVfND7xdbzcyaF/bIfqfaJaOWwmLAGJn1SZeQ5Y9Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout02.t-online.de (Postfix) with SMTP id DBD7E1025
	for <cygwin-patches@cygwin.com>; Tue,  5 Nov 2024 12:37:33 +0100 (CET)
Received: from [192.168.2.101] ([79.230.175.122]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1t8HsL-11Ob560; Tue, 5 Nov 2024 12:37:33 +0100
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
 <ZyiinKXESiXU4AvU@calimero.vinschen.de>
 <683a0e8b-9a8c-4729-0594-353ff5e04ac6@t-online.de>
 <ZyjbgeaHuJEZmP3m@calimero.vinschen.de>
 <ZyjfC6-UiQDuYwoH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <bf4fbc09-f47d-61a9-3eaf-eaa6eef12197@t-online.de>
Date: Tue, 5 Nov 2024 12:37:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.18.2
MIME-Version: 1.0
In-Reply-To: <ZyjfC6-UiQDuYwoH@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1730806653-65FF94D7-4BF93436/0/0 CLEAN NORMAL
X-TOI-MSGID: 8384cf5b-3ac5-442f-9ca2-6bc76909f721
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_ASCII_DIVIDERS,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Nov  4 15:34, Corinna Vinschen wrote:
>> On Nov  4 12:50, Christian Franke wrote:
>>> Corinna Vinschen wrote:
>>>> ...
>>>>> - Invent a #define that allows to use the old function.
>>>> We don't need this.  We only want backward compat to keep existing
>>>> executables running.  So we need The old and wrong pthread_sigqueue only
>>>> as exported symbol.  On recompiling the affected project, the bug
>>>> hopefully shows up and can be easily fixed.
>>> Providing such a feature (only) for a few upcoming Cygwin releases would
>>> allow maintainers (e.g. me maintaining stress-ng) to easily provide packages
>>> which are backward compatible with still available [prev] versions of the
>>> DLL.
>> We never did that yet.  Going forward, we try to maintain backward
>> compatibility for new versions of Cygwin to existing executables, but we
>> never promised or maintained backward compatibility for newly built
>> executables to old versions of Cygwin.  That's setting an uncomfortable
>> new precedent.
>>
>> *Iff* we do this, then it should be least intrusive for the header,
>> i. e., add a new entry point and use that in the backward compat case,
>> kind of like this:
>>
>> -------------------------------------------------------------
>>
>> int pthread_sigqueue (pthread_t, int, const union sigval)
>>
>> #ifdef _CYGWIN_USE_BUGGY_PTHREAD_SIGQUEUE
>>
>> // TODO: Add some comment explaining this hack :-)
>> int __pthread_sigqueue_buggy (pthread_t *, int, const union sigval)
>>    __attribute__((__warning__("Using old version of pthread_sigqueue()")))
>>    ;
>> #define pthread_sigqueue(a,b,c)	__pthread_sigqueue_buggy ((a),(b),(c))
>>
>> #endif
>> -------------------------------------------------------------
> I guess if it's only part of the 3.5 backport, it's ok.

A closer look might suggests that there are no use cases for packages in 
the Cygwin distro:

I did a quick check unpacking all *.dll *.exe *.so (with --backup=t) 
files (~20GiB) from all x86_64/release/**tar* files from a local Cygwin 
mirror. An 'objdump -p' on each file (total 24Gib) lists 
pthread_sigqueue only for the various cygwin1.dll releases. Even the 
stress-ng package I maintain isn't affected because the related stress 
test is guarded with #ifndef __CYGWIN__.

-- 
Regards,
Christian

