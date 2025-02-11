Return-Path: <SRS0=c54n=VC=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4F9793858D20
	for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2025 04:16:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4F9793858D20
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4F9793858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739247402; cv=none;
	b=GID19cBaevf/zR2h4Qbw5MkmvWfAbRpunlNHm4aSneD5HGHxO9alWOp/DT1PKlTCAsgp0qmWopxLpzsY7EYDhRyS9yzWCrjphK3lGGR2jedTWTtsyIEbDAM1cHc7lScuyZF9zp+M/Op/zvsDp4rSBGVlznKdEPgLg/We7pgPKro=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739247402; c=relaxed/simple;
	bh=DoulMWm0elOIUuCMN4OD6ETvaG79YybDnkGBhHCIxjc=;
	h=DKIM-Signature:Date:From:Subject:Message-ID:MIME-Version; b=Pnj0L/zmH8keUBWTddhPVSix/dWmkQT7ht/CV9JGWHr3lrZCO/FAJ/qDUT9ulDt7GUEiRBcuKCr9vNfUMh5WWKf7S/QefQJogSWnA9MkU8iK4zDE3Qzu3tZa3CsYkIEpjT+e9eSde6tl30Q4fmsHAqeFmENOMhdv5GAOrHdhEJ4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4F9793858D20
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=iCkHdv0S
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id CC7D245C59
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 23:16:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:cc
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=AWJB/uBiiVqAjt+oU84vYVOlNqQ=; b=iCkHd
	v0S/c9HH7+jo+CSeX0E7ut1TpZ4nVeyeScNWhCAP+IChsU8i0Z6uktuPc+LPBXdZ
	v+Lle0G2vJADYQBOQyXzfouNFcbj1WPrpDY7OiqAjc7F7zURb6Yn0EtPeM0mpvq/
	QBV5i6oNH/+qBAUxEWH/ZrR1MzhN91tiVJORxI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 986E945C58
	for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2025 23:16:41 -0500 (EST)
Date: Mon, 10 Feb 2025 20:16:41 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
cc: cygwin-patches@cygwin.com
Subject: Re: Subject: [PATCH v2 2/2] Cygwin: expose all windows volume mount
 points.
In-Reply-To: <156c9368-5e48-b426-0486-6987cdbf4311@jdrake.com>
Message-ID: <ce78e46f-4f7e-f9f5-9f24-640bf0e63046@jdrake.com>
References: <156c9368-5e48-b426-0486-6987cdbf4311@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Realized an oversight (besides the messed-up subject!) after sending:

> @@ -1943,14 +1961,6 @@ extern "C" FILE *
>  setmntent (const char *filep, const char *)
>  {
>    _my_tls.locals.iteration = 0;
> -  _my_tls.locals.available_drives = GetLogicalDrives ();
> -  /* Filter floppy drives on A: and B: */
> -  if ((_my_tls.locals.available_drives & 1)
> -      && get_disk_type (L"A:") == DT_FLOPPY)
> -    _my_tls.locals.available_drives &= ~1;
> -  if ((_my_tls.locals.available_drives & 2)
> -      && get_disk_type (L"B:") == DT_FLOPPY)
> -    _my_tls.locals.available_drives &= ~2;

should have something like
+  if (_my_tls.locals.drivemappings)
+    {
+      delete _my_tls.locals.drivemappings;
+      _my_tls.locals.drivemappings = NULL;
+    }
here
