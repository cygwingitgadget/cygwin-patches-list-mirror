Return-Path: <SRS0=QOKQ=WP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 725A93858288
	for <cygwin-patches@cygwin.com>; Fri, 28 Mar 2025 00:52:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 725A93858288
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 725A93858288
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743123142; cv=none;
	b=BkA/vgea7swU7aQi0c+To+RdrBLVvLefDo86BS4SsPVaWeEftWNHQmdiTzKMrrvSm+sOzECsaqFYM5SGyQ6/wwdGjIe8lwRH6pZmZ/ILlwQKeeFduyqchfBd3eLhGNxMNtTXN3UoOar3hTG3H14FOHQf2XfMpGIezd2vJMJKNOk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743123142; c=relaxed/simple;
	bh=SJAtjbQ9UMonZFMDWZIFUFoEiPWZQdo7K9qxYU3zPq0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=NfRHIBZHW3FN5RcDF2+rC20NJvcHQag0D5/0EMuEVKUWL7RRw0g64HyBHv4bmgtGdyXcYtgqebDU23cVNtdPcaQyEhtL+KwnnNM1iGJPcVY+37W8GOp4uS9Q9OKQInUVg9iYVzwD8lctFr8ICup2VaXW+W+AEUSEkT25YVQqCFc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 725A93858288
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=b8AFdOf5
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9AE9445CA9
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 20:52:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=gx4qXIrflx3fARRMahOVo+ZfHqU=; b=b8AFd
	Of50uhZnHsh8BA8esy4pQGnipZRjCGMcwKURkT3T64C+y++PDFlPw2Qq6oOkwccn
	bLfkhmJzpg5EPMybVxt6tn8ksJ+uhljUu8GKtWieLjB4C3VDBEfK8mZ4MXUwLfW2
	p1g4H1SdHz8qDlJGjMzcc0wOlPrSp3xL188Pos=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 82F6245C8D
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 20:52:21 -0400 (EDT)
Date: Thu, 27 Mar 2025 17:52:21 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on
 x64
In-Reply-To: <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de>
Message-ID: <580c99c4-d0bb-ee54-3a39-43b55f5abc1f@jdrake.com>
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com> <Z-U5WFBxoUfeVwn7@calimero.vinschen.de> <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com> <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 27 Mar 2025, Corinna Vinschen wrote:

> On Mar 27 10:26, Jeremy Drake via Cygwin-patches wrote:
> > comment, it seems 8.0 is the odd-version-out here.
>
> Yeah, but we don't support 8.0 anymore, only 8.1.
>
> > BTW, something I would *like* to do but haven't figured out how to
> > accomplish cleanly yet is to follow the registers.  What I mean by this is
> > illustrated by what I did in the aarch64 version: I could find the call to
> > RtlEnterCrticalSection, then work backwards, find the add whose Rd was x0
> > (the register for the first (pointer) parameter in the calling
> > convention), then find the adrp whose Rd was the Rn of the add.  What I
> > would do on x86_64 is find the call to RtlEnterCriticalSection, find any
> > mov rcx, <reg> before, then find the lea <reg>, [rip+XXX] (where reg would
> > be rcx if there wasn't a mov rcx after the lea).  Unfortunately, the
> > variable length-ness doesn't lend itself to iterating backwards, so I am
> > not confirming that the lea actually ends up in rcx for the function call.
> > The only register correlation I do is that the register used in the
> > mov <reg>, QWORD PTR [rip+XXX] is then used in the next instruction that
> > must be test <reg>, <reg>.  The old code required that <reg> to be rbx,
> > but I don't see any reason that rbx is required...
>
> Yeah, reading x86_64 backwards will lead to confusion.  And no, rbx
> isn't required, any non-volatile register could do it.  It seems that
> rbx is used because of the way vc++ allocates register.


After taking out the windows 8.0 case, I think this should be doable:
* when finding the lea that we're already looking for, save the
  destination register

* if the destination register is not rcx, look for a 64-bit mov into rcx
  from <reg> (where <reg> is the register from the lea) before the call to
  RtlEnterCriticalSection

This won't catch cases where they shuffle it between multiple registers,
or otherwise obfusate the load into rcx (push/pop, xchg, using some memory
location, ...) but I think this covers every case I've seen (including
those mentioned in comments about preview builds).  It would also allow us
to skip the theoretical-but-legal sequence (intel)

lea rXX, [rip+XXXX] ; FastPebLock
...
call UnrelatedFunction
mov rcx, rXX
call RtlEnterCriticalSection
mov rYY, QWORD PTR [rip+YYYY] ; RtlpCurDirRef
test rYY, rYY
...

I'll try to find some time to test this latest round on as many released
Windows versions >= 8.1 as I can, and then send a v3 series.  It works on
22631 at least.
