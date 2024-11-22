Return-Path: <SRS0=UNdZ=SR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E6E90385802C
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 01:36:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E6E90385802C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E6E90385802C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732239380; cv=none;
	b=ls2nqvBjGUG/sXmAsgJN1gRFBSm8EmVfHMW/qJQwT00pWFNBoNTtUBJuFFpwL812670QOh5foLZzxijPz2d+Vl+0NEV5mPa+WFJDpEZ4wAiPA34gV3d7k7arX/rDRQ5CubrwmZipopxjfv7UdttfxZvsXaUBQYGUZqyiLXAyw2k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732239380; c=relaxed/simple;
	bh=MwUcB8o0vx0C/dTfeh4vUx96Z0sxpFD0V1t6sx9+WaM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=UaSzT5j9qV4uy0H+VSxJEKhzEzN7fFrIb56EFmxtsOujKHxUurchfwoTMg8LNbcA3eLHUpKWU4SfFYzuoTSqk5JDp6lFfPJon11hai6CgapOnzgITrNzAmX9kMq0whUnfZGLuD+i9cDMPsmD/FwVw0rdwYOdxWI6yI+OE+9M4Pc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E6E90385802C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Z/tJUpj7
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id BB79745BF6
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 20:36:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=76lSfD7xAt9kOGZOMRHxiY4ongI=; b=Z/tJU
	pj7DMrFli0BFLJzX9f8KArVVUg+SeqeTKgraxsndPsgJDSsxR6KtZyMA4WPS9B/I
	qHQn6W01Ov3pwd87LGFAgqUupKJTkuGNpMTnXkJgwiGi9H3q4dPtOQvX7fSrTIPl
	9Add436rS9J8p4GifB00yAqapnIvjrU5IpwJcg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B652745BE8
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 20:36:19 -0500 (EST)
Date: Thu, 21 Nov 2024 17:36:19 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: uname: add host machine tag to sysname.
In-Reply-To: <be79571e-9fab-cee4-54e4-a63348aed429@jdrake.com>
Message-ID: <03f12e21-3e61-b970-6169-0d810c103e37@jdrake.com>
References: <be79571e-9fab-cee4-54e4-a63348aed429@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 21 Nov 2024, Jeremy Drake via Cygwin-patches wrote:

> @@ -38,6 +81,7 @@ uname_x (struct utsname *name)
>        /* sysname */
>        __small_sprintf (name->sysname, "CYGWIN_%s-%u",
>  		       wincap.osname (), wincap.build_number ());
> +      append_host_suffix (name->sysname + n);
>        /* nodename */
>        memset (buf, 0, sizeof buf);
>        cygwin_gethostname (buf, sizeof buf - 1);
>

I noticed while reading this patch that I lost the creation of an `int n;`
and assignment `n = __small_sprintf...` to the call above in the context,
due to the rebase from 3.3.6 to master...  That'll have to be in v2, as
well as the inevitable review comments.
