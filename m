Return-Path: <SRS0=Z4hW=VJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 3FE513858C35
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 21:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FE513858C35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FE513858C35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739914592; cv=none;
	b=m2WvkDUJY7oRQYnTvBbmI3wbU89mnv+DExFb2lavnmAGcDGSI0jX+CUOGCRDbbrM+0bZq5PBnt97cLRTcHm4t4vnchVr2Y+Zd5RxY7WEW+0RhJptAbui/NxMO107hukQbIyEMRIg3r8pJQwGaHykn4d1r4u0XFiK4EiyM1mByZM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739914592; c=relaxed/simple;
	bh=75S509FT66Gj0MVrnzAYE2eVm6LETWG9IDZLRfJb+gM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Mu2AMH+d6BC2nj7troXhS1DifH/7+UuNDDm0O/pNPl0mnSLrO62n1wO/orQ5a3m/a7Idm6pnzApr7FQ5rnw3xZMr5uORADHqEvULZNL6zxWT2Dps+tpt365PgxQPCHKgx5K/xCH57j6uWu0t8RaWcWMixc2aAnwi7VE/+i/mxyk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3FE513858C35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=EQfBd7XB
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0A18C45C30
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:36:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=zUul+WT+nCrPmpZ3fIcu1DMaS0c=; b=EQfBd
	7XB42jRudpFBo4w4oZgisymazn6zJ4ey3Rg/hE/Rs2sWyoT8UhPywtLuoR6H5mvf
	zm+BjcLC2IWeL/VpMZDjd7n1Kq1w7VBLFfhpkw+IWhd0YU/sNyG9yvCyh0GT/CXh
	VqY0OFO0H+GgkdZy0hgZHGKGNPvCA4yoBxIpWE=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id CFCE045BF6
	for <cygwin-patches@cygwin.com>; Tue, 18 Feb 2025 16:36:31 -0500 (EST)
Date: Tue, 18 Feb 2025 13:36:31 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
In-Reply-To: <Z7T5qE7rp3WpZH4D@calimero.vinschen.de>
Message-ID: <28f826f8-e78f-4329-f031-08c78eb5c40a@jdrake.com>
References: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com> <Z7TsohGAWwR9nOhX@calimero.vinschen.de> <e2c71487-2b97-e74d-0683-962f41decab6@jdrake.com> <Z7T4-niDlDcaaf9E@calimero.vinschen.de> <Z7T5qE7rp3WpZH4D@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 18 Feb 2025, Corinna Vinschen wrote:

> Alternatively... calling the constructor with a parameter
> `bool with_floppies'?

I can buy that.  I'll wait for your review of the patch I just sent before
sending a patch on top of that to implement this.
