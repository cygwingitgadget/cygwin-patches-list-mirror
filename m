Return-Path: <SRS0=mUBA=ZC=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 10EE03846E7A
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 20:22:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10EE03846E7A
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10EE03846E7A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750364521; cv=none;
	b=FjaQpoW0MwMaH3QmKqcXtP4SVuhI47l4LFzySON0b2DHROBg9GG3kznK5BgVoEpCSLkYWKoaR3kLm1Cxr/pYXl2AuWcP1K6SdN3qRUmbLkksYmVPxa0CI3UgANi6ZYjmXwIXFv1gYIW1Om+0T4ZPt8XABprQ3pGbYj4Jw0er0EQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750364521; c=relaxed/simple;
	bh=ybNbnNWQT1sa1MUkFYiarCLwVN6gW+sCWX4+OC4dq5E=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hDzQBHgtpLRgUqHqvGj0tLAdJrQasU2tHey7vAJFqBC4A5EiyzgMd2YpBNdywvTDdF15TBS06DDZC/Ar093uGSvil/exh+25+PUAnRGP908968tdtYTCaroR4xeMDC1sqKkQncB8EjgaOjzLzIn42V4qxYcGfETgbdL/+vjOu/k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10EE03846E7A
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=s/SLh7R5
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B2EBB45D0C;
	Thu, 19 Jun 2025 16:22:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=qwuQHFqFCmLKe5Jf43Dha2+FSCI=; b=s/SLh
	7R5nOuiBkw9EbYcpi9erLMqjE+OuzAvF83GODzdFpGuyAB44ZO0B0oNozyTScZJj
	6UczCXkMEJel/V7TrmoLJJjiBO3Ibzpbl/Llh9rMwNahF2KtFk4E8ulThTwka5R1
	Ty+Bhz2F3ZsyONzTKc2G5Gt61QWZLNcW6Fh+YY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 98D3045D0B;
	Thu, 19 Jun 2025 16:22:00 -0400 (EDT)
Date: Thu, 19 Jun 2025 13:22:00 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH V2] Cygwin: Aarch64: Add inline assembly pthread
 wrapper
In-Reply-To: <MA0P287MB30826BECED54F4DFB50996C89F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Message-ID: <e898c913-6728-8c0a-3f06-4481c1551853@jdrake.com>
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM> <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>  <MA0P287MB30826BECED54F4DFB50996C89F7DA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 19 Jun 2025, Thirumalai Nagalingam wrote:

> Hi,
>
> Thanks for the feedback.
> As per your request, I've included the updated patch v2 both inline below and as an attachment for easier review.
>
> Q1 - 32-byte shadow area on AArch64
> You're correct - unlike x64 Windows, the AArch64 (ARM64) calling convention does not mandate a 32-byte shadow space. In my original patch, I included it to maintain parity with x64 behaviour. I re-tested without it and Cygwin `pthread` tests pass on ARM64.
> So, in this version, I've removed the shadow space allocation to better align with standard AArch64 conventions.
>
> Q2 - `mov x0, sp` to `mov x0, [x19, #16]`
> You're right again. For the `VirtualFree` call, `x0` should point to the original OS-provided stack (`stackaddr`), not the current `sp`.
> I've corrected it as suggested. Thanks again for catching that.

I caught myself after sending that message, and figured that it should
actually be ldr rather than mov.  Now I'm curious and will have to examine
the aarch64 docs and assembler output to see what 'mov' would do in that
case vs ldr. :)

Also, probably not important as far as saving a few cycles, but maybe it
could be

+	   ldp     x0, x10, [x19, #16]               // x0 = wrapper_arg.stackaddr\n\
+	                                             // x10 = wrapper_arg.stackbase \n\


In addition, please include a Signed-off-by trailer in the commit message.
