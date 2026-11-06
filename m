Return-Path: <SRS0=ecbl=I3=nexgo.de=Stromeko@sourceware.org>
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
	by sourceware.org (Postfix) with ESMTPS id 5FF064BA2E14
	for <cygwin-patches@cygwin.com>; Fri,  6 Nov 2026 16:18:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5FF064BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5FF064BA2E14
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=145.253.228.164
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793981903; cv=none;
	b=sLLLIQ44jV6qL7iznapiHcTfggBIKk5RWWynBtKgcVgVuliuJAQuRzvDZsrThHh1slTscB/upsQTSUGfcF6laC4IG48X/0MDNIisB1HafQlUyDIE9uPCp/qDNWPF7kZVTGdYzNtM6fOI34H/lgrciispYrEhFe0XmQPUIS/CQng=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793981903; c=relaxed/simple;
	bh=7im4kzYiX1JbY2BOgiRCsvbPLBT178TeK7dLGntL5h0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=k+Zu7ybUaZpjFB/GCLXWOqffHgqTAx/I6ugT838cDuT828pOY+sJ7m2ixtVATqSlk1J7pnqOmcmOT99Q0sxwScgxqZOeUvlvJax2ySaG2bbtn6oOw/6pHyDGJwrvj+lFfzMQgy/+nLVdIYl8QiVz2kizbC5Rsw51RoVG9yK0v1U=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=X9zIV3X7
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5FF064BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=X9zIV3X7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1793981889;
	bh=skOrgEdALNGgIIw9adDsG9Wmycmo7Q3W5CkPXPiB7hE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=X9zIV3X7YN5ax0MJXjQC6AutAPtM4fwNGYRiDC52XntWwd+JSYmJD0ObOYbz6N8pH
	 +u4KnWLkPRGtJ+8SlXvctjYmGFIObXkXhc2HEtQhcQ7/LtQdpZVcUPxaciZLQnlcMZ
	 TG5Q2neZSFNw3hnyZTFD5oSfLW4ERvx0xk8ZqmYQ=
Received: from smtp.vodafone.de (unknown [10.5.0.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr4.vodafonemail.de (Postfix) with ESMTPS id 4jLkqj3DSbz3sV1x
	for <cygwin-patches@cygwin.com>; Fri,  6 Nov 2026 16:18:09 +0000 (UTC)
Received: from Otto (p54a0cc4e.dip0.t-ipconnect.de [84.160.204.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4jLkqd1BVxz905S
	for <cygwin-patches@cygwin.com>; Fri,  6 Nov 2026 16:18:02 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdatomic.h: fix the type used for atomic_wchar_t
In-Reply-To: <467663c7-d1c1-40b2-999a-b7e6b829bb6c@dronecode.org.uk>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
	<87a4nrm8x9.fsf@Gerda.invalid>
	<467663c7-d1c1-40b2-999a-b7e6b829bb6c@dronecode.org.uk>
Date: Fri, 06 Nov 2026 17:17:58 +0100
Message-ID: <87ld76kk7d.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-purgate-server: smtpa03
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 448
X-purgate-ID: 155817::1793981885-B8DCC423-77DDD2A4/0/0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_MSGID,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney writes:
> But maybe you could explain a bit what's wrong with it?

Apparently there are systems where that triple underscore is correct, so
there needs to be some configure-time selection of what symbol to
target.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
