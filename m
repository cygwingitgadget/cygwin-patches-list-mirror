Return-Path: <SRS0=14y1=S4=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id F147D3858C54
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 09:20:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F147D3858C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F147D3858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733217627; cv=none;
	b=pXTMsj5lV3axp1oleHMYho6HZixaUYJPjW7zscHN1Nv3bZ1ph+ny0ou7OUwjkzyY0D6zgxmy7TEqhrfsTwuIlSv00ZVZBwDnUwiDUXZ/UhmqBobk6Kl3UoISGCfCIYOJphXrvwQfVXpNcb2a/N8138sZW9l2tDBMPngkQGjymtk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733217627; c=relaxed/simple;
	bh=FWMccbCtvdh0cvUq5Rq8PzSYwFp2buY7N32CBnHITlY=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=HhcYgYheS4q5D2bNaIqX6fYAN4+0sUMoIuQc5Ao/rrMM0wGAGKaSrOByNk9Sm+L23MVs4vMWOhuIv1BmMZXGhDuL2HPJuf9cBg8POydYSxTeonYwFjy1ATOcxfOvI/e96EfvNx5F+fCWbuPjohAm4/XE7j4LQOyJmb83yRx14+Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F147D3858C54
Received: from fwd74.aul.t-online.de (fwd74.aul.t-online.de [10.223.144.100])
	by mailout08.t-online.de (Postfix) with SMTP id 818211294
	for <cygwin-patches@cygwin.com>; Tue,  3 Dec 2024 10:20:25 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd74.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tIP4u-1aM0ZM0; Tue, 3 Dec 2024 10:20:20 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
To: cygwin-patches@cygwin.com
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
 <Z03Tik1rbM4sMpKl@calimero.vinschen.de>
 <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
 <8734j6q6qk.fsf@Gerda.invalid>
 <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <80e1716d-d268-e5cd-b9ff-484aa5dcc344@t-online.de>
Date: Tue, 3 Dec 2024 10:20:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <c6f21ed2-679d-4a89-a8a3-b0b1e9d1714f@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1733217620-217F710B-333FEB05/0/0 CLEAN NORMAL
X-TOI-MSGID: 19a29a98-d1e9-4384-8378-139e1730bc6b
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Brian Inglis wrote:
> On 2024-12-02 11:28, ASSI wrote:
>> Christian Franke writes:
>>> +    nice value   sched_priority Windows priority class
>>> +     12...19      1....6          IDLE_PRIORITY_CLASS
>>> +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
>>> +     -4....3     13...18          NORMAL_PRIORITY_CLASS
>>> +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
>>> +    -13..-19     25...30          HIGH_PRIORITY_CLASS
>>> +         -20     31...32          REALTIME_PRIORITY_CLASS
>>
>> That mapping looks odd… care to explain why the number of nice values
>> and sched_priorities doesn't match up for each priority class? 39
>> possible values for one can't match to 32 for the other of course, but
>> which ones are skipped and why?
>
> See also miscfuncs.cc which maps nice<->winprio with a 40 entry table, 
> and cygwin-doc proc(5) or cygwin-ug-net/proc.html which explains the 
> mapping to scheduler priorities and policies.

No *_PRIORITY_CLASS is mentioned in current newlib-cygwin/winsup/doc/*.


>
> Also relevant may be man-pages-posix sched.h(0p), man-pages-linux 
> sched(7) and proc_pid_stat(5).
>
> You may also wish to consider whether SCHED_SPORADIC should be 
> somewhat supported for POSIX compatibility, and SCHED_IDLE, 
> SCHED_BATCH, SCHED_DEADLINE for Linux compatibility?

SCHED_IDLE: Ignore nice value and set IDLE_PRIORITY_CLASS ?
SCHED_BATCH: Reduced mapping, e.g. nice=0 -> BELOW_NORMAL_PRIORITY_CLASS ?
SCHED_SPORADIC, SCHED_DEADLINE: ?

The current newlib/libc/include/sys/sched.h only defines SCHED_OTHER, 
SCHED_FIFO, SCHED_RR and SCHED_SPORADIC. The latter is guarded by 
_POSIX_SPORADIC_SERVER which is only set for RTEMS (#ifdef __rtems__) in 
features.h.

