Return-Path: <SRS0=AZ9L=SP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 71A17385841E
	for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 18:46:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 71A17385841E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 71A17385841E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732128419; cv=none;
	b=chLRy33PqLwhgPPSOmY9jWrUI1GDiLJuQPljOJCHdMeecV3eLSXuf6Tb0eoC2NnhWcKcWb5T9bwG1wNetx8PrJa8vEsDefKmJhNjoDwmPLgNs1m3MmDz3mY+XqKYuLbNBQpX+i+C5QpdTxqEOnaL7laQfofhD3WIXda+sBg5/bQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732128419; c=relaxed/simple;
	bh=FnnVMu44GK3sJgSULjb9+TIp3i00j39SUJmxNlI/5AE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=BEyaQFdXIncA2/z1KTNFSeMfBSF7vbCLNtYutBsIweTG2nKsjboO1Qe+bTO9fs1vlX3sgYxpeFkPKRXmSExG3Of8SHO4FcASMv+KFdZ1hFUQ2McT0fh36EKnMEvlwZzedEcZAxH0O7/SfVd06QYNANw3flczR6AJAt6n7nyZiRQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 71A17385841E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=j5GUGMb6
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0A7F845C85
	for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 13:46:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=IrSmdIbWEqR7MddVRjfg+dEuYFo=; b=j5GUG
	Mb6Ov7nJ7bBzpmWrlhq+fU696DhjAJjimmpVHY/Vp2Fr3uKmK/pLeHwgQx+muL9O
	Ru5aq/WrmkAP559Jq0W/C9bxzptxg59nBiLCAmwnxOkCsk5fpi330GK+SfKr6pm/
	/YYKda5B5CLfd8B0L3ylYM6vuQRG1/oQXjMknI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 0268045C83
	for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 13:46:59 -0500 (EST)
Date: Wed, 20 Nov 2024 10:46:58 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
In-Reply-To: <Zz2_Czrk_qzn2fu6@calimero.vinschen.de>
Message-ID: <1ce32afc-94ee-af96-db30-26d5f02a07ef@jdrake.com>
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com> <Zz0ER77IqtBDV_EU@calimero.vinschen.de> <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com> <Zz2_Czrk_qzn2fu6@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 20 Nov 2024, Corinna Vinschen wrote:

> Patch pushed.

Thanks, folks on ARM64 will be very happy to see that deadlock gone.
MSYS2 already made a release based on v2 of the patch, and Git for Windows
at least merged that version of the patch too, and is looking forward to
making a release with it.
