Return-Path: <SRS0=Nc2n=FE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id AA0F74BA540B
	for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 11:13:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA0F74BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA0F74BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783682029; cv=none;
	b=LPGloYPA2CHFvepT/h0ssZoe/d6qtgxYdpmZ+mMB0jH1JB+6zeZ3HA8AIuul6DJRGXRsH4oSbZgJxsA9MCkdzv4Aknz4buBL3XgBYLOvLRZ7617SKyUcyfTc5axPl4wrKRSnNXpqa7vxaTBhrnkOjcBDsY2RxyP6Ker5o8jr+c0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783682029; c=relaxed/simple;
	bh=WlEU5cy1/3HMCQ9zThGSOZ6uA87TaVSo/PdgVx0cUjE=;
	h=Subject:To:From:Message-ID:Date:MIME-Version:DKIM-Signature; b=BCj5ci8vmyJ1U/4o+pZtKy5A/dUHW0vbDt72rvUDd7e8shj1PQZvhAMwZ7kCgM/xzBuhsz+l/0kFzXzeTjLQ2OrBLEEY/7q7f9clMHvVMHum47etQzNOp3JNHcJioV7RAWYHE0pqGbKvzBZF0vcvuRfymYniR53X/qKWAkZfg7Q=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=vohvkPMs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA0F74BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=vohvkPMs
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
	by mailout02.t-online.de (Postfix) with SMTP id 66F49EC49
	for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 13:13:46 +0200 (CEST)
Received: from [192.168.2.103] ([79.230.161.37]) by fwd86.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1wi9Au-1l2RO40; Fri, 10 Jul 2026 13:13:45 +0200
Subject: Re: [PATCH v2] Cygwin: Fix error return for madvise()
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
 <20260708080349.570-1-mark@maxrnd.com>
 <dbe2155d-198f-76a8-13ae-924001cdf1b1@t-online.de>
 <77c47130-8a2f-4de0-ac6d-d80480bdbf20@maxrnd.com>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <09ff62ce-42fd-f331-b541-c26af487a213@t-online.de>
Date: Fri, 10 Jul 2026 13:13:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
In-Reply-To: <77c47130-8a2f-4de0-ac6d-d80480bdbf20@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1783682025-84FF69E2-5BB94AFE/0/0 CLEAN NORMAL
X-TOI-MSGID: 7c5781e5-96ce-4220-a946-553aa27e8525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1783682026; i=Christian.Franke@t-online.de;
	bh=Y6cE8St3OlBDHUXq/N/L6NtbxKiFh9A4dxGM/AAe1WI=;
	h=Subject:To:References:Reply-To:From:Date:In-Reply-To;
	b=vohvkPMsfs5XoCPhQzGx9Gsp8PQMlFSiCyP1tUuSRn0bYdJRhr4pcDTJ7R75E55/g
	 6OOHQq9BWfj1a0HRDa11QpaJ5qz3BsuWI/LGpsMArwKRnWs3nxXoUC3b7ZVrC+w+Hy
	 B8YPNHrIlVfVd4zrKPKtmjBfImdYUn/vntpr0nWn0yVxkDhIlPrvpGjy2ozkTBnUYy
	 OlnwOs+jR89dWYdNaWW7Cr5QZiGK3Qpko0fNzwx8eRuietJosOb9qhDhPwPx9jpwSk
	 jYD3SGVBbJIQDarlAj1KMwlR42MmxZHiRbenbXDkJVMrxXhyrwxa0xOSTK5dS7Sdu9
	 N3lD6jFGrlTvQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Mark Geisert wrote:
> Hi Christian,
>
> On 7/8/2026 7:58 AM, Christian Franke wrote:
>> Mark Geisert wrote:
>>> Currently madvise() and posix_madvise() are wired together as one
>>> function: the latter.  But their error returns should be different.
>>> Make madvise a first-class export in cygwin.din.
>>>
>>> v2: Create madvise_worker() and have madvise() and posix_madvise()
>>>      call it, then handling their error returns compliant to POSIX.
>>>      Add a release note for 3.7.0.
>>
>> LGTM, thanks!
>>
>>
>>> ...
>>> -extern "C" int
>>> -posix_madvise (void *addr, size_t len, int advice)
>>> +static int
>>> +madvise_worker (void *addr, size_t len, int advice)
>>>   {
>>>     int ret = 0;
>>>     /* Check parameters. */
>>> @@ -1514,6 +1514,26 @@ posix_madvise (void *addr, size_t len, int 
>>> advice)
>>>         break;
>>>       }
>>>   out:
>>> +  return ret;
>>> +}
>>
>> PS: The 'goto out' could now be replaced by 'return ref'.
>
> I prefer to keep both 'goto out' so there's just one exit from the 
> function to aid future debugging. Perhaps that's an old-school habit.

:-)

Don't take me wrong, the patch is GTG, IMO.

-- 
Regards,
Christian

PS: I prefer early returns if possible, declarations when needed instead 
of on top, and avoid 'goto's (which conflict with 'declarations when 
needed' of C++ objects). See fhandler/dev_disk.cc.

