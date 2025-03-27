Return-Path: <SRS0=q1Em=WO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4E52F3858429
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 20:05:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4E52F3858429
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4E52F3858429
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743105933; cv=none;
	b=m1MwYX1L1EYVe1Lf73vLcT3Pd8TyOzcsUuX0MfdtbSbjr1ZWaRoqkHCeA3tui+BEDbTKzd+qBwhquxAxOUV0G5F/6sQ7aB1vgWkpjLlCNnKcxeQjQG9jFTJ9VpP5SgEYck2uMzSN68rlfU5aoSb4j8A7NfnfxoDON1isE7xsLYE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743105933; c=relaxed/simple;
	bh=or9ZYn3NoMMbVdW30EDS9/vPHY/12zff4tGfGnCPjYE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=E3dgKgRFaV+luJxTpVOCBQ4dR3Yt5ENTE6+czSnuMqFNVKreBg9iGykVJ+iRtKtEgfe1MmJDwpMmBGQBOepuQy4/sycuOyRis2+sXBjWwDArPR3wmc8bHfVhuC5CoDqrLdlaGeya7zYufrrLjkINZ6Qa/5QVYRcr8tX+S0MS7Zo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4E52F3858429
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=dUHrxbr5
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7971C45CA9
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 16:05:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=jmGYTrRnpoKOhLJ108SkPZK2yEE=; b=dUHrx
	br5VwA3rb+7CL077w23LK1fKk53VtrvDJVwNmJo85QWWADQ6TYaf/bh2/iRM+23l
	w216+1c6mViS/qTgplfSLy8UD9u+HqE2cbCSnJUT/u1TccqB6vRQ8t41P0ogM5Ea
	cJA84FcrBLRoNOZ2iEHtqJq904C25X2M2p/ysw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 72D9745C94
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 16:05:32 -0400 (EDT)
Date: Thu, 27 Mar 2025 13:05:32 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: use udis86 to find fast cwd pointer on
 x64
In-Reply-To: <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de>
Message-ID: <90f7ce33-d267-ffc8-1a5c-23271c338296@jdrake.com>
References: <7d4f8d91-0a3f-4e14-047e-64b1bd7d9447@jdrake.com> <Z-U5WFBxoUfeVwn7@calimero.vinschen.de> <f7b8d776-ca5b-a0b3-63bb-02ea496e5bb6@jdrake.com> <Z-Wm3C1AoXLaYeMg@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 27 Mar 2025, Corinna Vinschen wrote:

> > comment, it seems 8.0 is the odd-version-out here.
>
> Yeah, but we don't support 8.0 anymore, only 8.1.

Should I drop the else if case that only handled 8.0 then?

