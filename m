Return-Path: <SRS0=8hFg=UM=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id DD56B3858416
	for <cygwin-patches@cygwin.com>; Mon, 20 Jan 2025 17:03:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD56B3858416
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD56B3858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1737392583; cv=none;
	b=iU4VuEbNihcOA0puj2F970Te5mP90cstwjGfbkURewbFUKBCKCRM8fPkDlRv0gLD3NZ67nnuJ82FviEMBHgY8U+b38GCsBadg6VNLdz9fhV9l/NPm+tGb75+E0vA6q4C/fno4lFvtSMFZjXW4I+64GteDjIDHsPJ8yyTtmSYcbE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1737392583; c=relaxed/simple;
	bh=7eqJgCEV0xdRt1KQMxhWUTiajy+oFU0jqIHrElQsDuQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CkKp8PpBk5NqQIolbRQHODM5DbtWkybGnUgyU2qB1EI1noW29V0deb61qWYjs60mFGlCzn1UTJoq9p5GulS4A8JQVHonBKCCqjuHe0Gbj9DoL31t/jMgvhg7PVcFEkzdeXXzDZpf/xm9XUUUStgt83Gk0yCnqsI/GPMMtVfTVL0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD56B3858416
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=PVsSZM5k
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id AAC2E45C66;
	Mon, 20 Jan 2025 12:03:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=59CYTsOsBpo2lpP2nQdviq5A380=; b=PVsSZ
	M5kOAxrM2A0d4LIsvNHz3mGJ9TewgJUnVFMDargEL0hDqhxRR8n8KhGCZFlJlrUM
	Sr+BjgDy1sBDyz16UyDlOJG9aGhkBuWTUy3aI6NwQ7y5gUNxPURZePuiikND2jt/
	igwqJDmA2/EF2qNZSlL6pth/zXbIjeiW2NrzFo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 7234C45C5A;
	Mon, 20 Jan 2025 12:03:01 -0500 (EST)
Date: Mon, 20 Jan 2025 09:03:01 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Corinna Vinschen <corinna@vinschen.de>
Subject: Re: [PATCH v4 2/3] Cygwin: cygwait: Make cygwait() reentrant
In-Reply-To: <20250120154627.107642-3-takashi.yano@nifty.ne.jp>
Message-ID: <b90010f4-cb87-4193-50db-91c8ee93ba05@jdrake.com>
References: <20250120154627.107642-1-takashi.yano@nifty.ne.jp> <20250120154627.107642-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 21 Jan 2025, Takashi Yano wrote:

> diff --git a/winsup/cygwin/cygwait.cc b/winsup/cygwin/cygwait.cc
> index 80c0e971c..8613638f6 100644
> --- a/winsup/cygwin/cygwait.cc
> +++ b/winsup/cygwin/cygwait.cc
> @@ -58,16 +58,22 @@ cygwait (HANDLE object, PLARGE_INTEGER timeout, unsigned mask)
>      }
>
>    DWORD timeout_n;
> +  HANDLE &wait_timer = _my_tls.locals.cw_timer;
> +  HANDLE local_wait_timer = NULL;
>    if (!timeout)
>      timeout_n = WAIT_TIMEOUT + 1;
>    else
>      {
> +      if (_my_tls.locals.cw_timer_inuse)
> +	wait_timer = local_wait_timer;

Since wait_timer is a handle reference, won't assigning it here overwrite
_my_tls.locals.cw_timer ?  I think you might have to use a pointer here
instead.
