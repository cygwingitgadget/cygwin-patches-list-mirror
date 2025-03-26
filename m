Return-Path: <SRS0=qRO6=WN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 64B34385AC1D
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 17:49:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 64B34385AC1D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 64B34385AC1D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743011385; cv=none;
	b=R3LOnNrpb5xUCAB+URGk/uVjvuRdT0wo3EF2lOKvmjMsnncL8awHD/MR5Xu+wrEJasPs4B954jVzZrpAnTFUX1kOVw1Fo50oibpg9dWBkD3MaEHws2KnGMEAZoeUvD2ke0twOuXrT7H68EC65BGECATHWjyh3CNWcWHT5S+Fc1o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743011385; c=relaxed/simple;
	bh=IB7GLwBfE/3f/F6cOsz1m8WMwLMHK2YvR7KujCLZQ6s=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lNYII7EGM2DBxzjaSf/OPTxdHouDXN+3UXc1wCgKWu6755TYnghZrnIRbxIZ9PXUtbkaPZr1yyfNdnNpEwVftLi9JmvydwQN9faiLFqNsfEBLVslxytfD5Xud57Z8pyadJFSlbyghquAlItskmWe7ZYRGVp330SD+6rqNXRNapA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 64B34385AC1D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=JAy4U3vU
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 08B6445C86
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 13:49:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ZzdmrnwAecFo28nU0gSBVgRc+p4=; b=JAy4U
	3vUttbmsdz16CNRSuupljgTYPjX0Fr1hHoYH92jmAgNPeXsp7zzg1r5Ffe4NTSjE
	WOtgdxxpbZj54pMXWrLsUEJhgXuZncUZkjopmjDXo7e/AtzDxHOdcplumyNb/PZa
	kb9yzpDKS7sxRRV4CvGcHxxq/eI9DzqgaiRL1w=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id E3EC145C83
	for <cygwin-patches@cygwin.com>; Wed, 26 Mar 2025 13:49:43 -0400 (EDT)
Date: Wed, 26 Mar 2025 10:49:43 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] Cygwin: vendor libudis86 1.7.2
In-Reply-To: <Z-Eyyg3c3Jvs23rf@calimero.vinschen.de>
Message-ID: <5c943d20-1aa9-bc9b-5a6e-8174b0184a95@jdrake.com>
References: <f86ec933-b668-cce8-701a-0484b69aca50@jdrake.com> <Z-Eyyg3c3Jvs23rf@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 24 Mar 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> On Mar 21 16:47, Jeremy Drake via Cygwin-patches wrote:
> > From: Jeremy Drake <cygwin@jdrake.com>
> >
> > This does not include the source files responsible for generating AT&T-
> > or Intel-syntax assembly output, and ifdefs out the large table of
> > opcode strings since we're only interested in walking machine code, not
> > generating disassembly.
> >
> > Also included is a diff from the original libudis86 sources.
>
> Can you please make two patches from this?
>
> Patch 1: Add the original code
> Patch 2: Apply the diff

OK.

> And you're aware that you're invariably are becoming the maintainer
> for this piece of Cygwin, right?

I do not like that the fast cwd code exists and digs around for a private
variable in ntdll, and I was dragging my feet on integrating the ARM64
support I prototyped because I didn't want to be responsible for
perpetuating it.  Now I'm becoming the maintainer of my least-favorite
corner of Cygwin ;)
