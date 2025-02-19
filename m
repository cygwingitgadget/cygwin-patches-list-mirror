Return-Path: <SRS0=3P/8=VK=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3FA673858C78
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 18:14:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FA673858C78
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FA673858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739988894; cv=none;
	b=PWypdcSV2wp6zh+ghQ/y1aEUV1Y6JSin5UlyfIqOqpwYosJkhbUMaWZMAPEYOt2gpte502pxThOg7cTspZYzDTm8OixLm4aouo/hBkenyo1JFAOOhkiOUis1zU7kKHr6n5m4MnEnmpNPcpiRkNVnfVK7hPamr/xpMeDVkimBnYM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739988894; c=relaxed/simple;
	bh=sDq5ovVHbZMB52Xah+EdHQVNlxrPrHPnK8ZZxPJ9LVc=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZFBBKRkPv8ztFZQZGYEnsid2oDRliMw3FGego7yRnVFaCSkPDsJQcHeiYkYq9G9vVTqmlj7FlicmTY0+2D8yFLhkh2Jbmfy2++ZAAPBSgc9QCN2C/27jHub2aChEcHlFGsTvw0l3NMu8jCcntIgr+0f+Wik5yTd6lI+aDx9qtpc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3FA673858C78
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=YITCMhIi
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9DD1F45C4F
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 13:14:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=pmq3j4+2jE0nq14bWBfSuOcdAT8=; b=YITCM
	hIiXVbuMCo4ycnPqHONLyYA+5l0iUgq9mSXBaLm13bFxAMJiM5Vf0zlKAfoIeCRJ
	b3SWo+cGLIuxEwgMxeeZGqULU5h5CHDfJdBX1yBc0ClSkC3Ouomi0h0LtFikAFJu
	bzf7zwCDsY1AwElbgQeq0lgEVmfjYRUMoiuk90=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 698C045BF6
	for <cygwin-patches@cygwin.com>; Wed, 19 Feb 2025 13:14:53 -0500 (EST)
Date: Wed, 19 Feb 2025 10:14:53 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/2] Cygwin: skip floppy drives in
 cygdrive_getmntent.
In-Reply-To: <Z7WtIsNZb7Fqnmxg@calimero.vinschen.de>
Message-ID: <33a7b714-0f8e-d640-143b-2fd624372f51@jdrake.com>
References: <9b20134b-c892-edbd-eac3-d2781bcec039@jdrake.com> <Z7WtIsNZb7Fqnmxg@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 19 Feb 2025, Corinna Vinschen wrote:

> Hi Jeremy,
>
> just a minor thingy:
>
> On Feb 18 17:51, Jeremy Drake via Cygwin-patches wrote:
> > +  dos_drive_mappings (bool with_floppies = true);
>
> I would rather not make this a default parameter, but call it elsewhere
> with an argument "true".  Or even better with an explicit value, like
>
> enum {
>   NO_FLOPPIES = false,
>   WITH_FLOPPIES = true
> };
>
> I have a local tweak along these lines.  Would you mind if I
> amend your patch with this tiny change?

OK.
