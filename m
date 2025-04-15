Return-Path: <SRS0=C4lG=XB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 405C83858D29
	for <cygwin-patches@cygwin.com>; Tue, 15 Apr 2025 17:50:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 405C83858D29
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 405C83858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744739409; cv=none;
	b=JBPTpvQ3DAOKpR02u0yPNWmwDWbtj9GnUFvztNbq9+F79wFkTlCzhW8N++QKKRrQozUMQmokxQoNjVUw4ZICa/lOBLr+qxWsoiUaLJzyqdw7GppF2zJToAXGcr2APy3XuOAVSxQnEmQIRchmVFRsVAStKJk4B+yUHOS2eu/7NJI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744739409; c=relaxed/simple;
	bh=cxDTpiQkxHmTxZAZa9KIm4LqJNGpFMAsQr4N00lklW0=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=l1+/UmAG3ESdvPRLfeQOwrBjP/4lYkQGH6OwWw0WbcEqaMLVA/ixoEuAL6XWRR16X+L2SyeKPC+JEMkAcmnpQZdM1pZT+kmHyGlZOkc8wOQAzU+lhPmPe9NxFvj99cwRXi2j+cvbtfCLINZqyQR1i3b6jim2WS4fzkhQFcHiSqY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 405C83858D29
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=sYL03KGY
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id D9F8245C86;
	Tue, 15 Apr 2025 13:50:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=Juf1lwsPk29t7BFuuPenUMpLYk8=; b=sYL03
	KGYJ6hHkpHGbv4qlSMX6IGKz1Gf8Udtf0o1tYQL4+iW5cVGwCD8Ejyjv0fp2AdCz
	gAzsH2PKqrblfbTF2LN1BpXPc/4NhRgS5ZfPb+rG/eyF8ItAHShXBaK/ks3LhRp/
	rSOHEzkxGehm5Krk94A47iSzKranibw1mhRyLM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D6B8C45C82;
	Tue, 15 Apr 2025 13:50:08 -0400 (EDT)
Date: Tue, 15 Apr 2025 10:50:08 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Add stress-ng to CI
In-Reply-To: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
Message-ID: <ad15ee78-e913-de03-ea90-cddf5ecdb62d@jdrake.com>
References: <20250411130846.3355-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 11 Apr 2025, Jon Turney wrote:

>
> Jon Turney (4):
>   Cygwin: CI: Pass the just-built cygwin to a subsequent job
>   Cygwin: CI: Run stress-ng
>   Cygwin: CI: Make stress test terser
>   Cygwin: CI: Disable stress-ng clock test


FYI, as of 4/14, GitHub has *finally* put a Windows ARM64 runner in public
preview.  It might be nice to run some tests on that "windows-11-arm"
runner, in addition to "windows-latest".  I could prepare a patch but it
would likely conflict with this series, so I'd wait until this is pushed
or else leave it to you to add to this series.
