Return-Path: <SRS0=QCGN=IV=nexgo.de=Stromeko@sourceware.org>
Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
	by sourceware.org (Postfix) with ESMTPS id A4CD24BA23F8
	for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2026 20:51:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A4CD24BA23F8
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A4CD24BA23F8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=145.253.228.165
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793479889; cv=none;
	b=U6jIgd8mRn45N/rL33wtPsfOcqs3ctEgOBV1JTAIDLtlQAxIlakWCrfe1gUxkUOg7hMi7Ifo+OL/TbJ/pGRs0ixH7mcLUb0MbrRqmp9Uv0md66LRTc2IpVSyAtb2u0q2niMLhx1YaRGKSuR0vYhxpNN6UNZORlHnsoms+Tt+yW0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793479889; c=relaxed/simple;
	bh=TSEyobUOad7GblU0gMOKuqSF5kNGuPkc6Nh4bd34Nko=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=NWbCESmSDFk/IAmtqQ64+1oQ8UvDrxEGfh0jMVM6UDd5FJrett1aGzj4szLi/UO+nPptOO5LJYw6fifwkWPvBfbHwPMDNt2H3XLaFMhDPHNfH7HKk9pPJLFM+y+CpnGRIGap3V1ZqTnT5VzgodUmdWI/ubK0gJEkpmeGp7H5h2g=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=dPxxZ7MK
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A4CD24BA23F8
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=dPxxZ7MK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1793479886;
	bh=U4S0IWTOl9+IwdFQPEGGeVZFd0UYo5fcRWR5ibRWuKQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=dPxxZ7MKaAw77zZzKN8yinFyBboveY/uaUpu5Fi/3Dezf75ykVsNJu3kxwFkLfILA
	 v4Xqj6hfBRGrxTD6dQKyLrHJmaqOenfmg9xMun7aZBiFiLmwp9o4NDHsOxTEsjx+PS
	 V7QqvZji8G9kE5IzCRWa/BYw8Z88BacS28jH5dWY=
Received: from smtp.vodafone.de (unknown [10.5.0.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr5.vodafonemail.de (Postfix) with ESMTPS id 4jH99p3NRgz3sTf6
	for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2026 20:51:26 +0000 (UTC)
Received: from Gerda (p54a0cc4e.dip0.t-ipconnect.de [84.160.204.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4jH99k0PYpzB2kn
	for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2026 20:51:18 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] tgid reported incorrectly in /proc/<pid>/status
In-Reply-To: <20261020133919.10b3f008d0f28349c776f8af@nifty.ne.jp>
References: <87wlreyhxi.fsf@Gerda.invalid>
	<20261020133919.10b3f008d0f28349c776f8af@nifty.ne.jp>
Date: Sat, 31 Oct 2026 21:51:18 +0100
Message-ID: <87o6c9h9vd.fsf@Gerda.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-server: smtpa01
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1560
X-purgate-ID: 155817::1793479882-CCDA7C6D-A923F792/0/0
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano writes:
>> +			  num_threads, /* should really be the number
>> +					  of LWP in the same thread
>> +					  group, not the number of NT
>> +					  threads attached to this
>> +					  process */
>
> What is the practical difference? The only thing I can come up
> with is whether it includes Cygwin=E2=80=99s internal threads (such as
> the signal thread) or not. Is that right?

The main difference is that LWP have their own PID and Cygwin pthreads
have not.  Also on Linux, while it is possible that helper threads get
injected into another applications thread group (e.g. via a library),
that is done rarely and requires elevated privileges.  An application
not expecting that (because it's not using any libraries that would do
that on Linux) might do undesirable things with such threads once they
become exposed.  This is a fundamental difference since Cygwin does some
"kernel"-like things via these helper threads that would be completely
off-limits on Linux (by running in kernel space rather than user-space).
So in essence Cygwin currently mixes both "user-space" and
"kernel-space" threads into the same threads group and I think that
these would somehow need to be separated in order to get something that
conforms to the Linux LWP ABI expectations as best as a user-space
implementation allows.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Waldorf MIDI Implementation & additional documentation:
http://Synth.Stromeko.net/Downloads.html#WaldorfDocs
