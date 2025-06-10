Return-Path: <SRS0=9F77=YZ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C18AD3858424
	for <cygwin-patches@cygwin.com>; Tue, 10 Jun 2025 05:30:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C18AD3858424
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C18AD3858424
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749533426; cv=none;
	b=d+DHbF/FqP4gsQTFXnfKSH83pElkVb9N+VHmYTF3UKZ8hIx0Arbu3zmx8gQvd9j3pO/W/GnxwDExOw2AnB/W9Ilb5bmdUCQMZAtMHnSn3MPATHLYhzKglXGF8lJV6aXhoF8yKEzKMZjgU9BxeMBD4rdVFdP4Ek+vDy83YXVPMRU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749533426; c=relaxed/simple;
	bh=7koDhAWbHELhcmfhUwcj7gRzk5+dasitfs0jSpmcEwM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=DVyJ1bratVPea9R39a7opy2YQJtHPyWT9VqZXcRv5n6996GsiPXNAWe0fGoSGSOn2C5fu4yRd2xvBtu1TnnAKONfDxYhz6SvkLriufzTj8uxVl0ME6LszGq7CRJjRUsArn5yTnTajIw4WTf8SBCA4xEQHhh97rSRlgBzvPz2qRw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C18AD3858424
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=CKQh/co0
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 548C145CEA;
	Tue, 10 Jun 2025 01:30:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=t0pJie8/45qSZwCvMg+BU2zp1js=; b=CKQh/
	co0rtwNDsGTvmj+aqBhv6T3JzG9MXoXbktTMb0bvfeuILdXy8VvuppCtfnP3qUoN
	1nSKWx2RRpmXnAICjiBSiSoiJgkRmqmzSvLgy/F2LViMIfgvyt7qW8I4ldo8ZhXk
	tJElg0GNMr0CyXG2ooTjBktTqxygb7Wm3+ty8c=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 378E945CCE;
	Tue, 10 Jun 2025 01:30:26 -0400 (EDT)
Date: Mon, 9 Jun 2025 22:30:26 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Yuyi Wang <Strawberry_Str@hotmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 3/3] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To:  <TYCPR01MB1092694C68AE1EC4E48F055C6F86AA@TYCPR01MB10926.jpnprd01.prod.outlook.com>
Message-ID: <e3529dd0-ddbd-a23d-ca15-1a45ebce18bf@jdrake.com>
References: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com>  <TYCPR01MB1092694C68AE1EC4E48F055C6F86AA@TYCPR01MB10926.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 10 Jun 2025, Yuyi Wang wrote:

> It would be better to handle `POSIX_SPAWN_SETSIGDEF` in the fast path, because
> Rust usually sets SIGPIPE to SIG_IGN, but wants to recover it to SIG_DFL in the
> child processes.

I didn't observe that in the cases where rustc was failing to fork to run
the linker.  I am currently in the good-enough case for that, and am
waiting on feedback that I'm on a good path before expending more effort
on additional cases (though I think I can see how I'd attempt to
implement that).
