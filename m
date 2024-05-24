Return-Path: <SRS0=diw8=M3=scientia.org=calestyo@sourceware.org>
Received: from hedgehog.birch.relay.mailchannels.net (hedgehog.birch.relay.mailchannels.net [23.83.209.81])
	by sourceware.org (Postfix) with ESMTPS id E03F23858403
	for <cygwin-patches@cygwin.com>; Fri, 24 May 2024 20:34:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E03F23858403
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=scientia.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E03F23858403
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=23.83.209.81
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1716582868; cv=pass;
	b=HPCxAryzkv7miAaBgr6XBqVuCaZz1JcpviD9haAwD2A6a3sSEcyqPIkhJ9by+W3KvpCsSb+VkAeMaQaWz+h/kKlQXsxyUv6YvAxp6THHDEGsuT0SwM4ZTRmcpATfPA2X6kkElTuDOyarjuJfbdXjiwIkD3fsI1Hmpn1IWi+nMwI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1716582868; c=relaxed/simple;
	bh=9IbJaiLx99WvKuYG9ZA8c/hY5uth8Kr/SyIcjOG8zuQ=;
	h=Message-ID:Subject:From:To:Date:MIME-Version; b=gOap28qDACsbhqwO5kJDd6q/9Hk7LCIIPXMdEzGbVtZBFScwop/VP3Zq/njxKapyLMCkzazZLIbBIYh9Z733kfiCg8sTTAiaO/HLWQwrqOjVbGBrZUejuxa7NSd2MnXTmwDaalY9b+ATOPxemHTY1m+HmXAxGKKatAk2X6haZxo=
ARC-Authentication-Results: i=2; server2.sourceware.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B6601941C63;
	Fri, 24 May 2024 20:34:25 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id AF53094428D;
	Fri, 24 May 2024 20:34:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1716582865; a=rsa-sha256;
	cv=none;
	b=JG2xEdfSDAyaWvE3bnB3KX6uYZWu2WQilWBcPwyjL2u/I3rGwDKzYdbtEevyrt8K++cMA5
	1EspgSQDGwh5wTI8mpDTJQiw57n7Hlv3/gSuCFBq4dTEmovP0563TQqAiAiT2XV5AEt//h
	hK6K1ij8EgekVerTA/zPcBHtHoQbyWZrqxXmw4tQj/2Nu8JH2FNl9fxWPJDs53oJN2KTdg
	uMQONH7HMwpbctkxXmINqdd3uDiu8jPeENdURQNGRbzoSdr4Ma5bFLX/4Spt0XcXz2Wlfk
	1d3K/0aVU2Rz8bfqH9FaOCdvWIZ3dxgehah2jBkktxAZBqLVEpDWnTIry8Oyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1716582865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IbJaiLx99WvKuYG9ZA8c/hY5uth8Kr/SyIcjOG8zuQ=;
	b=dj8T+RCNr6iIa5p25Ka6okL1paBELQYK4FEfUwNK0WyUy5qX5MeGm4YnLlx2VF2A/sfVCz
	SOiFcy1bqFRwtTSlTZqLQWihcepYzlSuMBn1tqIoHqghG6B48RzfE38CUtNuUtY6sTMZWO
	jPMDlzOkMRu7dcJIO9oqwsRSPEfFIGYuu8WaLQGbayVbA1chdc5HRK9kzwWBO/S8WNQNuz
	pHmnqiEHLr4TbKKwtsCjk2lSC2yo2jJJ+HDlInsnBYtmPrfcM9phj0sK7uCt/ev2W2Ng5G
	j3jpPC4ph+0tTB6W7beshzgqNH8WjVUmqPmRh67yak6WTcKDcP5ahi+UFscIpw==
ARC-Authentication-Results: i=1;
	rspamd-5d55749bb4-2fs9f;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Macabre-Supply: 64b5b98465d67122_1716582865349_1541776977
X-MC-Loop-Signature: 1716582865349:2448989919
X-MC-Ingress-Time: 1716582865349
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.135.73 (trex/6.9.2);
	Fri, 24 May 2024 20:34:25 +0000
Received: from p5090f664.dip0.t-ipconnect.de ([80.144.246.100]:34818 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1sAbcN-00000005Zbe-1kJq;
	Fri, 24 May 2024 20:34:23 +0000
Message-ID: <cc1242a20586e758a709985ba7d87b90bb556dd1.camel@scientia.org>
Subject: Re: [PATCH 1/1] make `cygcheck --find-package` output parseable
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Date: Fri, 24 May 2024 22:34:17 +0200
In-Reply-To: <a3ab184d-20b1-422f-96c1-c85f115bf16e@dronecode.org.uk>
References: <20240522003627.486983-1-calestyo@scientia.org>
	 <20240522003627.486983-2-calestyo@scientia.org>
	 <a3ab184d-20b1-422f-96c1-c85f115bf16e@dronecode.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 2024-05-24 at 17:24 +0100, Jon Turney wrote:
>=20
> So, this isn't really true, per the rules [1].=C2=A0 However, there are
> some=20
> historical exceptions [2], which ideally we'd remove or replace.

Well, I guess as long as they still exist, respectively as long as it's
technically possible to have such, there should be a proper way to
parse.

Looking at the git history of that file, it seems that these exceptions
exist since quite a while, so it doesn't seem as if they'd be going
away anytime soon.


> Even with those exceptions, I think the heuristic of (i) split PVR on
> the leftmost hyphen followed by a digit, to split P and VR, (ii) then
> split VR on the rightmost hyphen, to split V and R, always gives the=20
> right answer.

Ideally one would have something that makes parsing as simply as using
cut -d Y -f X.
The current schema fails even with some already more complex regexp
like `s/^(.+)-(.+)-[9-9]$/.../` because .+ is greedy.

So as you said, it would need to take the surroundings of the '-' of
the current exceptions into account, making the rule even more ugly to
read.



> That's not to say something like this isn't a good idea, but I think
> it=20
> would perhaps be better to have an option explicitly produce
> something=20
> machine readable (as csv or whatever...)

Well, any output like CSV, JSON, etc. would already need again some
smarter parsing tool.


Cheers,
Chris.
