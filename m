Return-Path: <SRS0=jBaR=WT=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 37F5A3857C7F
	for <cygwin-patches@cygwin.com>; Tue,  1 Apr 2025 17:25:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 37F5A3857C7F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 37F5A3857C7F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743528312; cv=none;
	b=rLWEKrgtDA7TurhkeYisis52JGOG4EB0qw0jwF/kWSbuspUd2IAc6OMQpKPwSejXrx7Nj7QzC/IOTGaeM0gv2K5QbQ9oP5MpnVk7TgU2L6oDZhdf4J8Tf3Jx2VvQ9r+VH//+8r0UbLE9TSukStaQ9Oy7DrrprvEr0N6rWoaUOiM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743528312; c=relaxed/simple;
	bh=4p3MXIn3sPv+GGsX0rkyRDLfIYUgiN4qpWKV5/zM2iY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=iyrpbjofi+nhwVu6OnWZxROWa7TzCoBHzZ+kLVJUwngcq++iDUbVT5FyqUs7YWw+JQaf+KH7pJtBNkIEWQNQe7kbTPKebQK1ltPKRB2UamAiRHdu7swnkqc7iAQF7V8w0uHvQ1I0cvKchW6CfVptFfBPzGz1S4Lpide+z427aCk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 37F5A3857C7F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=nFDgfQal
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A6E8E45C93;
	Tue, 01 Apr 2025 13:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Mok/bCroyBiUXyCt4e2V57CNIYs=; b=nFDgf
	QalMVaDLk/nvd61hsR3iOdom/NKTAQbB7cQ3tZp5X3QKfUP697hcoevotizElGZP
	/dXNCF8QpXRFBrlYSZead9C5mJc+LvG08h13oIpZpwWnadDo1ILZZWTKuZIen41I
	aWwhaAv8z1GyDot2NtEsEe5onoKy15XxE7gUiw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 8F89645C8D;
	Tue, 01 Apr 2025 13:25:11 -0400 (EDT)
Date: Tue, 1 Apr 2025 10:25:11 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de>
Message-ID: <c302213f-6d65-2ad3-6dd5-b6a887b3ede6@jdrake.com>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com> <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com> <Z-pQB1d2It9jkuFS@calimero.vinschen.de> <Z-r0vQTnzdkrCIsq@calimero.vinschen.de> <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de> <236d3480-bda4-08cc-9ef5-e83ff9f668d3@jdrake.com> <Z-ugBR-lzNL7WxHT@calimero.vinschen.de> <Z-up6Q9eFQ6ir35Z@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 1 Apr 2025, Corinna Vinschen wrote:

> Oh, Jeremy, here's a question.  We only add udis86 to the main branch.
> What about the 3.6 branch, does it still need a patch to accommodate
> the fast_cwd magic for a newer, upcoming Windows version?

I was going to ask about that too.  I assume the plan is to keep the new
udis86 code for 3.7, and continue applying band-aids to the old code on
3.6 as needed.  The question remains, do we apply band-aids for insider
builds or wait for an actual release (or something approximating a release
candidate)?

> And btw., I checked the file size again, and it turns out that after
> stripping the debug symbols the DLL takes ~30 pages or 120 K more memory
> than before udis86.  I hope that's ok.  But if you see ways to shave a
> few pages off by dropping code from udis86, I wouldn't be too unhappy :}

Hmm, I only tested on top of msys2 (which is on gcc 13.3.0), but here's
what I see:

$ ls -l
total 47952
-rwxr-xr-x 1 XXX None 24682293 Apr  1 10:14 postmsys-2.0.dll
-rwxr-xr-x 1 XXX None 24417887 Apr  1 10:12 premsys-2.0.dll

$ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
264406

$ strip premsys-2.0.dll
$ strip postmsys-2.0.dll

$ ls -l
total 6428
-rwxr-xr-x 1 XXX None 3330598 Apr  1 10:15 postmsys-2.0.dll
-rwxr-xr-x 1 XXX None 3246118 Apr  1 10:15 premsys-2.0.dll

$ echo $(( $(stat -c %s postmsys-2.0.dll) - $(stat -c %s premsys-2.0.dll) ))
84480

One thing I noticed that could make the code using udis86 smaller and
faster is to use members of the ud_t struct directly instead of calling
accessor functions.  I don't know for sure if these members are intended
to be public or not (but they do seem to know how to declare members as
non-public: in ud_operand_t, they have an "internal use only" comment
followed by members named with leading underscores).  I don't think it
would make a large dent in the size of the code relative to the size of
udis86 itself though.
