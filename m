Return-Path: <SRS0=Tv/T=KK=nexgo.de=Stromeko@sourceware.org>
Received: from mr3.vodafonemail.de (mr3.vodafonemail.de [145.253.228.163])
	by sourceware.org (Postfix) with ESMTPS id 464A93858C33
	for <cygwin-patches@cygwin.com>; Mon,  4 Mar 2024 15:45:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 464A93858C33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 464A93858C33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=145.253.228.163
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709567121; cv=none;
	b=pmZWFdiSj124Wode/ZgVs0YOB28D1MuvXcuOZAOdl63ABbFov+1Uqs+qGxaan5uzxJOCzjrItdVLXH7esLnU7ucD6w8T78nVXijhdmxFCRy2U4tjNGWdVpugW70nC9LNTNsHJZErJ/QPW52dDxasIFzLrdLg/4mmAOYaaHWUBUs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709567121; c=relaxed/simple;
	bh=K9sFMXw8UzTCUiYGwEEmoHXYgFPuLmYeg/0/A/yf4Hg=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Z0k9iz4bk+Z1qeaJCRKAdJFrLGVMHCr3xCv+2vDEyC+my/UAoMSdq1ix3cHgkDu0O7NfcXyKEYqXJ1t8/NmVOCLkAmmvoeJZ7Pgoom7H4ZYj89/UrF7dgn3VgtF0QjWfK7Z8EcBufO0GNqKdMVl2xJ9VeBj9moAMc2+mJ6EooHw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1709567118;
	bh=+/6ZDCFYvhkZxmMNcxHk/LSTCzTCYPVbKkUW/GWuZ/8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 Content-Type:From;
	b=R2XmbHsSsg6hZfBXaAMXbDZooKP437osaB3WDnq5UCh4Bv3TcGvuFFvuuX07BONBl
	 oG9eltOmafMb2LVa/VAPLoqwjAhPIcBKoc+x6jQU4FoJUvigYhuAhYwkkMHMYUgHFc
	 11lbZBBhIGbKyEXxuEWyREDdOlUg8qWKCsu/qXk0=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr3.vodafonemail.de (Postfix) with ESMTPS id 4TpNLk69Zfz2Gf7
	for <cygwin-patches@cygwin.com>; Mon,  4 Mar 2024 15:45:18 +0000 (UTC)
Received: from Otto (p57b9d928.dip0.t-ipconnect.de [87.185.217.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4TpNLf6lyCzHng0
	for <cygwin-patches@cygwin.com>; Mon,  4 Mar 2024 15:45:11 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
In-Reply-To: <ZeWjmEikjIUushtk@calimero.vinschen.de> (Corinna Vinschen's
	message of "Mon, 4 Mar 2024 11:34:00 +0100")
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
	<b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
	<20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
	<87a5nfbnv7.fsf@Gerda.invalid>
	<20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
	<ZeWjmEikjIUushtk@calimero.vinschen.de>
Date: Mon, 04 Mar 2024 16:45:07 +0100
Message-ID: <87edcqgfwc.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 903
X-purgate-ID: 155817::1709567115-507DD693-0B2D960E/0/0
X-Spam-Status: No, score=-3030.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_MSGID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen writes:
> Right you are.  We always said that independent Cygwin installations
> are supposed to *stay* independent.
>
> Keep in mind that they don't share the same shared objects in the native
> NT namespace and they don't know of each other.  It's not only the
> process table but also in-use FIFO stuff, pty info, etc.

What I was getting at is that a process not showing up in the process
list in one Cygwin installation doesn't automatically mean it's a native
Windows process, it could be a process started by an independent Cygwin
installation.  So this way of checking for "native" Windows processes
may or may not do what was originally intended.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
