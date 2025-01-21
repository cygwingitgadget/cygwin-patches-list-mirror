Return-Path: <SRS0=W9aS=UN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 7E6973858D38
	for <cygwin-patches@cygwin.com>; Tue, 21 Jan 2025 18:00:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7E6973858D38
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7E6973858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737482424; cv=none;
	b=w3Q1Jh3/VJa416XY2RnHbG2alud9xeopkCTGE30LGdhdy54vZATwRDxSHW3ZWUN2CJu84RI3zDV3ibQVfbAgo1dd5uojeEh/VH8IYDr1R3NZajliehIHKs3yTvu+LhVaR68uYWUzo6ZdRnkSEWj+D3hnTAVKT+1MrQx6z4eNfy4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737482424; c=relaxed/simple;
	bh=6DAmhzB0HxjiJ4OXFvW4eAor0ffWYolnP0oAYBipMrw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=csPzMAGmVIUN7MWeHHJcVTzgZ7edVpGk33E8iQ4UHvTyaSzuUtVSNfQ0RHs/xjfMas2IoWtpUeduAxYaaqw+wzBaI0DMLQ0cCGoYvrURr3nF1CBLtPaKFl4i1SVd7NWMeRd2xTmHZ3genmk29IJGb4PjU+liWGt9TenHaXg3Nmo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7E6973858D38
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=05YFR4A9
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id F406245C59;
	Tue, 21 Jan 2025 13:00:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=VuQps29DS5/Ov8AzJShnReDNPS0=; b=05YFR
	4A9n2ffLJHSmW6iJD0S6pEzN12RnvLHfNooXd3+1qlnXM2TbC30/UgICk/dNb7Uo
	ve8qm0e26klnTEMPWZzAO6KnbPbtXoKVTZ5XCgZzQBJht3tHu9mfxighUJd7ToZ/
	5J7xFwL16qtw1FL5CUyDXuVdJKjBgUCrqasNRY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id BE24D45C56;
	Tue, 21 Jan 2025 13:00:23 -0500 (EST)
Date: Tue, 21 Jan 2025 10:00:23 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Corinna Vinschen <corinna@vinschen.de>
Subject: Re: [PATCH v6 2/3] Cygwin: cygwait: Make cygwait() reentrant
In-Reply-To: <20250121031544.1716992-3-takashi.yano@nifty.ne.jp>
Message-ID: <5bef2563-e9d3-2ebd-60d8-60a8f4dcef71@jdrake.com>
References: <20250121031544.1716992-1-takashi.yano@nifty.ne.jp> <20250121031544.1716992-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Not important, but

On Tue, 21 Jan 2025, Takashi Yano wrote:

> +      if (!_my_tls.locals.cw_timer_inuse)
> +	_my_tls.locals.cw_timer_inuse = true;

Couldn't you leave the if out?
