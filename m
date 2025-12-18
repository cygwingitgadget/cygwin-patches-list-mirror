Return-Path: <SRS0=nogY=6Y=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 01C914BA2E04
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 22:24:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 01C914BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 01C914BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766096667; cv=none;
	b=lOLA8gJgAU1MHLgnshPZCycaYEuuECfFY8MwAC95TquX08cKRj0GTSBMGaUPYxUfD7kNGBeGjRtac+qRnik64/8d9Z5KS89zbZ6d/+WZqeMeyhw5ILRu7ClpnSCQJccf57+5Rx46vUBIkkVbpYrIIZDV8Bm9LlCgKnjXklIAaas=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766096667; c=relaxed/simple;
	bh=Sq4OqGDSMUH2z2bat+UWaIvS/vP8SJnAx3YshyyRdwc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=JR609QPgNNTYf7sdQTf9Lz1Stci93KgH5qbr3fIQg8m1DSeg/psiwI7zkSLS20zc4TMaJ1QBIQcmTpCr6d/KQzEVpXvOuWXGrbgJAHECJJIq8s4+cGR23MJnftlQEJhMXnnCPyNKxj8ZLdlJrjOx04HZv4exhx+YVFPEhWNifi0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 01C914BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=AzFVWwhv
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9E73A13AA97
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 22:24:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf04.hostedemail.com (Postfix) with ESMTPA id 2F3B920023
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 22:24:25 +0000 (UTC)
Message-ID: <6e67d97e-60a0-4bff-8a4e-cf4e90411603@SystematicSW.ab.ca>
Date: Thu, 18 Dec 2025 15:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
To: cygwin-patches@cygwin.com
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
 <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
 <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
 <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
 <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
 <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp>
 <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: eo3xeffqecex8458pxyqhxidzfyb7kbs
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2F3B920023
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/vIE3arYHXV54altr949k06aU7a5rWtAk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=nkmDOIvp5Rom3rVY92NCXy+PvdtjUzqQsAMF7SGJHWU=; b=AzFVWwhvHBxmgGRRiXLhSThdI3Dh07IrFYqKaJdbnRdNAg+46u2h0WP1XX8rRFHg/JwONqJiuFgdXFqrcaaPrh9Bgae2vzhOuR/FJIbcx02TzsgvklSWAgvEqYui0iMPEC2s1yKDE8tVuZ0OZtg7sdLlDsub3FcD4XOsUaiP2yrQSV1koGISgnXGYxmIjS8U14ZHqBx60xw6Bn/tPipx7BfLojM9yqE9hKSqCjxRa/Jx2niDruULTxMekgGtKVFvUzfeiDvFbFoBA3YI7Z3NIf1OKKdsTuyVG2X5UVBAmOr15SExp5p0si4afsMzJ+R++sEkQtO65HYcqlb6LudAAQ==
X-HE-Tag: 1766096665-107059
X-HE-Meta: U2FsdGVkX1+QnhY9SLK6cbUEb+oG+x5qmuPFnz6fxTIfjRp1+5tk6/HM20q8DIDHvXZ+KyACpT2MRb5g7kUpPyQBrsQz2HwftI+bjQvguXnE8yS6YGQ/J0Rbtx5v0zugiLbi7Zrg353N4QGYTqg7ioErz3I18pb4bH5YrBdcTAUgAQhO6N9nY4OLX+H6WcDLXAueBp2TMbRKeR9TN6TCrY+woT1SrgBZ9xW6mrKENRnoOkrumLJ/4GwgpklJWKE/Ce/oKTIWRnC5yhFp93JND2uJFhvT8MTd0f8YjTFHunAjnR7Ho+wgFaH67NB52PmGyA54MNpSbtkX376jAWl13yJQluvyMELxUQFqDWYmhmC4UPk7Q8Rfh/eSxTHyy6Gm4lslJXWfXX7O9EOZFSVu3DowQhf2Sk2N6GDPqXM/25HXFYHMNdzBb/b/UFzuVVY9Fa80KoCwY6U=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-12-18 00:45, Johannes Schindelin wrote:
> If Cygwin were merely a personal project of yours, I would understand and
> probably agree.
> 
> However, Cygwin is used (via the MSYS2 runtime) in Git for Windows, and by
> extension millions of users rely on it.
> 
> Therefore, it would be good to at least publish those local tests.
> Ideally, a good deal of thought should be spent on figuring out a way to
> integrate the tests into the CI builds.
> 
> You mentioned winsup/testsuite, and I do agree that it sounds more than
> just tricky to integrate the tests there. Essentially, you would probably
> end up reimplementing AutoHotKey's fundamental functionality: sending
> keystrokes and inspecting the results.
> 
> Now, to be sure, running AutoHotKey-based tests is a lot more finicky than
> running winsup/testsuite. In the absence of any better idea, though, I
> would take the confidence from having tests over not having tests, any
> day. After all, you and I are both fully aware of the unfortunate pattern
> in the code under discussion where on multiple occasions, bug fixes
> introduced new bugs whose fixes introduced yet other bugs, etc ad nauseam.
> If AutoHotKey-based tests can help break that pattern, let's integrate
> them.

Who will port AHK to Cygwin tools to make it available as a package?

Alternatively, do we really need to:

	https://www.autohotkey.com/boards/viewtopic.php?t=9806

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
