Return-Path: <SRS0=/5EK=VD=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id ABB763858D33
	for <cygwin-patches@cygwin.com>; Wed, 12 Feb 2025 00:13:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ABB763858D33
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ABB763858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739319226; cv=none;
	b=ZqYTZ77jg/lD0CGqxy55ndothQhTI2zPbMoPTwI3CEViJu2Cu/vLDowekEUoXLdLjla7BoLaoDJshkk40D5X2L23qYrz4ko35SRHGmL3luXu2URj6Uc8RbGYRl6dNGmZ3tY+yvmlrBEun6ggMApEJ+ihXNiH4Ggnu+zQUBg0ljo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739319226; c=relaxed/simple;
	bh=GaCvslGZHS5cLcXkVeK1N/sQM63uOo6aaKsXGtUi0UQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=CyQzmfxl0Mt0MtQNqyngDxijgg6Nk8bVideLPs6H/FPQaCuSY45Gz7yn1FRyFIOqUNfnp9Yx4T1fhom4tTZ+NIVCLxDfRYycIpA1IzlPkwcLeo92jE6nHG0zrF4qxBboQI3aLVWS5p0rEiK9YpA8uKCui4bjLkYzW29F54ZTlCM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ABB763858D33
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=tJdwCav5
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 85A6D45C1D
	for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2025 19:13:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=IFf8szH3F95iFuByf3iy3eJyl7w=; b=tJdwC
	av54Cnn5oFKwyqWKQBW/2ljacPPDHzhpnJu/6R8MDfozdBKTC9q8Dgp3kDuI+o3N
	tUKgCeKideHMH270nzkcef6Ju5Mylw9WmKeGfhYxTOxHzL7t2ITydpKoU1T42In7
	0s/opedL8M6HP9QXGLOoO3wR6j99z5mm5a8Klk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 809C145C1C
	for <cygwin-patches@cygwin.com>; Tue, 11 Feb 2025 19:13:45 -0500 (EST)
Date: Tue, 11 Feb 2025 16:13:45 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: make list of mounts for a volume in
 dos_drive_mappings
In-Reply-To: <Z6soHzMvH9hcJMRY@calimero.vinschen.de>
Message-ID: <b724a9a2-3882-298c-f0f0-58563cc5c863@jdrake.com>
References: <827294fb-0391-197f-6b53-52ea0f5e11e7@jdrake.com> <Z6soHzMvH9hcJMRY@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 11 Feb 2025, Corinna Vinschen wrote:

> On Feb 10 17:13, Jeremy Drake via Cygwin-patches wrote:
> > make mappings linked list in order rather than reverse order.
>
> Why?  I'm not asking for myself, but for the commit message.
> It may profit a lot from explaining what the change is supposed
> to accomplish. :)

That's two good points: 1) I didn't write a proper commit message, I'll
do that for v3.  but 2), why does the order of the list matter?  On my
system, the order returned by the functions matches my "expected" order
(my C: comes before my D:), but I don't think there's any guarantee that
that will always be the case.  I don't think it matters other than for
aesthetics though, but I don't know the motivation behind returning the
explicit mount entries in native_sorted order.  Is there any reason why I
might need to sort the cygdrive mount entries?  I could see that getting
complicated.
