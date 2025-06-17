Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 41C9A3852758
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 17:44:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 41C9A3852758
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 41C9A3852758
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750182293; cv=none;
	b=Xmz9UcCYE568K5FstTJK/QzWnE1Pyg8SDW6noO3Uwk8qDfuaBUY3B1mirxmy9HwbpwVipZxEFaATGCZyCUjmuRA/zi4em38MwucVixd82Mx/dpKfL9Tpm/UdgzZf7RJo6agsArId9FzIU1KcofbrcpnQ7f6TkvSLcP9d8OD20Os=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750182293; c=relaxed/simple;
	bh=3lf0sxJf/HwCHx/DBuDFDmwZ1lzH15pNlCaGYj5lrac=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=xebQuJXgIhDYNic3CqdbDb+EP8Sk1pXN14jCqxlWmubJjUmXnQyOqG2iR+08iiFoASi0FIsdPgxy2SqQcnSYJyMMJ34jGMWL2Ged/5ulH5ZEX9dbdAZW4nP4KKdHvC8UlcLoTekbZ+msXiCWV+qmmm0Uf4FsmBZzggg90ahMLDI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 41C9A3852758
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ZGaM7uYI
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 105B245D53
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 13:44:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=qegQoWOvmx2Dh7IkbUGFxY75uf8=; b=ZGaM7
	uYIuacohLpvyBnNPRHyvXwpo9jKbSczdo9H0e9VMxX4J2RCeIW9sIDa1X1EoWtAq
	Lqsj77BNMk4aKe2i1T+ZoK3I5ZSlLASpm/WddFhyUwDv84CmX0ZQDmAZr5nuBykZ
	oDn+nv5YzItNc3/wnolHgma5+EJKpMbHEJvHxM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id EA47145D4C
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 13:44:52 -0400 (EDT)
Date: Tue, 17 Jun 2025 10:44:52 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [RFC PATCH 2/3] Cygwin: hook posix_spawn/posix_spawnp
In-Reply-To: <aFE4hznx51Xw_aNF@calimero.vinschen.de>
Message-ID: <9a350320-4d7a-509a-c5a7-beee9185824d@jdrake.com>
References: <610f9534-b03b-a495-d046-6f09f7a077db@jdrake.com> <aFE4hznx51Xw_aNF@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

> On May 29 10:58, Jeremy Drake via Cygwin-patches wrote:
> > +
> > +/* HACK: duplicate some structs from newlib/libc/posix/posix_spawn.c */
>
> That would be better defined in a common newlib header.

Is there some precendent on how to handle an "internal" header shared
between newlib and cygwin, but not a "public" header to be installed?
