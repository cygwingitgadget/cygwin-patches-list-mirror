Return-Path: <SRS0=0V9l=ZV=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id EC9EB3851144
	for <cygwin-patches@cygwin.com>; Tue,  8 Jul 2025 11:06:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC9EB3851144
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EC9EB3851144
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751972800; cv=none;
	b=a0sFgFR2O/OucMnsOczPE4sREcjnrqvL2x9XVwNeLbfMN22B3fQ6L5Zw3qRem5t0Q0bX5cywBMJxO6Ge4oxvoG9Bczb4XvVoFFLsaL8pRgBlnNxWzPUg5FWfGih18yYab/mG3qNvoryBii3/PoW/Tf0XQLfO4hGelEfPA32ZhHw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751972800; c=relaxed/simple;
	bh=2Oue3D39Bb9Xwa7QVA+SPy5jnw3yPFJOcnDTP4p6JDQ=;
	h=Subject:From:Message-ID:Date:MIME-Version; b=k5aei6dDieanUrngbDNHQf1D1usPCJlhVLMQKbt7rZNSbFAAU6JXWV+VdTErCoNktsg/ZOzUqcz0EtYnDrQYVVraTfoPNplyx/e0/LxcRs3xRZAmGesn+GfiM3+IzRonq61mZuLi4aF1mSGgzGlt618o8hlO9IOUj7B5gqdYjh4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EC9EB3851144
Received: from fwd87.aul.t-online.de (fwd87.aul.t-online.de [10.223.144.113])
	by mailout05.t-online.de (Postfix) with SMTP id 8312FA5E
	for <cygwin-patches@cygwin.com>; Tue,  8 Jul 2025 13:06:38 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.172.57]) by fwd87.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1uZ69l-0smr9U0; Tue, 8 Jul 2025 13:06:37 +0200
Subject: Re: [PATCH] Cygwin: CI: cygstress: update for stress-ng 0.19.02 and
 current Cygwin
Cc: cygwin-patches@cygwin.com
References: <b5fae801-1732-99ac-1fe1-6c2552407055@t-online.de>
 <8941f3e9-16ae-7130-0215-3c65dc3f9aaf@jdrake.com>
 <8e61bc54-b80f-cc69-6a54-4640cceff5cc@t-online.de>
 <0f17f3d0-94c9-febe-ac77-0c9e28ba1c2c@t-online.de>
 <77c8f91a-c51c-4d3f-9faf-e5d9d1430542@dronecode.org.uk>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <d03eaccd-c618-2f19-156c-61e12af4f132@t-online.de>
Date: Tue, 8 Jul 2025 13:06:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.20
MIME-Version: 1.0
In-Reply-To: <77c8f91a-c51c-4d3f-9faf-e5d9d1430542@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751972797-F67FA4BB-4EEB33ED/0/0 CLEAN NORMAL
X-TOI-MSGID: 18810289-394c-4561-b9c7-2de5b56a40ed
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,KAM_DMARC_STATUS,MALFORMED_FREEMAIL,MISSING_HEADERS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney wrote:
> On 05/07/2025 18:37, Christian Franke wrote:
>> Christian Franke wrote:
>>> Jeremy Drake via Cygwin-patches wrote:
>>>> On Tue, 1 Jul 2025, Christian Franke wrote:
>>>> -  fp            # WORKS,CI
>>>> +  fp            # FAILS     # TODO Cygwin: "terminated on signal: 
>>>> 11" (x86_64 on arm64 only), please see:
>>>> +                            # https://sourceware.org/pipermail/ 
>>>> cygwin/2025-June/258332.html
>>>>
>>>> -  memcpy        # WORKS,CI  # (fixed in Cygwin 3.6.1: crash due to 
>>>> set DF
>>>> in signal handler)
>>>> +  memcpy        # FAILS     # TODO Cygwin: "terminated on signal: 
>>>> 11" (x86_64 on arm64 only), please see:
>>>> +                            # https://sourceware.org/pipermail/ 
>>>> cygwin/2025-June/258332.html
>>>> +                            # (fixed in Cygwin 3.6.1: crash due to 
>>>> set DF in signal handler)
>>>>
>>>> These should be fixed now, by
>>>> b0a9b628aad8dd35892b9da3511c434d9a61d37f (or
>>>> cygwin-3.7.0-dev-161-gb0a9b628aad8)
>>>>
>>>
>>> Thanks for the positive feedback. Revised patch attached.
>>>
>>
>> Pushed with another modification because procfs test works now.
>
> Thanks for updating this.
>
> It seems that the 'filerace' test (new?) doesn't work reliably in the 
> CI environment.

This (new!) test never failed during many runs I did locally before 
tagging it as WORKS. There are also occasional failures of 'flock' and 
'fork' at GH.

Today I could reproduce one hang of filerace when the number of cores is 
closer to the VM behind GH actions.

$ cygstress -r 100 -c 16,18,20,22 filerace flock fork
...
  >>> FAILURE: 11:58:32.68: filerace (exit status 0, command hangs, 
processes left, files left in '/tmp/stress-ng.410.141.d')
...
  >>> SUMMARY:
  >>> FAILURE: filerace: 1 of 100 test(s) failed
  >>> SUCCESS: flock: all 100 test(s) succeeded
  >>> SUCCESS: fork: all 100 test(s) succeeded


>
> Would it be possible for you to take a look?

Yes.

Should I push a new script version which excludes this test for now?


>
> (As a aside, these CI failures are bridged to the #cygwin-developers 
> IRC. If there's somewhere else you'd like to see them reported that's 
> more convenient for you, let me know and I'll see what's possible...)

A frequent look at GH actions would be sufficient. I simply forgot it in 
this case.

-- 
Regards,
Christian

