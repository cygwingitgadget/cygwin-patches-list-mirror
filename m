Return-Path: <SRS0=8XWn=ZA=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 4674A38EBAC3
	for <cygwin-patches@cygwin.com>; Tue, 17 Jun 2025 17:13:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4674A38EBAC3
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4674A38EBAC3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750180424; cv=none;
	b=J3NJpGEHm+4+0TcY7eSMnVLf5MR2G/BazdHm5dpPyOB9BtOVTlAP2p5Oodqedmw/vHZKD0VdIQ8kkop/zDGLL+JnH2UOkvHVk9468h1AMK9PdQDFaH4Bsdp4gzbqK5nlIvxx59YvuhypEYmTZJMQgHjIW+s7DSO1oFoYQ/zfj0k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750180424; c=relaxed/simple;
	bh=BAvrTIBM/hZoimERyq4LH97Zl5Exug2F45qml8aQygg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=S0QkOPcLP/EbaPgsJo9x/ve4Z6ZVnfbxcjPBQClZKBHQZ0fxCIscNHkb1sRYHE0Y5Pfps7JIAUbhEPjg8WXoeNBWUjkcqeOjjMNpRY9DJiXzBRPrKttzDHTMOsxuud3IiQqRDN90KRjf54dtwx6T4Nd8G82dfLRSb9NhvUCM1wU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4674A38EBAC3
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=xnLVPKU3
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2208F45D53;
	Tue, 17 Jun 2025 13:13:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=LIluGLKhQJa+t0wXbx6LsixXnOI=; b=xnLVP
	KU3k2HJ9/U9jUCoIyXzHEa2Vcl8b+DQirSm1zKdXzTDPZKRN1GHHiyzasJ0Cmfp8
	Mn55QUiOK8k7DvGMHfzPLu5Cn4nr4He2DAJUDPsD9ngRWHkJXWwQ5cCTDVPJghK4
	Sud2ftPSbAU9toANJ7hPiDx04LbbcJ0JtDH3as=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1D2CC45D51;
	Tue, 17 Jun 2025 13:13:44 -0400 (EDT)
Date: Tue, 17 Jun 2025 10:13:44 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
cc: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
In-Reply-To: <aFE7P8wupyJiuPXC@calimero.vinschen.de>
Message-ID: <38046017-a754-40e6-9e34-0b43c958eb67@jdrake.com>
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM> <aFE7P8wupyJiuPXC@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 17 Jun 2025, Corinna Vinschen wrote:

>
> @Thirumalai, your patch looks good, but I have only marginal knowledge
> of AArch64 assembler, so I would be grateful to get input from somebody
> having more insight.
>
> @Jeremy, can you please help review Aarch64 patches especially if they
> contain assembler code?

I can try, but I'm not as familiar with aarch64 assembly as I am with x86
(especially when it comes to calling conventions, which this patch is
involved with).
