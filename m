Return-Path: <SRS0=7VsH=WU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id EEC7B3857833
	for <cygwin-patches@cygwin.com>; Wed,  2 Apr 2025 05:25:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EEC7B3857833
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EEC7B3857833
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743571501; cv=none;
	b=HcVb/FkEHxd2b9vxKyapk8NrcIysXSz40ORhrFu7pZxoNt8PgwUB9uA5ps4f2jFx85qWmVvaVivJrNr5dE+F01eg0NSw1E4mOz6verdTRQZ1UbeyArFD4UbNLNT8B3ddIz6X7UT81Qb6ewz9EI1AJ8udnXxfsLm4dhHlXxRklqQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743571501; c=relaxed/simple;
	bh=cA2fTWsUH6tkfAGXvWlarwVuhZYqVMoI4RqSYX7Bzig=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nOQadlV0QHDkHaRi6CQAgiKdm/lO/mfpQQC/Fsf3IO2l95kIZIT3h/0Ins9yYCwHs+xYzc5fE830KS1XT/wOoIXwfNlwp3Qiul+Y+23BXUuf7N4YXHTUvSgrBgJk30p1l5n12vW3KrnywFoDHO5G2if3oybkaMRF6EmphwVZS90=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EEC7B3857833
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=o9HF7gRl
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 548D545C94
	for <cygwin-patches@cygwin.com>; Wed, 02 Apr 2025 01:25:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=qwL1i6g3S3EbaehQyR+YAi23dZ0=; b=o9HF7
	gRl0rKWZ8qWCyLOzt69Qn1VQwOV2XFemlAxtaUUM1F3XMG/GniEDqm/rBH5H+fUx
	UPJLsuPk4wwSL097oIzCRGY+Yqry440wQsP5ix93OYTd1jdPKYiLm45GAP2G/cDV
	B6egnV+tA7A/ImLIhthfV8+2w1LUV6jXiuSCvw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 385DC45C8D
	for <cygwin-patches@cygwin.com>; Wed, 02 Apr 2025 01:25:00 -0400 (EDT)
Date: Tue, 1 Apr 2025 22:25:00 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com>
Message-ID: <c9bbf5d2-8e93-49fe-c19b-a05aef399039@jdrake.com>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com> <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com> <Z-pQB1d2It9jkuFS@calimero.vinschen.de> <Z-r0vQTnzdkrCIsq@calimero.vinschen.de> <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de> <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com> <Z-ugBR-lzNL7WxHT@calimero.vinschen.de> <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de> <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 1 Apr 2025, Jeremy Drake via Cygwin-patches wrote:

> On Tue, 1 Apr 2025, Corinna Vinschen wrote:
>
> > And btw., I checked the file size again, and it turns out that after
> > stripping the debug symbols the DLL takes ~30 pages or 120 K more memory
> > than before udis86.  I hope that's ok.  But if you see ways to shave a
> > few pages off by dropping code from udis86, I wouldn't be too unhappy :}
>
> Hmm, I only tested on top of msys2 (which is on gcc 13.3.0), but here's
> what I see:
>
> $ ls -l
> total 47952
> -rwxr-xr-x 1 XXX None 24682293 Apr  1 10:14 postmsys-2.0.dll
> -rwxr-xr-x 1 XXX None 24417887 Apr  1 10:12 premsys-2.0.dll
>
> $ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
> 264406
>
> $ strip premsys-2.0.dll
> $ strip postmsys-2.0.dll
>
> $ ls -l
> total 6428
> -rwxr-xr-x 1 XXX None 3330598 Apr  1 10:15 postmsys-2.0.dll
> -rwxr-xr-x 1 XXX None 3246118 Apr  1 10:15 premsys-2.0.dll
>
> $ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
> 84480
>
> One thing I noticed that could make the code using udis86 smaller and
> faster is to use members of the ud_t struct directly instead of calling
> accessor functions.  I don't know for sure if these members are intended
> to be public or not (but they do seem to know how to declare members as
> non-public: in ud_operand_t, they have an "internal use only" comment
> followed by members named with leading underscores).  I don't think it
> would make a large dent in the size of the code relative to the size of
> udis86 itself though.

I changed the code to use the struct directly, and amazingly the dll was
the exact same size after stripping.  I then tried building the udis86/*.c
with -ffunction-sections -fdata-sections, and that resulted in a *larger*
dll.  Building just udis86.c with -ffunction-sections (in addition to the
struct access change) resulted in a 1k savings.  Instead #ifdef'ing out
the unused functions (including those now unused because the struct
members are read directly) in udis86.c resulted in a 2k savings.  In
addition to ifdef'ing out functions, building all 3 udis86/*.c files with
-Os resulted in an overall 4608 byte savings in stripped dll size.
