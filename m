Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 75DBD38693E7
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 17:08:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 75DBD38693E7
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 75DBD38693E7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750180105; cv=none;
	b=Whg47y9Fw0nhn/3lTCWHBCrCIkqHn0TnnWyUa6LCmjo4YsaDzzmdm5GwukJwu7gQWDOnET1a5Ll1EOx21q4wMxYl/+vjxQggOvR+eCKH/F8lA+PJwOCRk/IC96k9V5QTsJePnYV+ACV8n3eb6RRa+Lvf0u0q9cj0uvd97snict4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750180105; c=relaxed/simple;
	bh=pbQnXEvFD2IJuKOP4V6qS68ZM1lMmCmoK0iFsug7ZAI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=POSigVZxCbNWax1/ilukYuqZgcBzc9f9SeURrYd71VxPA2oMth/obbZOC1vpZ1niFaRaxhkqDUVj8bgqGeCNXa9GzwQDIntuD9dkSzJRGQSNPCGvzOcnp2jc24UudzCTJOcFVD/q5It9T88TVEmtrCIHUboCMWG6NiWpWuRlJIg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 75DBD38693E7
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=y9s2IoQS
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 5628F45D51
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 13:08:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=6X8JJ+YeB7H0EekvkXbO/fq5pmA=; b=y9s2I
	oQSFNonFbocVIQ0I5d0KfDn7iHoQlNGAt1ZKhYvByX/2wNT8JdRGyxyEciT74BN1
	t1kalea6qB+G16/9cMIe+XXp9MtpOu9dzwI/DdMG3pd3gheJxN8UMl4WXOi57VwW
	q5vS5zsUeODVx6dYXC/9Q0DxrzpRjnqPYu4VQI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 5089345D50
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 13:08:24 -0400 (EDT)
Date: Tue, 17 Jun 2025 10:08:24 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 3/3] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aFEz6oQu8oE3tWFp@calimero.vinschen.de>
Message-ID: <28ab5d29-be27-c1a1-94b7-c448bc913c0d@jdrake.com>
References: <2f8b971d-a604-9bef-97d5-f816d92b9dfd@jdrake.com> <3baf10c3-c393-1b04-c9d3-651c8eac9d28@jdrake.com> <aFEz6oQu8oE3tWFp@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> On May 30 16:18, Jeremy Drake via Cygwin-patches wrote:
> > On Thu, 29 May 2025, Jeremy Drake via Cygwin-patches wrote:
> > > +	      /* TODO: FAE_(F)CHDIR */
> >
> > I am not seeing how the posix cwd is passed to a spawned child.  Windows
> > handles the cwd itself, but for cases where the cwd is virtual (say under
> > /proc) there must be a way to pass a cwd that Windows doesn't know
> > about...
>
> The cwd is part of the cygheap. Inheritance works by having different
> inheritance flags which specify how the data is propagated and copying
> data in the cygheap selectively.  The cwdstuff is part of the cygheap
> header which is always inherted by all children.  Does that help?

Yeah.  I think I figured that out, but it took a while to get over the
"this isn't fork, so the heap wouldn't be copied" factor. :)
