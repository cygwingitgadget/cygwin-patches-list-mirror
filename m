Return-Path: <SRS0=C3iS=2M=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 856B43858D32
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 23:57:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 856B43858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 856B43858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1754006227; cv=none;
	b=IKXu/nbdhMOODlRPoWq9uvv33GFPEmjbVnLRogMfxJcPnT2wUv5PCGew0nW3BNt02RSKti1szYehgk8D1sdV65JxomA5Vz5/whiUazseE0+rhBgwcwNVlLZ8x6ywnCMQB4lo98JScAk+txOQI5XttwvnZcemnPpKrZ3sLQsJ5DY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1754006227; c=relaxed/simple;
	bh=nzQKRp+gUgvyA3FJRHeJytFc9QjVhvyskrtPL0QGCpE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=abFFvTJ6ZK23aPyOEOX6kKM1MUs8mKhoZcdYFKmNMc3fkYf1v50ozVOabb6mkSIAJaiy6nTJHEtMl79bnXqmINM9p+alVsPsJrlQKFhOPf5On35yE1HmksVhlPeclScxmHUMS4swS9/BFV4j8HUV8i2h1YOqIhZI7lbIJP2cV7c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 856B43858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=tRAPRzo4
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 28EDD45CDE
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 19:57:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=EPUYiaT6vb2Z/0mbtHPwja89KB8=; b=tRAPR
	zo4xfGFYex64Q+qfvAlO9spq8LsXlq94Z/iKhsAC9d2wjK4ri9n/HQM9niCYYrpu
	9glTdsjwHD2Xxt/c3LTvV2L9J3M/Ijx4J/6n5jCgR/UxnrPin7IP9qYb/A0T73Nf
	FL5wIVwyhUVxtDKV9T7FNxswofOl7qHfPaQgdc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1155945CDA
	for <cygwin-patches@cygwin.com>; Thu, 31 Jul 2025 19:57:07 -0400 (EDT)
Date: Thu, 31 Jul 2025 16:57:06 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: add wrappers for newer new/delete overloads
In-Reply-To: <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
Message-ID: <834bab43-9774-fd9a-2456-ecfa4274777c@jdrake.com>
References: <778f2295-5ae5-b0b3-08f7-8623ed05e5b0@jdrake.com> <aIoOKpzb557bX0cE@calimero.vinschen.de> <dc98431a-9452-740d-5174-d4a00e3375b2@jdrake.com> <aItALodM1WC7KP_C@calimero.vinschen.de> <a3d7b45a-8640-4c5c-9877-26fd2fa7fa21@jdrake.com>
 <aIvTxi4eB6kmuT-j@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 31 Jul 2025, Corinna Vinschen wrote:

> On Jul 31 12:05, Jeremy Drake via Cygwin-patches wrote:
> > I noticed that dll_crt0_1 calls check_sanity_and_sync which performs some
> > checking on the per_process struct from the application, including if the
> > application's api_major is greater than the dll's.  However, this is after
> > _cygwin_crt0_common already runs.  I tested by downgrading to
> > 3.7.0-0.266 and running an executable that I had built with 267 (but not
> > using the new wrappers).  It didn't crash during startup, but it did seem
> > to crash after forking (it was doing a posix_spawn).  So maybe the
> > api_major check could catch this after the fact but before the corruption
> > caused any more issues.
>
> How so?  That would be in the DLL, but you're running an old DLL which
> you can't change retroactively.  OTOH, _cygwin_crt0_common already
> overwrites memory.

Yes, this check happens after _cygwin_crt0_common has overwitten the
bounds of the __cygwin_cxx_malloc struct, but in my testing this isn't
immediately fatal, and the api_major check would abend the program with a
suitable message.  I should test this with MSYS2, to make sure the memory
layout of the dll isn't different, and also because it's easier to get
older DLL versions (I only tried with the snapshot of 3.7.0 before the new
wrappers were added, but I can try with 3.6 3.5 3.4 and 3.3 there
pretty easily).
