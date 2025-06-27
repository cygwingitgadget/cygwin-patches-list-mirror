Return-Path: <SRS0=jaUm=ZK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id CDEDC3858408
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 19:13:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CDEDC3858408
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CDEDC3858408
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751051624; cv=none;
	b=fPXsmVbreIRcUONEu+Z4Mjr2HcehRAT6vZnvlyzEIVpbwI8Wh17EOOES0LazEGLbjLukZhuX7TUrhQcFpajgOBvaYVBEPl8Cp2zW9BZC471P2gm3bDLw/qggOiQeCFmZMPKidaQEBXwof67agcVQTgpSXr7oGP0DECKocgv8d1U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751051624; c=relaxed/simple;
	bh=IneUMePRcHBvBxVuWEpUUt/UgGla4f7e/LJPTrOB54o=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KXstR/aqEyuR0qGuYhuy1KeLnSvU+w5XQVZ4SKdaI3vsMHZ7vj/Xd+Bo+Q0YITXZJsh9hTO6xVTx9rOF33TnJpjk8mc13R8Tu5qUi18Yh6/xPPHyLJgl1WBBfyklVTGxBKtq5tl6tTqtUM54p5uV4h1Cw6rPE170HpImP8bAPX4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDEDC3858408
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=N/K2iVv7
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A1EFB45D24
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 15:13:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=x3IjIvrvE40GZvt9KdQfLK7RzYs=; b=N/K2i
	Vv777wuue7W9A6aoMrE5yzLpKnXLsOqTkF7z/BVTdIWA8nC6Yc4mUnTjkBDah9gY
	7jFF3VnVQA/5shVJA4eSNlBAq55qot7BmvC5Wlnh/2IvLRRXCN/Alp+MT7Bl3TXo
	ubTPxR4njlCElDc41gahhI0qcKhE2ffZAqbzxw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8994245D22
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 15:13:44 -0400 (EDT)
Date: Fri, 27 Jun 2025 12:13:44 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: testsuite: test passing directory fd to
 child
In-Reply-To: <aF6POTp2VGPfPE6m@calimero.vinschen.de>
Message-ID: <4288efc0-5e49-84cc-0f96-2a0d07f4b121@jdrake.com>
References: <1b4da216-51cb-cbc5-7a2d-db997429eed3@jdrake.com> <aF6POTp2VGPfPE6m@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 27 Jun 2025, Corinna Vinschen wrote:

> On Jun 26 13:34, Jeremy Drake via Cygwin-patches wrote:
> > It doesn't make a whole lot of sense to redirect stdin/out/err to/from a
> > directory handle, but test it anyway.
>
> I disagree.  There's nothing wrong if a program expects a directory
> handle on a file descriptor if the task is, for instance, to perform
> readdir on the incoming descriptor.
>
> Therefore, the code is ok, the commit message isn't.

Revised commit message
    Cygwin: testsuite: test passing directory fd to child

    This is a legal (if non-obvious) thing to do, so test it.

    Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

OK to push this series?
