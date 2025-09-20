Return-Path: <SRS0=evLx=37=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id AB5073858C51
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 19:52:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AB5073858C51
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AB5073858C51
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758397937; cv=none;
	b=tk7W6jKb2juCSsGyeSxyCsA9STG7U4Ux2QJa1Ee/T1ZYrIKKkcYiJobB7K8h6N8sj4pDsceeZ8omaPxDnRzHzoOup5wIX/VS4VCJk2CqOpHzONJIV7J+W15Fm+HTNYUlYeegD2Iyn8jfUAdNI1hPrlto0vsBz1hwGmKX7bQ64Yk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758397937; c=relaxed/simple;
	bh=NCXarncaMX/HcdVcsrYVNnsrxe5JuH/hARdwvPXPxso=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=p4IiJipYZze1VjwmlV/CJedSv0aUrKnQy2Oq0+5/6b01NTSkVOoBpGziFILgTANuzAORo1db+MIGe8FAGggrQL7DpFXGZuav3Ovux9kIhyfCZb8H/y6I4CyzyMZlzdW1Rzy4IwsP8lCGdv2bHjoleDnXX8K9wHTfHbclzPNdFwM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AB5073858C51
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=nrXKXg7P
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2934E45D37;
	Sat, 20 Sep 2025 15:52:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=uiR9uG3xZmt+FOftbTC9FRSCfIQ=; b=nrXKX
	g7Pui5/LYm+Kd+WnvbQsIIY6/FESlaQ2kTp1Sc47bg72/xAOtTcx9f0gjhIgOK6u
	rFF9H95Z/Hl+kpLpqAZDGQxrrdXy1MIm7UvieHNZZ8HI6iyGqaMLt6qd1zAHyNNe
	L2aHhaHH4kqpZWbLsPJbNHJNlXeUN207Ztysr4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0C46845D36;
	Sat, 20 Sep 2025 15:52:17 -0400 (EDT)
Date: Sat, 20 Sep 2025 12:52:16 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: lock cygheap during fork
In-Reply-To: <d4551d29-1128-4ff1-b8e8-8238f192de3f@dronecode.org.uk>
Message-ID: <397323a1-e83c-ef1f-3dd3-a019adf2ab69@jdrake.com>
References: <e3dfa011-3ddd-6f69-439e-87746ae3a2b2@jdrake.com> <d4551d29-1128-4ff1-b8e8-8238f192de3f@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 20 Sep 2025, Jon Turney wrote:

> On 19/09/2025 22:43, Jeremy Drake via Cygwin-patches wrote:
> > another thread may simultaneously be doing a cmalloc/cfree while the
> > cygheap is being copied to the child.
>
> Makes sense. Please apply.

Done (and cygwin-3_6-branch)

>
> > Addresses: https://cygwin.com/pipermail/cygwin/2025-September/258801.html
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> > I'm seeing a timeout failure of pthread/cancel2.exe test in GitHub CI.
> > This seems to be happening even without this change, so perhaps it is more
> > to do with the update to windows-2025 runners?  In any event, this
> > prevents the 'stress' jobs from running against this change.
>
> Thank you *so much* for keeping an eye on that!

I did a test run downgrading the windows-build job to windows-2022, and
all the tests succeed there.  I still have no idea why the pthread/cancel2
test times out on windows-2025 though.
