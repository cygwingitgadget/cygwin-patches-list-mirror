Return-Path: <SRS0=pmrr=IX=nexgo.de=Stromeko@sourceware.org>
Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
	by sourceware.org (Postfix) with ESMTPS id 608264B99F5E
	for <cygwin-patches@cygwin.com>; Mon,  2 Nov 2026 17:37:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 608264B99F5E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 608264B99F5E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=145.253.228.165
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793641060; cv=none;
	b=FH3O6wM76DaDao9lbpi5WqgSh4nrFGrBum12qVb7syl3ajJJ/nGugMgvOg8MuxJYjRM6QM9oZmtrk80hEgkh4ystbvsUKQd9QySViosW7mZ03OzWRqdSuybYvf0vIjKhTeGh/mhueYrOOfWB2s/16FZrpIWqo+E514o4mBqQXCI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793641060; c=relaxed/simple;
	bh=sLzI2PT5eU/ZAvODFzj+tuUsvTtphzzWenTG8oUk2Pk=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=TOUfVkbfyWmewNZ7oB9fkyo2ipZAEdV3y5m3IiEJidHBciGp7kf3vFb/0/fGvjkkn7px6JmRVsznNNOswAuTO0bPBGPXgYaEIbQwjhb8SsfP3QChO6c/LTJGJR/DpjF1J6nw7gVNB5WlfZI5N8JSuF3UdV91L4oiq6Giu+7w1Ec=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=KP6Mc5U2
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 608264B99F5E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=KP6Mc5U2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1793641058;
	bh=sLzI2PT5eU/ZAvODFzj+tuUsvTtphzzWenTG8oUk2Pk=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=KP6Mc5U2V2b8QgPghm0s8Nz+vuPU27MrMj3ck6V1kd5qV7Q88eLih6kLomYi3j3Cm
	 szCr1pQRsRHsdfItPL0yUZVYSPCjSqoe5x6rF173LOm0DWusPSrrgG1+J4ur74CRKM
	 Xg7EIjym1JsQWaKgaNNrBCa33uXjG0HqRa5fKsec=
Received: from smtp.vodafone.de (unknown [10.5.0.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr5.vodafonemail.de (Postfix) with ESMTPS id 4jJJnG0Q0gz3sTry
	for <cygwin-patches@cygwin.com>; Mon,  2 Nov 2026 17:37:37 +0000 (UTC)
Received: from Gerda (p54a0cc4e.dip0.t-ipconnect.de [84.160.204.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4jJJn954sgz8xfT
	for <cygwin-patches@cygwin.com>; Mon,  2 Nov 2026 17:37:30 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdatomic.h: fix the type used for atomic_wchar_t
In-Reply-To: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
References: <pull.16.cygwin.1793616235364.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 18:37:22 +0100
Message-ID: <87a4nrm8x9.fsf@Gerda.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-server: smtpa04
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 349
X-purgate-ID: 155817::1793641053-CA71EA03-9BA65376/0/0
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Johannes Schindelin via GitGitGadget writes:
[=E2=80=A6]

That fix should be done in newlib, not Cygwin (and then not in the way
shown here).


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
