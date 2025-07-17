Return-Path: <SRS0=9fef=Z6=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 677663858D26
	for <cygwin-patches@cygwin.com>; Thu, 17 Jul 2025 17:43:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 677663858D26
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 677663858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752774201; cv=none;
	b=j0agEkhPy7J1Zo/9zYy7TYs2rGTSS6vpEZuwHwaRzU67xmG6mSo3uNO+i9nh9JLrk9F53v/4FnD1fc/tuS4b+3phtU6iDWiya3kMvR53hYMPlTbpJHNILpKOA0qHjlE40VUD1zT3aDFMmHl55YLbPt+RrsKkY6V/9gQn4+RN3hA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752774201; c=relaxed/simple;
	bh=ZG6rTm+YoK8zaM0ts4hEKIGZ6nUXCUIsLOX4b2WwEuA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=cLlpKjQHGQwPjmRWeIxK0NeE7x9bz/BszNae7wCCXIlkkdy9T4PzyDBhheDxC+751OAENEsfiEShaqe8ArxqaGWOEaLNv+6owb0eU9xVH0PcY0F4gmoFKmJ1osogLZDgOLzEy963fZ6DA6tB4qRfWsn3+4XRcebx0wCdNzniLzc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 677663858D26
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Ctd4QlXl
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0DA1C45CDB;
	Thu, 17 Jul 2025 13:43:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=FGPvenMrSXpIPBNjYGpHN3dSBYo=; b=Ctd4Q
	lXlA/LZxiEMR86onZMtVNXaxhyjeudUjQ2Ycr63iKWf6YiYDPGPHOv9PmNjqJWgE
	F9c8/uWR5soyrxUuDPmLbw+RPKqDz12m39eds8wHQY4weuy26kmvLw+Cu9yQRBpY
	zhZiDwInVtcpURJrH3iJb8JyZJdawXPcMjiDng=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E9DBD45CC5;
	Thu, 17 Jul 2025 13:43:20 -0400 (EDT)
Date: Thu, 17 Jul 2025 10:43:20 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
In-Reply-To: <9323a02d-753b-6cb3-c996-9d86f379bc21@gmx.de>
Message-ID: <b2df1dac-cfaf-cad5-451a-19b2c023e5d4@jdrake.com>
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp> <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de> <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp> <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de> <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de> <cef0e1d0-8736-57ca-6d8c-6e6ee8fb8696@jdrake.com> <9323a02d-753b-6cb3-c996-9d86f379bc21@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 17 Jul 2025, Johannes Schindelin wrote:

> > There's also the new "STC" repository that also runs in CI, that seems
> > to be more intended for regression tests, but that doesn't have any mingw
> > builds yet.
>
> Oh, you mean the stress tests? From my work in the Git project, I probably
> mistook them for something they are not (I expected them to run the same
> tests concurrently to increase the chances of flakes to break the tests).

No, the stress tests use stress-ng.  I mean
https://cygwin.com/cgit/cygwin-apps/stc/
