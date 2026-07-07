Return-Path: <SRS0=PtmG=FB=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
	by sourceware.org (Postfix) with ESMTPS id 60C6C4BA5435
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 10:33:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60C6C4BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60C6C4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783420382; cv=none;
	b=L7OhzG5mv/lpGn+vgJEgh6CC3FZETeSHw8OWEEytBxcdSfzfP7Yi8P0urRejygUCQMEcBUwXfMFh3MSoJqugdhMmxwDy09gzhIAotiQtNPMWbDPrdgJQQs6cXOOu8J6uHSJPDpRDrrq7lkYAd/dDxAUoobu1D3gev8RxHrb5wEI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783420382; c=relaxed/simple;
	bh=zrGpM0wlIPUlrlK33tk3gf3iWi1Jg6Qw8WIC42fAXRA=;
	h=Subject:To:From:Message-ID:Date:MIME-Version:DKIM-Signature; b=UqgxLflRz7h2/d5cqp0Lw2n7HG+Wg3KUU5mPXq5fD0AIeDg4z45eADyyj70tAEujwFO1H+/OQgO7kHfvqZmKyGz4QT7Makj3UCa7ihBOWVkg0VBr6Zoa1WsbnBT6pwXPomn4tfWTo35R37+dJjRZvs5o/ZxXpS0V0iejA84AaH0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=dCpxCET6
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60C6C4BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=dCpxCET6
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
	by mailout01.t-online.de (Postfix) with SMTP id 08FE81C3A7
	for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2026 12:32:59 +0200 (CEST)
Received: from [192.168.2.103] ([79.230.161.37]) by fwd73.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1wh36m-1P5YLQ0; Tue, 7 Jul 2026 12:32:56 +0200
Subject: Re: [PATCH] Cygwin: Fix error return for madvise()
To: cygwin-patches@cygwin.com
References: <20260706234758.89659-1-mark@maxrnd.com>
 <20260707094551.c89e6c61a79c534f6c385d5a@nifty.ne.jp>
 <646b21e0-df07-46c0-95c2-854405cc1d30@maxrnd.com>
 <20260707175835.8a5add90fd3b703254d09971@nifty.ne.jp>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <3ba9b93f-5de2-a82e-5513-462f2eab8b41@t-online.de>
Date: Tue, 7 Jul 2026 12:32:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
In-Reply-To: <20260707175835.8a5add90fd3b703254d09971@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1783420376-B27FB9C6-27CB4978/0/0 CLEAN NORMAL
X-TOI-MSGID: 62e47cb8-487b-4a25-b509-b9f0063472e7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1783420378; i=Christian.Franke@t-online.de;
	bh=NywqhXtdNB01hUSUD8vgb2nTP2ZMOAPSnG1aJ8Us6nM=;
	h=Subject:To:References:Reply-To:From:Date:In-Reply-To;
	b=dCpxCET6lljeitemm09cVORrjwKM1UgjBzP6F/n0yzrWPVBFjhIIXxUwwVw0IFADK
	 +Z59RTEaWQfZ1gtue1wOsRLi/Z/PHtWEwmjcl8h1pNR030+Lk7ImBQndqKtY/bV7oV
	 GdNtl9EdDYBR/BVQl4kRZgrOukh1XfPSqWjQZ2EqwYUfTwnoge+yOiVBFFzu5i9SHM
	 8jDLOLMB0aFhkHGqyCTq0fWCegQeMQypD9Fur7zsWHuZgmla+YMPNsfm8VL42p7IEM
	 MR+SIsOdvyJs+AoBsbWGgbzeWx5OcLk4ZkRNpJSew14LF7lt1jVvQpl+XVy2okbLRV
	 IdoIdnSFeFlPQ==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

Takashi Yano wrote:
> Hi Mark,
>
> On Tue, 7 Jul 2026 00:58:48 -0700
> Mark Geisert wrote:
>> Hi Takashi,
>>
>> On 7/6/2026 5:45 PM, Takashi Yano wrote:
>>> ...
>>> I don't think we should change CYGWIN_VERSION_API_MINOR value
>>> because the API itself is not changed. This patch fixes a bug
>>> in madvice() implementation.
>> I went back and forth internally on whether the minor version should be
>> bumped.  One point was whether divorcing madvise() from posix_madvise()
>> in cygwin.din warranted an API bump: without a bump won't existing
>> programs be unable to access the new error return behavior?

Existing programs will call the new madvise() function. The existing 
DLLs provide a distinct symbol 'madvise' which will then arrive at the 
new function.


>>    Another
>> point was that the error return behavior of madvise() is being changed;
>> isn't that behavior part of the API?  I agree this is a bug fix but such
>> fixes could cause API changes.
> I could not found the case that API version bump for behavioral change
> in the past.
>
> The adding MACROs such as:
>    148: Add open(2) flags O_SYNC, O_RSYNC, O_DSYNC and O_DIRECT.
>    149: Add open(2) flag O_NOFOLLOW.
> could be a 'behavioral change', but header files for user were also
> changed in these cases.

For this change of the return value of nice(), no API bump was requested:
https://sourceware.org/pipermail/cygwin-patches/2024q4/013015.html

 From the point of view of officially released versions, it would be 
possibly sufficient if the first 3.7.* release will have a larger minor 
API version than any 3.6.* has or will have.


>> This is a case where I'd like to get input from other folks who might've
>> made similar changes to Cygwin over its long history.  I am totally OK
>> with removing the API bump in a v2 patch if that's the consensus opinion.

Two unrelated suggestions for a possible v2 patch:

- Add a note to winsup/cygwin/release/3.7.0

- Provide distinct 'syscall_printf()' for both functions: rename 'extern 
... posix_madvise()' to e.g. `static ... posix_madvise_worker()`, add 
two new 'extern ... *madvise()' functions calling it, move the 
'syscall_printf()' (which then also allows to remove the 'goto out').

-- 
Regards,
Christian

