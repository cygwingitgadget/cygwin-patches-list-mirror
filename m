Return-Path: <SRS0=uN41=S3=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id 09A3C3858C5F
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:58:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09A3C3858C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09A3C3858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733165923; cv=none;
	b=CM+D4Bckz1klPEVKzgp2o9OVyiPrmhW2Cows65q6j9aRRE6/ka0xLkLamX/Tkgi2kFUGnFB+3EloUGLO6Ij72T0edc7Ezo09xYHwVT9ULgBjvHq4GCpxRxgseUGTaEvbW0vA4dam6rbET3qzbaPvdlMK4CcR0adGAGZLtnDDeGo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733165923; c=relaxed/simple;
	bh=MB5WEEJFmM17mTy/6gUUv7KqQtgFVOXR8HQp1BzE0Os=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=FOWJrJPhebp1NiGag3v5QsIuxX/VCzsFmgPGreHILRMxRbdyS9xmUQ3tn3H+9k1EH6KD3ZYNSVi83XSVMmRKBLBYVh64GUVm2k5KINxyfQIYfJ5yDKD5xxQvtb8f1bdhrVt3agNKDuTK+d8kmqCDdG4gPoQP67hhY0Q1oOLCqOU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 09A3C3858C5F
Received: from fwd80.aul.t-online.de (fwd80.aul.t-online.de [10.223.144.106])
	by mailout07.t-online.de (Postfix) with SMTP id 754E4148A
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 19:58:40 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd80.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tIBd0-1eLUaO0; Mon, 2 Dec 2024 19:58:38 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <1a3eb3c2-0059-322b-1c1f-321edc79b059@t-online.de>
Date: Mon, 2 Dec 2024 19:58:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <8734j6q6qk.fsf@Gerda.invalid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1733165918-2E09C26E-568411F9/0/0 CLEAN NORMAL
X-TOI-MSGID: 17abb05a-623c-4fd0-b9f3-d65a263aae9e
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

ASSI wrote:
> Christian Franke writes:
>> +    nice value   sched_priority   Windows priority class
>> +     12...19      1....6          IDLE_PRIORITY_CLASS
>> +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
>> +     -4....3     13...18          NORMAL_PRIORITY_CLASS
>> +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
>> +    -13..-19     25...30          HIGH_PRIORITY_CLASS
>> +         -20     31...32          REALTIME_PRIORITY_CLASS
> That mapping looks odd… care to explain why the number of nice values
> and sched_priorities doesn't match up for each priority class?  39
> possible values for one can't match to 32 for the other of course, but
> which ones are skipped and why?

I don't know as I only documented the long standing existing mappings here.

-- 
Regards,
Christian

