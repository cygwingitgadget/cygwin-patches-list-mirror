Return-Path: <SRS0=bpPz=XT=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 687A23858428
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 15:31:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 687A23858428
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 687A23858428
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746286290; cv=none;
	b=YawqhfrkbKrEmvbL9Z0buzqTkGDPgyEVJqNGkVcs3MnlCwFksf/JLkFYk+khvjD3tMW3cKmhBsgxM2lT7Xcj0CWccO5It5wO0RxBit2cXWzeeB2Qr0QyegqWuBOHQIlP2z4EEhVBy3nehu2dvfdeXhkAiqPymNZiszH8ChSGBXo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746286290; c=relaxed/simple;
	bh=u2OED2EhVqrS0nn1fr1aKa0UQvq0oUZRvo6TCMSOefA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=m0goOsTy0a9vMaHcdbr+Q/LeFLoL/XCcf6KbHA73AlKNRwYfiojYRMQBoctpPqEGvZ1PQjdEmIBz6+HBLuD51H8wzeYUs5uLY6Id6HU+Od6odNDTNurBiFRuwV8rJfI3B4SWhcT8AGXHGxXH9sOswKQNz1O2QKyqD/bExLrBOQc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 687A23858428
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ZxUZGzFX
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id C68C245C8C;
	Sat, 03 May 2025 11:31:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Hn6DYRUY1L1/zRw9i65QB+gfRfg=; b=ZxUZG
	zFXd/KGAyw2kqY610Y1j5b4VJq1s5+0v2QjkdXB0JexNSMSbsk0E5flWe+DljkSv
	cNO/HAq4G9Nnon/rpHH3jQLLbnTN5uw1i9jJEX2JSKXWxAY4tuYBsElcf1xg32yl
	23qD8sr12QuCIGoMpdtGImENOpr9ZO8ufrdCok=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id AEC9A45C8A;
	Sat, 03 May 2025 11:31:29 -0400 (EDT)
Date: Sat, 3 May 2025 08:31:29 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: docs: flesh out docs for cygwin_conv_path.
In-Reply-To: <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk>
Message-ID: <c0eedde1-50b2-7a4c-ab3b-2747ed91a4b8@jdrake.com>
References: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com> <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 3 May 2025, Jon Turney wrote:

> On 01/05/2025 20:28, Jeremy Drake via Cygwin-patches wrote:
> > Explicitly specify that `from` and `to` are NUL-terminated strings, that
> > NULL is permitted in `to` when `size` is 0, and that `to` is not
> > written to in the event of an error (unless it was a fault while writing
> > to `to`).
>
> That's great, thanks.
>
> Please apply.
>

Done.  I'm not sure if I should apply to the cygwin-3_6-branch too though.
It is just a doc update...
