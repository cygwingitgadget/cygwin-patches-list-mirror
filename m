Return-Path: <SRS0=gnuO=KJ=nexgo.de=Stromeko@sourceware.org>
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	by sourceware.org (Postfix) with ESMTPS id 03EC63858C55
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 10:39:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 03EC63858C55
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 03EC63858C55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=145.253.228.166
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709462394; cv=none;
	b=Whb2x5fEwFK3B+i1bkVpx8fkoB1igRYnQ6nVXAYbk9yMy/GBNybIqrcZkxC1kQiCan9gxvSGs9r3imT3IV93nOtqCUX1CU3POHDYzXIkjV6GVRtN08ts/K5d+hdGPXbR+Vf4Z9RDlm6gH0Zo6hsmwsszEfZgF+xsNGKj8/FkO/U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709462394; c=relaxed/simple;
	bh=qpXhwmntk6WNulTxqDUEm/KahxC9j6Yqwqt49NaocZ4=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=xDUZL84yd8mN9V94KqmLqFLGwPyup5UTwxYhvw2dUGiLXSLWg1lXG1roYUS8e8kh6KWwFqJicJqdaNipxhPVT+aYJSVogde238x3S93ksgQemu/mjLOlrWFfojdw9GBeU8a9oGi1QQGMRDGWHoMRt+GJB54UG6SfyTKiIdupjzo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1709462390;
	bh=Un2mkJHmNJfRtOw5F5fFcXFHqC9luIwjrKjIILHlXIc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=LGinrzSfWoyCrw5A5wq7DA4dbtvhNExidjrmROLQsVkogD8RZG7EefpzvTtN10IHe
	 Yv7o0PkwonAOAkux3zVJfwyXgEeZ2m0s+aTdAqSIN+wgIjYUySY7oYBtU9dAsKqer/
	 i9V00kGt/VYQiYn7OdOzhNfbITF41Vt6uJ76b9jY=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4Tndck4Bqvz1y1B
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 10:39:50 +0000 (UTC)
Received: from Gerda (p57b9d928.dip0.t-ipconnect.de [87.185.217.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4Tndcf1lWwzMkrt
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 10:39:43 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
In-Reply-To: <20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp> (Takashi
	Yano's message of "Sun, 3 Mar 2024 19:21:09 +0900")
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
	<b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
Date: Sun, 03 Mar 2024 11:39:40 +0100
Message-ID: <87a5nfbnv7.fsf@Gerda.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 699
X-purgate-ID: 155817::1709462386-6DFFE6E3-7B7F71FA/0/0
X-Spam-Status: No, score=-3030.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano writes:
>> After noticing that we enumerate all the processes (which is an expensive
>> operation) just to skip all of the non-Cygwin ones anyway, I wonder if it
>> wouldn't be smarter to go through the internal list of cygpids and take it
>> from there, skipping the `SystemProcessInformation` calls altogether.
>
> Yeah, that makes sens. I'll submit v2 patch.

Keep in mind that there may be different independent Cygwin
installations running on the same nachine.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Waldorf MIDI Implementation & additional documentation:
http://Synth.Stromeko.net/Downloads.html#WaldorfDocs
