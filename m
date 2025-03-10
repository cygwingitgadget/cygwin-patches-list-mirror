Return-Path: <SRS0=e8BK=V5=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 908F73858D38
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 21:22:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 908F73858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 908F73858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741641733; cv=none;
	b=cdejXUZ/pxdISgjrqwLoblm8676rdAEFN1VWkChBaJonj+GdBWsHmxPIbhP7HtHvyaaVS8PqBxrhuR+HCayCDw/oyg1+tUpq2zdcgiDmS3BpMluabzXRVuMbngW8/CXYcAWnDCCX7ARh8jf6tMg1PSt7/Y+YU/DPFOMjEAG/6mQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741641733; c=relaxed/simple;
	bh=JD15Jw705HaWlE5DKbMHDX6zMArSDJnqcQ4wrTJ5zrk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=uVWOjIrhi+lETCiPHC/0zlcvkrW11gA379SmwZvi69iLCmq6Hy211hX+dhkRS3Pnb4KZSndVrDYHq1K0x1a96Sfv5vLbXbDVoE1JrkQ0vy5Hy7IBEDYZaq0HDUfoNjC94+muM0V9+dUcG8VIEp6Kmb0X3tBHT0q9klqmJGXkIvs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 908F73858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Bcmu/vt6
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3F8C945D43
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 17:22:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=EailbB4oynVf9G1qRbfWnFukWS0=; b=Bcmu/
	vt6tQchOTofuLzC5QaLZoHAm30fadcPIWYQI3/7Z06tmMBaecGrV4N3fJ89Xbn1S
	k7KISPgu/qYicFcgzUqMK6W2HO4h+TZ0FtcwtlGY2+GY1f0qO1KERMnzROcrr8tw
	ltZULvNLUHNRS1DBYGDv7l+apdoJqeSx3hn2gY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 2540445D01
	for <cygwin-patches@cygwin.com>; Mon, 10 Mar 2025 17:22:13 -0400 (EDT)
Date: Mon, 10 Mar 2025 14:22:13 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fix native symlink spawn passing wrong arg0
In-Reply-To: <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev>
Message-ID: <d0a2e3b1-184f-0f16-0146-3cc830d5018c@jdrake.com>
References: <19580bc11ec.e77085b5699413.240072222093655736@chrisdenton.dev> <Z886PJK2OMtcUwEC@calimero.vinschen.de> <19581e3058e.ebf97e1e733524.5029218649132507579@chrisdenton.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

For reference, the oldest version of the patch I could find in
msys2-runtime was
https://github.com/msys2/msys2-runtime/commit/bede85ba6d90b9383f3c83a6e99152284ca90f6a.patch

Just the subject for commit message, no sign-off, no nothing.

