Return-Path: <SRS0=hEVR=ZU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id CD844385AC09
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 17:04:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD844385AC09
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD844385AC09
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751907891; cv=none;
	b=jUZJiTsLcDAghrarcgzprn5uTxdeYNKegKF27KBTpfD0Pk7z6/5sHP0g2Hjor/Vw7TAhb0rWmnjrnUERB6c3VcvYTgsS8psn3V0jtvB1UnBxGcqlayiRmEWkx+M6FeKbARF0NKmPBIxyyAjWGDKwFn9OEaQjMaS8aM7gcbuZYNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751907891; c=relaxed/simple;
	bh=63ER6ezW6nG9pF1Iu8R7nNyE0EOiA00osQwc3IDnha8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Ggoi99gAXLlyWcJRFfAYpqSHw5CjsiEPmi6zEkCD8OeH0iQon4NNWT+vtzaczCN4buHvocmWYg1XZaTKcUbvr/ciU2NmWMVA3vNRq5T+PL0paVhPqjM0EHSgcHbFZn5j8ibzCweXAATPfeEIlYkF0XFuZUuBlW0Hmn6+njmqP6Q=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD844385AC09
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=RuXvC+Ki
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 605DC45C0C;
	Mon, 07 Jul 2025 13:04:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=zsnarTorC/jQz55kvR1kQ19k7uQ=; b=RuXvC
	+KipDBw2yuEj4moEQH7dN0C3YqpMYHazKOv4q8czzUPGVIYiAEEhJB1rzJIehz7v
	FF+Fy5hhxjpvLmcjuxOa60fUDx/b3C2EzHp1fpIsB8YhuOceYJCZ+dbUYqRYxEHp
	tsWJoMGQ/2Y2fOo/k3F+Sa5boEadjsHJ70gA/Y=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 4280E45A5F;
	Mon, 07 Jul 2025 13:04:51 -0400 (EDT)
Date: Mon, 7 Jul 2025 10:04:51 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
Message-ID: <cef0e1d0-8736-57ca-6d8c-6e6ee8fb8696@jdrake.com>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de> <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 7 Jul 2025, Johannes Schindelin wrote:

> fix by a regression test in `winsup/testsuite/`?
>
> For several days, I tried to find a way to reproduce a way to reproduce
> the SSH hang using combinations of Cygwin programs and MINGW
> programs/Node.JS scripts and did not find any. FWIW I don't think that
> MINGW programs or Node.JS scripts would be allowed in the test suite,
> anyway, but I wanted to see whether I could replicate the conditions
> necessary for the hang without resorting to SSH and `git.exe` _at all_.

Technically, there is a mingw directory of the testsuite that builds
executables with the cross mingw compiler.  I recently added a test that
spawns a mingw program built from that directory.

There's also the new "STC" repository that also runs in CI, that seems
to be more intended for regression tests, but that doesn't have any mingw
builds yet.
