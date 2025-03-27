Return-Path: <SRS0=q1Em=WO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A10EA3858288
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 17:28:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A10EA3858288
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A10EA3858288
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743096507; cv=none;
	b=hfjL6xWG50AcRoJp2fQBz2V2RXqEA2oMvgU1C1SM40x/rRyjKqIlqDMHsfrP7tP4To2rtPFWOcs+rgu2bAyrMO3Fkn/zoFpEhBKrNzZ+6IS3KuSj9PmDhlQZwztBQPZQZZFiulMKtNEI31xahCuoLcXdWgYN0k+n2YVa8OedlPk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743096507; c=relaxed/simple;
	bh=1he7wXmfgglFS+RzWOwI5cy0bW/QdU5HAL/RDQEkwe4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ElDLbm0nlsuu0UMrTXxSvc1ENZjJts0tf0j3SaA2zCBsZXAGb+yvgjef6Q0QKDqFI33Y12NJu02+hlv5sj2YA1Xs50b2HZX9mqKZMZPV4sdd6OZPJzjPpgPXT8EFukpYo6WnB7JR1+iCnM1yCpe5pEFm8is0jthv1SBn/3jyi+o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A10EA3858288
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=HsaOSEvp
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 444E745CA9
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 13:28:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Sn5dXoarNJtvDBRWs2dnWeUKPNY=; b=HsaOS
	EvpzWFCqH1cd4sBePazXMLVsP998WRhYGhJnqGfwy/ijyPLE37lk0nHn0Box3JFi
	q3d9eiAP8nJsErfGMdvzlMP17m+3HoimrBaW9IBOLRlYkjUCDvPm9Id+w0MnsRD7
	dUFhEzzLSwts/MUZuXDb4r9g07Q7zkEzZndrbM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3F1DE45C8D
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 13:28:27 -0400 (EDT)
Date: Thu, 27 Mar 2025 10:28:27 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 5/5] Cygwin: add find_fast_cwd_pointer_aarch64.
In-Reply-To: <Z-U6_zrqfandDmqr@calimero.vinschen.de>
Message-ID: <f5174205-a664-44ba-f557-16d8dc61f48b@jdrake.com>
References: <24fa8928-2133-b73a-8c1c-28459f48b2da@jdrake.com> <Z-U6_zrqfandDmqr@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

> Naah, I don't know.
>
> If you ask me, I would introduce a new directory aarch64 and
> move the fastcwd_aarch64.cc file into that dir.  Then rename
> them both to fastcwd.cc.
>
> Makefile.am should add the file to TARGET_FILES= for x86_64, i.e.
>
> If/when we later add a native aarch64 target, you should have
> only one file aarch/fastcwd.cc, which is built into Cygwin if
> TARGET_X86_64 and in a second block defining TARGET_FILES= for
> TARGET_AARCH64.
>
> Make sense?

I am concerned about having two source files with the same basename in
winsup/cygwin/Makefile.am.  Are you sure that won't cause any conflicts
such as with ar or something like that?
