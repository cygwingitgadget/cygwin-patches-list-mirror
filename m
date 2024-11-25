Return-Path: <SRS0=ktzv=SU=scientia.org=calestyo@sourceware.org>
Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	by sourceware.org (Postfix) with ESMTPS id 18D2F3858D38
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 19:23:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 18D2F3858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=scientia.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 18D2F3858D38
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=23.83.223.168
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1732562629; cv=pass;
	b=Sj2j8ETwh0ZYVQBc76lvcqzks8ZQ7CrD/R4qHJMe6SHuZp9NwzO7i+IBBchW/gWUe4HfFsZ8Q8c0N6w+dZZ9mEETIX8BRRoLcjUL08RZrsl15+4ocbdiwpyNnlTysqVSDBm4ACCeEJVePUP9iMgcge3dFotLEs4aMLpZZIz0QXI=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732562629; c=relaxed/simple;
	bh=FFAFR/RS74B6zEQRsLECBqhaIuogx9YpdnYWFHOlU4E=;
	h=Message-ID:Subject:From:To:Date:MIME-Version; b=rIFwr6HobieAVerHR8PSKE7XXb4U40znuQlpAr8ohV1bHarkB80+PWI2wdxu/dCgs2iFJ3BQY/PYJ7ZPfmZ7guCnrQaNoQSqDaBWoK+ikc0tkXpmfY6Z3SPf9IuTfWm+u/2fzCU6kWV1UkZ+L1m0FX54JX7BpsDT2VWXw66FEh0=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18D2F3858D38
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31F648229E6
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 19:23:48 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (100-125-108-52.trex-nlb.outbound.svc.cluster.local [100.125.108.52])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8A1F3822591
	for <cygwin-patches@cygwin.com>; Mon, 25 Nov 2024 19:23:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732562627; a=rsa-sha256;
	cv=none;
	b=Bos79pMAXSrULBGwd8U1amsflUewxSLFXIoqXPo7xX6qfPt4c3KiXWHXc69XmPNvzjB3Q6
	7mFGbYqsomjw36TJ6XgXCi62bJnL7aozqMs2oymoIKKHMgMjdktxA3Qawd5I5kCOnGCWHq
	39gN3HKVsAFK7bKqdgmAMZErTUnh4o8S4tysiNOnf8kCyHg8mdFELG7tGe2XvJ4wSt9cq3
	xvZS7qki53mw5jEDYIFGNTuWE4G09OCIXrY19ktUZGk/CRvRalPujqTDyHu58oe9sTISVU
	BX+zGsCpAWMpojLxnCj3AX/7zsPN976Im0MXxCU9TGt7mSKLSFLXIt6gJKLTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732562627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhhlK4bi0gJKzL8Q9do55RNxIDeRCv/JjJZZTS/F72g=;
	b=2Ao8v9RCpZtV6cYm+2LQNrkZGQ4x5CWO6PDhZ8x1j2qJyQSAVPyFpdTG5bjSjcZ6KY94+w
	T/rzKt/a04w9zDfI0DnN6DUkGnhVcZruitCcAKTAAOHSKYElchajQ4ieajlWgTCCnphFL9
	tqTe76BqAonO9Wvnwq9yjK6lQ7bDjSHVpQ9dk7oKUIdqQw030PZUhHkO48X91sN8XZCa0h
	lkDEOv7hG9as31t14x1eYi60IONS3TNrMvHjuUgZS8SSvRUlBn2QQ9j0Hyqhx8FXc5cANu
	HlLvOKPS8lMWO0R+O9IBtSsc0JPRDfYdzOrfs80ZNK4pDWcsWnEQVU31xdlu4w==
ARC-Authentication-Results: i=1;
	rspamd-dcc6979f6-pk7z7;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Soft-Stop: 77158dde0b9bec3e_1732562628046_716192930
X-MC-Loop-Signature: 1732562628045:1843797064
X-MC-Ingress-Time: 1732562628045
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.108.52 (trex/7.0.2);
	Mon, 25 Nov 2024 19:23:48 +0000
Received: from p5090f5d8.dip0.t-ipconnect.de ([80.144.245.216]:62434 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1tFegS-0000000D0Um-2Xb9
	for cygwin-patches@cygwin.com;
	Mon, 25 Nov 2024 19:23:45 +0000
Message-ID: <e32242c9d3263970801c5f175235db950ee945f9.camel@scientia.org>
Subject: Re: [PATCH 1/1] make `cygcheck --find-package` output parseable
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: cygwin-patches@cygwin.com
Date: Mon, 25 Nov 2024 20:23:43 +0100
In-Reply-To: <cc1242a20586e758a709985ba7d87b90bb556dd1.camel@scientia.org>
References: <20240522003627.486983-1-calestyo@scientia.org>
		 <20240522003627.486983-2-calestyo@scientia.org>
		 <a3ab184d-20b1-422f-96c1-c85f115bf16e@dronecode.org.uk>
	 <cc1242a20586e758a709985ba7d87b90bb556dd1.camel@scientia.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hey.

Just wanted to give this a bump, as it wasn't clearly rejected, but
merged either.

I mean the exceptions to the rule mentioned by Jon are still there,
aren't they.

And even if someone was going to write some option that provides output
in a more standardised format, I don't see much harm in making a format
that's anyway not properly parseable right now, parseable by some
simply change.


Cheers,
Chris

PS: Here the link in the archive to the original thread:
    https://cygwin.com/pipermail/cygwin-patches/2024q2/012690.html
