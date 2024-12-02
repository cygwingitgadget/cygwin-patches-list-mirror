Return-Path: <SRS0=33F1=S3=nexgo.de=Stromeko@sourceware.org>
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	by sourceware.org (Postfix) with ESMTPS id 64E813858C5F
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:29:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 64E813858C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 64E813858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=145.253.228.166
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733164144; cv=none;
	b=HAkZE+13J7uyQgx7WanmOKM/KrTWEqG3kIVIoaYK3NxUMWaDntQo9r0ipR2eFYpJv9XAYy7P5az+VVwfSOh8eYzqdyf3kGbC5CbN3rHw4C/55fc4P2jqgrHqOuMpGGLrcU1s/2QLgKP4IvtdR6HxTGekIrFpgOityshvtBd3WeM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733164144; c=relaxed/simple;
	bh=wWCMih0tsj4TaIpwSyo42EezYeoMqjA+c3UsJESH/dU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=kIpxKE0UivDNUs5Ctm4CsN1/V5UIIgRgJPB7fsAPZ8Yutu5MknEv5n7Z6srjw+KNGcvThdv6JgmZfJHPoZ5XpatrF9j+Cz9dlJ3lLTgKlZlfHiM6Z7bj2w6lJ2XcJlZfXw+6GjU3mVqSspfaIqJSzuziNYVo4rr6qVVKC0VpWpE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64E813858C5F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=eKcL0M85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1733164143;
	bh=LEUaoUCyKM3CUkUjHbgBZjHdvwB8iTxJ82ktPcYeN1M=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=eKcL0M85fWb0VclIk6SWEzXIHeb52D4lA9BgG4awA9pQVRDLuSRpAoK08e4Jdw3a4
	 CnKjSFOdS9bQwClKpIwbFNipIM2CmcKkLaKGXSQ8fzZtxP9zBM6eqWcWQ6DAennD1k
	 Y1hlM9JeEB7cGQ9QccgnLiHHC7IWLaBaDoY/+XAc=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4Y2C3g1fbgz1yCh
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:29:03 +0000 (UTC)
Received: from Gerda (p54a0c021.dip0.t-ipconnect.de [84.160.192.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4Y2C3b16Hsz8sWj
	for <cygwin-patches@cygwin.com>; Mon,  2 Dec 2024 18:28:56 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_OTHER,
 SCHED_FIFO and SCHED_RR
In-Reply-To: <e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de> (Christian
	Franke's message of "Mon, 2 Dec 2024 18:33:10 +0100")
References: <eabbcf15-1605-8b77-bf77-ec5fde2d6001@t-online.de>
	<Z03Tik1rbM4sMpKl@calimero.vinschen.de>
	<e79eb78a-c8a1-d2c6-4a8d-9c21415b15e9@t-online.de>
Date: Mon, 02 Dec 2024 19:28:51 +0100
Message-ID: <8734j6q6qk.fsf@Gerda.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 913
X-purgate-ID: 155817::1733164139-E67FB46F-08D17060/0/0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Christian Franke writes:
> +    nice value   sched_priority   Windows priority class
> +     12...19      1....6          IDLE_PRIORITY_CLASS
> +      4...11      7...12          BELOW_NORMAL_PRIORITY_CLASS
> +     -4....3     13...18          NORMAL_PRIORITY_CLASS
> +    -12...-5     19...24          ABOVE_NORMAL_PRIORITY_CLASS
> +    -13..-19     25...30          HIGH_PRIORITY_CLASS
> +         -20     31...32          REALTIME_PRIORITY_CLASS

That mapping looks odd=E2=80=A6 care to explain why the number of nice valu=
es
and sched_priorities doesn't match up for each priority class?  39
possible values for one can't match to 32 for the other of course, but
which ones are skipped and why?


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf microQ V2.22R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
