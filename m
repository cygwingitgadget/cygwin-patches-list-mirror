Return-Path: <SRS0=PjSC=EE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	by sourceware.org (Postfix) with ESMTPS id 3E1B34B1969E
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 12:11:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3E1B34B1969E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3E1B34B1969E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780920662; cv=none;
	b=fdcEo6V0HT4gjrEutwSz4TVM7dUoAWLfsGfC0ZWLrZN2+DsSsZDscGIx4js9RtVD7bQVTW4HAlxRjR6+GTsoXDgL10RgmOa21Y8xKXfbs0GJBSI0QekPiM7S8lfxXuo1xtXCyiwjiBJkzAa7mr0iY/J5pP28zPp/qlfQRUc9Di4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780920662; c=relaxed/simple;
	bh=xcPNW+wSQb8yqpDu1Ne9+XZJ5ZVPzxkhGcTsA4mkLt8=;
	h=Subject:To:From:Message-ID:Date:MIME-Version:DKIM-Signature; b=srqWU5Fj6qGbTd+bTcW4bwkaPP6aOdtESYBWp4IzFRiThFCPmkUzPqImerI+ERzxGi9Q6iq/xUNDQxHaT8yqnJB+3bRQlrBs/aYLTq+YnpN8UCqJKGuZtPs/RT5peCKgDdHigXWOgVPAKUQ6KeOgPHAF0Q75azagB34bnC1caV0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=HRYXbadf
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3E1B34B1969E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=HRYXbadf
Received: from fwd90.aul.t-online.de (fwd90.aul.t-online.de [10.223.144.116])
	by mailout12.t-online.de (Postfix) with SMTP id 6BCB2E6AF
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 14:10:59 +0200 (CEST)
Received: from [192.168.2.103] ([79.230.161.37]) by fwd90.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1wWYog-2tnVei0; Mon, 8 Jun 2026 14:10:54 +0200
Subject: Re: [PATCH] Cygwin: Implement 'reserved' marker in fdtable entries
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260522072913.574-1-mark@maxrnd.com>
 <e5a59828-cdab-4d8a-980c-14b52a5c0d32@dronecode.org.uk>
 <d457a7fd-1eee-0dd0-b2f7-d46b84eeaa42@t-online.de>
 <743b62ce-feab-49bf-95d0-f958fd5dacde@dronecode.org.uk>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <dd93e38a-84ff-8440-1b1d-fbea31fa6298@t-online.de>
Date: Mon, 8 Jun 2026 14:10:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
In-Reply-To: <743b62ce-feab-49bf-95d0-f958fd5dacde@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1780920654-627FA5BE-B72D3306/0/0 CLEAN NORMAL
X-TOI-MSGID: ce0f64f5-84d6-4d88-8b00-9c777b2365d7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1780920659; i=Christian.Franke@t-online.de;
	bh=caAZoUnU0A4Rr/ZfCVaq/E2MV4vvtIN97FJK6SDr0cU=;
	h=Subject:To:References:From:Reply-To:Date:In-Reply-To;
	b=HRYXbadfloRBkCj/F1K6PmZxjiBX74Kx/1EVXcUDlnz2auUbvn840hPv+m3VuPMjc
	 WZHWB0oCNb48WA4rMm0JR8Yy71uSOvM3lrlkn3MELsUYE/amLzN4IQtSygsw1iDDVD
	 xsOkwvpUhpc4/0S+EqIbA84wRTsMRGkgc/9t/Hd73w+7FSx5xTLSGEOdb2nStjtOFo
	 4OPpSDget4UCkxmbb4PccW4W4H2chJVaSNuTKsSv7W7xfREsMHl/xFQxb9TLZm/qYx
	 H1nT0LVDiLlIqW+8GeDAkNbJjCUMTig4j6oVaBgx7C2Uu0zWBK2CI3F5g+a3UgwzV1
	 8UfyZza8wTbVA==
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 30 May 2026 12:33, Jon Turney wrote:
> On 22/05/2026 15:21, Christian Franke wrote:
>> Jon Turney wrote:
>>> On 22/05/2026 08:28, Mark Geisert wrote:
>>>> ...
>>>>
>>>> The notion is that an fdtable entry provided by cygheap_fdnew is 
>>>> marked
>>>> so that another thread can't obtain it.  Care is taken to reset the
>>>> marker when the entry is no longer needed.  Actually, in the usual 
>>>> case
>>>> the marker is overwritten with a pointer to an fhandler_base 
>>>> structure,
>>>> by the reserving thread, as the syscall completes.
>>>>
>>>> Reported-by: Christian Franke <Christian.Franke@t-online.de>
>>>> Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
>>>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>>>> Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)
>>>
>>> Thanks!
>>>
>>> This all seems fine and reasonable, but I have a couple of small 
>>> comments.
>>
>> A test with an enhanced version of the STC was successful.
>> I could push this version (attached) to cygwin-apps/stc if desired.
>
> Yes, that would be great. Please do so.

Done.


>
> (I guess ideally after the fix is committed so it stays green, but 
> it's red at the moment and I severely lack the time to investigate 
> why...)

Some STC (e.g. trace-sigsegv) ocasionally fail when run as part of the 
Cygwin CI workflow. Timing issues?

Could not reproduce this neither locally nor at GH.

I would suggest to add this to stc.yml to allow manual tests independent 
from push:
https://github.com/chrfranke/cygwin-stc/commit/5c157ff6

-- 
Regards,
Christian

