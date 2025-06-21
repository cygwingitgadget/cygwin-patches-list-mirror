Return-Path: <SRS0=Mu3T=ZE=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 839F039BB07B
	for <cygwin-patches@cygwin.com>; Sat, 21 Jun 2025 18:47:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 839F039BB07B
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 839F039BB07B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750531649; cv=none;
	b=oK9s13zT2TUZzAgs6+wfZH4p/0vNUAvoXUaLDj9m8tFYSNRf6ZkA8eNbdSwmUe6Vucs7f611wZJAoaI3WKobk99dY4LVJsw5AcOoTBsCH5X3rCbdS+B9paT939CcbOw1RYohXFFx8zVGo/hI5G7Nl83hAXjN4Livsb/1V2tweto=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750531649; c=relaxed/simple;
	bh=CsIioS79rXZifeBc3jov52A3KQX5kfBbqeCzMGVRW34=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=q9ixJpuytIqcDc7Nv/nnujCqNtZsyxkrHKNH7ayfG5SD8Zqx5CY2MgkKsv11W2QWsqgzeIjpsXE3DyfQTv2xLM7/dn2kSxNLPhCIcJO//ZvIsqKKFJGBGBRRzBBhI086+E4BQfPZLVayDd8OZi9rvkVLGXkOZackX65jQBmZwOA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 839F039BB07B
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Kil01jXL
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2A3BC45CE4;
	Sat, 21 Jun 2025 14:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=axHPu4EJhC9uGSgxe8UkeOnijhE=; b=Kil01
	jXLg30idnxAoW5V08xfzDVtx+Qto9svRVvrCm1lAc/y/nfoBJLwqCu0Bj/Vl4yJJ
	AtoIqtHfPLgo3w9O51dv7aPwdnYm66xr0h5zH8BtdC3WmJHQp9L3QfGy13yzacN4
	VQiF49LpdrBc+0eVyZ/9KEShb7UoBZcGWYD9wY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 22EA045CDE;
	Sat, 21 Jun 2025 14:47:28 -0400 (EDT)
Date: Sat, 21 Jun 2025 11:47:28 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: stack base initialization for AArch64
In-Reply-To: <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
Message-ID: <5a0ee0d2-6fac-1886-45c0-c75dba8d0bd7@jdrake.com>
References: <DB9PR83MB0923A2E70C6E9F5931020E409272A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <f93437b4-a88d-9cc6-b156-a37b1e629810@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 18 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:
>
> > -#ifdef __x86_64__
> >  	      /* Set stack pointer to new address.  Set frame pointer to
> >  	         stack pointer and subtract 32 bytes for shadow space. */
> > +#if defined(__x86_64__)
> >  	      __asm__ ("\n\
> >  		       movq %[ADDR], %%rsp \n\
> >  		       movq  %%rsp, %%rbp  \n\
> >  		       subq  $32,%%rsp     \n"
> >  		       : : [ADDR] "r" (stackaddr));
> > +#elif defined(__aarch64__)
> > +	      __asm__ ("\n\
> > +		       mov fp, %[ADDR] \n\
> > +		       sub sp, fp, #32 \n"
>
> Is the 32-byte shadow space part of the aarch64 calling convention spec,
> or is this just copying what x86_64 was doing?  My impression is that this
> space was part of the x86_64 calling convention.

The patch for pthread stack initialization dropped the 32-byte shadow
space, and I believe this patch should as well.
