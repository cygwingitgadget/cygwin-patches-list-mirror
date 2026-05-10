Return-Path: <SRS0=2i+g=DH=nexgo.de=Stromeko@sourceware.org>
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
	by sourceware.org (Postfix) with ESMTPS id 4B2424BA2E30
	for <cygwin-patches@cygwin.com>; Sun, 10 May 2026 15:28:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4B2424BA2E30
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4B2424BA2E30
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=145.253.228.166
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778426881; cv=none;
	b=D6Gux6fCMu4+LGT7kGjvvkXRrPryrJZ6CZZ6PvNbWcaIlxalQNQY392UoKkp511cfpZf97fpuFRQKIsne9YZ4GdU3U1S8wbdXovs0hK3eTafaPXZfijE3/rvcNMXpILcQ8Xr3af4Bwm8WiMNAzO6mVVq5NSO5n7jyjqUe1D3wv4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778426881; c=relaxed/simple;
	bh=8q6HAOXnaVKrmSz8mCfej98M+YASMBh4tyDBo58iEzI=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Q2jwQ7zv9OptS3kavvb9uaRfvT9ac8VoXLJPVi8+F7da+Yt18ZhJQf3yIz0Ir9IKH/p1gazVVFtWwpsHnt+EVCrZUsf6pG5jqjn6H9FmF06jrbjExt2sXsioIyCMHb8A9OCT7cXJz84Coz3leDG7ou8FcAjOBa8PsB+kTI3HS5M=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=HgKxPbVP
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4B2424BA2E30
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=HgKxPbVP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1778426875;
	bh=MITMBgVjGA4GK8lLcyWrTlVX1caZb5ZU5/89tVvUdeA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=HgKxPbVPtENnOyVawWf+8s6DfwJvoWd5Qf3Ju/XQkA4qIhznlqiN1Bz9PN5cyJZIb
	 OEX06gTxmTL+oWbGeA0qhltPu8T9bnTT2Un9F9XJLW0GibCykBB8Hwvnl5CAaMFYMF
	 t6OIS+2tpGz/78nuGnTYrVIe2YN3P/ZguY0VHQ3g=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr6.vodafonemail.de (Postfix) with ESMTPS id 4gD6Dq1CxSz3sVps
	for <cygwin-patches@cygwin.com>; Sun, 10 May 2026 15:27:55 +0000 (UTC)
Received: from Otto (p57b9d046.dip0.t-ipconnect.de [87.185.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4gD6Dp3yhpz92kH
	for <cygwin-patches@cygwin.com>; Sun, 10 May 2026 15:27:51 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Ensure unused handle available for open()
In-Reply-To: <20260510073511.1346-1-mark@maxrnd.com> (Mark Geisert's message
	of "Sun, 10 May 2026 00:34:50 -0700")
References: <20260510073511.1346-1-mark@maxrnd.com>
Date: Sun, 10 May 2026 17:27:47 +0200
Message-ID: <87zf27qo7g.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-server: smtpa02
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 849
X-purgate-ID: 155817::1778426874-EED8C9A3-24F657FA/0/0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_MSGID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Mark Geisert writes:
> The existing logic for open() assumes a handle is always available in
> the fdtable for a created file.  This leads to a situation where, if
> there is no handle available, the file is created but cannot be
> referenced by a Cygwin fd.

That looks like race to me=E2=80=A6 if it need to ensure there is a handle,=
 it
needs to reserve / create one right then and there and then use it for
the created file (and clean it up if the file can't get created due to
other errors.

=E2=80=A6unless of course that section already is serialized, but I hope it=
's
not, as file creation should be useable concurrently.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
