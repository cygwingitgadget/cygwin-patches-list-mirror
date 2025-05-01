Return-Path: <SRS0=nMGZ=XR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 0FEA33858D34
	for <cygwin-patches@cygwin.com>; Thu,  1 May 2025 18:49:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0FEA33858D34
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0FEA33858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746125342; cv=none;
	b=VBugd4dX81gogFGv7e6M2EmlErzQWnVqp+QAvKyxSw6Lyvb3xb1OkFbjc97P9xs6eIuNEDefmekuhAgPExlGfcYBvXbi7KZiFTdAO1VbTvFjf2IobctFfVTW3MXgU3Twl/7Y7keMD9p+fZ/oMrqWVkfNprmXmByomPswfRmBZPs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746125342; c=relaxed/simple;
	bh=Sz51QxuijqU3UVXlciX1gX+qxwIDmbv1WyrQEwPzKz8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WRtVfaCdG3pmpWSCg2Mbjk3LDBsMSnyYrHPpD3h035Yrfz5bZl486mOHvQ8m4m7IuUyzcX6DHSoZNND4TuXOyrNMGpAgsHM1c+Juiz2sPjjrDY53teYd3RKZiAEYFoWZF6MKtGSFXvM27Rl8gk+QHmQ3P9nO5HBtRj2F+UUWxXU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0FEA33858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=wRzeenXm
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D8F6245C64;
	Thu, 01 May 2025 14:49:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=2E18yIxHXQxieHM7ss2hAr+Kgrs=; b=wRzee
	nXm2zjlHh3ERDgehvFbg0YG2+c6JQHXT5BxlNjIbf91LmBjeHmFfDf9qmjH+JlCy
	7ELqOaiKJdgYO/mdupwdHBoi+Gz/fKCRKEQrQthczHI/ERrhXNAce02EUAMV8Zsj
	3nvPCyqYUlQwkniwQgLM7FUE6kreY5tuv7NV8s=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B90C945C1D;
	Thu, 01 May 2025 14:49:01 -0400 (EDT)
Date: Thu, 1 May 2025 11:49:01 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: cygwin_conv_path: don't write to `to` before
 size is validated.
In-Reply-To: <f1fbe13f-9d36-9b0b-e965-68df3c951ff0@jdrake.com>
Message-ID: <5db83f81-dca9-4c39-b3d4-d59a3e67e0a3@jdrake.com>
References: <bd0e9cdd-ba1f-423b-089c-7f84e5e8bb3f@jdrake.com> <69d84bb5-fdfd-47a2-aea7-dccdf5ac2414@dronecode.org.uk> <f1fbe13f-9d36-9b0b-e965-68df3c951ff0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 1 May 2025, Jeremy Drake via Cygwin-patches wrote:

> On Thu, 1 May 2025, Jon Turney wrote:
>
> > Seems like this should also touch:
> >
> > https://cygwin.com/cygwin-api/func-cygwin-conv-path.html
> >
> > (source in winsup/doc/path.xml)
> >
> >
> > I'm not sure what the conventional language to use for this common behaviour:
> >
> > "If size is 0, (to is ignored|to can be NULL) and cygwin_conv_path just
> > returns the required buffer size in bytes" ?
>
>
> Hmm, did you read the rust backtrace thread?  The reviewer there was
> concerned that the docs didn't specify that to could be NULL if size was
> 0, even though the example on that page does just that.  It'd also be nice
> to guarantee that to will always be NUL-terminated and never truncated.
>
>
> I'd probably go with 'can be NULL', I don't want somebody to think that
> it'd be a better idea to use (void *)8 :P

To clarify, I would do the docs update as a separate patch.  This patch
doesn't change the conditions on cygwin_conv_path (as evidenced by
cygwin_create_path calling with NULL, 0), it just corrects a bug where the
condition wasn't followed.
