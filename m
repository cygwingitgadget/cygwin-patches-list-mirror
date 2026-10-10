Return-Path: <SRS0=DBgD=IA=nexgo.de=Stromeko@sourceware.org>
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	by sourceware.org (Postfix) with ESMTPS id 941AD4BA2E10
	for <cygwin-patches@cygwin.com>; Sat, 10 Oct 2026 21:30:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 941AD4BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 941AD4BA2E10
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=145.253.228.163
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791667859; cv=none;
	b=kS+WZ925JAlYSUEk9AKLGBAV0S9GZ2QV1WTQrTiJYwhaSxR7J9rABWTJo9oVHbt7OAgn7BDAfFUztoxQ+Y7WoHx5d7ePsK1tRSOykvNCSf4xQMiJetC60+dHc16d8ir4DUz07VxTpXtbnAEmoF5j4chA65Jfmu5vB/HdPLET/Vs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791667859; c=relaxed/simple;
	bh=+4N5r1KKlWrsNviTo3GmleO0AzRDXmh7DvpMFNPI4Ps=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ohd6WCsKuaWuAQ9mBodFnFF+EpMVl/mEQoKvE2GffZJs60trK1GHSsmQxO6FrP8+edza7nn8q/K+lS5Ln9nsJqM9X6KayEtn4iAtG3ZuuV4rjbFri6I3G1z25roElRxKwkM1KUuru/nu5mJLxx2JsgsZ4px+/KDrkql8guevcxY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=bJ8yJkjF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 941AD4BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=bJ8yJkjF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1791658880;
	bh=lRhNC7wZ3bzamRI1n4l15NPavrtuIeWsZO/NYeKn14E=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=bJ8yJkjFb4T/KoCcfAO55NJZJtoJ9JkRjpvl6SaHpMQNeBfoVYqIBtukGAWW2ZCuq
	 Lb0PcneE+HjSutvK5HDxL3xXvwqroVbrMtwT9TLddCIflNLtCN9zv9r28YqAbcratO
	 Rc+16oUQQhd2WwctZKOsoPNddojDSkYRYPzuNUVA=
Received: from smtp.vodafone.de (unknown [10.5.0.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4j2CkS2Wcfz3sHq4
	for <cygwin-patches@cygwin.com>; Sat, 10 Oct 2026 19:01:20 +0000 (UTC)
Received: from Gerda (p54a0c349.dip0.t-ipconnect.de [84.160.195.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4j2CkM6sMvz92B3
	for <cygwin-patches@cygwin.com>; Sat, 10 Oct 2026 19:01:12 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: sequencer: Implement /dev/sequencer
In-Reply-To: <c660a54d-e63a-4f7f-ae57-380c10c184d5@dronecode.org.uk>
References: <20261007192542.1049-1-takashi.yano@nifty.ne.jp>
	<b087383d-0d79-4ecb-88a4-42b0fecf0602@maxrnd.com>
	<d3b28759-be02-418b-af63-ef9d7169de42@dronecode.org.uk>
	<20261009133836.b9c96eec087ebb9d54784b0e@nifty.ne.jp>
	<c660a54d-e63a-4f7f-ae57-380c10c184d5@dronecode.org.uk>
Date: Sat, 10 Oct 2026 21:01:09 +0200
Message-ID: <87pkxhe5xm.fsf@Gerda.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-server: smtpa07
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 2330
X-purgate-ID: 155817::1791658876-41413B9E-E73FD6CE/0/0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Jon Turney writes:
>> What happens if devices.cc is removed from git repository itself?
>> Will anything problematic happen?
> Probably nothing.
>
> But I know this has been on Corinna's hit list for a long time, so if
> someone is going to touch this, the ideal outcome is just to remove
> the reliance on cocom entirely.
>
> (I did start taking a look at using re2c here instead, but that kind
> of fell off my list. In any case, deep archaeology would be needed to
> discover the performance drivers behind the current implementation...)

The thing that it has going for it is that it never backtracks, thus
only reads any byte once and only reads in forward direction.  It also
never looks at parts of the string it doesn't actually need.  But then,
these are C and not counted sttrings, so to know the length of each it
has already traversed it to the final '\0' anyway (which ensures
everything is hot in cache at least).  THe switch tree is at most three
levels deep, but I haven't looked if the inner switches that deal with
multiple cases actually optimize to a single or multiple comparisons.
For the general tokenization that this was invented for it's almost
certainly close to optimal, but we have a more limited set of "keywords"
so that may not hold, although I think the trie-structure that Shilka
uses is hard to beat in general.  What needs to be split off in general
is the numbered suffixes, trying to handle these like keywords is
insane.  It also makes dynamic device generation tricky (I've looked at
that and failed, but it's been too long ago to remember exactly how).

Also, the frequency of each string could be used (which is not done for
Cygwin, but probably should be) and that would also influence certain
other algorithms like compressed hashes.  I thik it's unlikely that a
general regex engine will be in the top five performers, but I haven't
tried either.  If we had representative traces of devices lookups,
that'd be the perfect task for AI to do a benchmark study on=E2=80=A6 :-P

Last but not least, AArch64 on the horizon adds yet another wrinkle.



Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
