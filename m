Return-Path: <SRS0=Nc2n=FE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
	by sourceware.org (Postfix) with ESMTPS id E77FD4BA23F7
	for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 15:28:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E77FD4BA23F7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E77FD4BA23F7
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=194.25.134.82
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783697326; cv=none;
	b=erRo9nQNVobJe9VxtJn2AOL3Z4LBJwXyP8YD1GjH2xyvXQnLMY/oGgtf/fcymASbM/PZAc+XMnpfs26n2OvOagzU6Mzr+Ef3YXtPCrFISiRhTvljItiCb/vBQJRgrWZMjXJsgZROHfO9JKFWA6l87uUYXhhTsTPkgtztMqYlKOk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783697326; c=relaxed/simple;
	bh=m+SSPEPbBEF6xQZoY3HmTSEkHX0AGzZoAvzVvXRauNw=;
	h=Subject:To:From:Message-ID:Date:MIME-Version:DKIM-Signature; b=GotCHc71E+74gu4yIxj7yir9VVCshWUvZmFgtDJEwOYg9i4hiDPZ6F1R+5fmN66Spml0adHHKD2BggAGq/QBjUX2HtoLSIVbGNhujQmeBD1YCc4QRO66WCoUpUR/naVlQr7Hl4rMsTpPaVq7pkVJi9+arP2MYWqZ12ZLIpU6DGg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=AENKrDbt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E77FD4BA23F7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=t-online.de header.i=Christian.Franke@t-online.de header.a=rsa-sha256 header.s=20260216 header.b=AENKrDbt
Received: from fwd96.aul.t-online.de (fwd96.aul.t-online.de [10.223.144.122])
	by mailout05.t-online.de (Postfix) with SMTP id AA5DA88A
	for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2026 17:28:42 +0200 (CEST)
Received: from [192.168.2.101] ([79.230.161.37]) by fwd96.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1wiD9Z-4FLu1Q0; Fri, 10 Jul 2026 17:28:37 +0200
Subject: Re: [PATCH v2] Cygwin: Fix error return for madvise()
To: cygwin-patches@cygwin.com
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015163.html>
 <20260708080349.570-1-mark@maxrnd.com>
 <dbe2155d-198f-76a8-13ae-924001cdf1b1@t-online.de>
 <77c47130-8a2f-4de0-ac6d-d80480bdbf20@maxrnd.com>
 <09ff62ce-42fd-f331-b541-c26af487a213@t-online.de>
 <20260710222733.50882151e5f8f33933a6bd73@nifty.ne.jp>
Reply-To: cygwin-patches@cygwin.com
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <03fb0969-2606-f49d-939e-6c0014a9ca29@t-online.de>
Date: Fri, 10 Jul 2026 17:28:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:128.0) Gecko/20100101
 SeaMonkey/2.53.23
MIME-Version: 1.0
In-Reply-To: <20260710222733.50882151e5f8f33933a6bd73@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1783697317-91FF89B3-AC087D49/0/0 CLEAN NORMAL
X-TOI-MSGID: f9d2ebc2-00c2-44ff-98f7-ba827cb14787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1783697322; i=Christian.Franke@t-online.de;
	bh=m+SSPEPbBEF6xQZoY3HmTSEkHX0AGzZoAvzVvXRauNw=;
	h=Subject:To:References:Reply-To:From:Date:In-Reply-To;
	b=AENKrDbtkPYz1ud3yY/6SAHbVY1yL6VX/Gte140mVz+kRRikfqQBjP8jyROBs55ey
	 5Odx1GSvFwUGteIph2hY2Z5rUdHNzeN0cJAmOF1GNI0y964VZcjAJeY4GfDAgL/riT
	 Ww4+qWYgvTv7i0wyO697T+Q+8SeZlN0Z9HjgdgMK7fLsNp97+HL7q47eJVotY13Inn
	 Cdy5gJOQIUKfolPw+Ztdvym4LnTIfsLRD3nynlaoIMJrbNBTb4SDrFXQm9QIZxU7fN
	 Gjzs2A8pz5KcbiLqOTnnKDhpsn8FLS4eZeHdujm1aXZejUkNrxg89zAtp7v3QJuyJ2
	 YrvT5CFyVo54w==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TONLINE_FAKE_DKIM,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano wrote:
> Hi Christian,
>
> On Fri, 10 Jul 2026 13:13:43 +0200
> Christian Franke wrote:
>> Hi Mark,
>>
>> Mark Geisert wrote:
>>> ...
>>> I prefer to keep both 'goto out' so there's just one exit from the
>>> function to aid future debugging. Perhaps that's an old-school habit.
>> :-)
>>
>> Don't take me wrong, the patch is GTG, IMO.
> I agree. Would you push the patch?
>

Done.

