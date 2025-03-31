Return-Path: <SRS0=ejch=WS=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A95FB385800F
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 02:45:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A95FB385800F
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A95FB385800F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743389129; cv=none;
	b=r7w6eCr3EmyID/VQOUhBQ/QjnwPWnuV9ubJF0qo4AZsCJSHgFcT4ARbl/0fVoSqFZQhcm1TCSZYu3IPiuxgTN8DrOADesf3LWvQ86ChtWYlID9qifnzgyRYuCjHh0x/TCNl6cBYFeuNTz0RQF3Tjxr+DAO7vtyrhrTVFkQtI54A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743389129; c=relaxed/simple;
	bh=6ZteBf5kpghETW7OVw5x3rg6l4uPMAVK6g/eSQuxVwg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=lBCb/JcIsq9Nn8scPi/sjz54yLTtQY7u6E8KeHQ12A3hkITh9ifSQ38anPmEyZJjFJiMajKgngTSjCJkbaOrMT2UcEwdbaDEfeLWpjJQKE0KhCY4YqhjncLxcDPYFHsjLWjZMpsvHkCH+GFE5h/P9VGXONL6LuBJvJM8Ae4dglY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A95FB385800F
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=xPsopncQ
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 4DFB445C86
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 22:45:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=g5f2RIqxUJO1LW1QlHB9frVaa1o=; b=xPsop
	ncQkWXJQEWl3pmE+rfHcWsfvfMsO1DQir6Z6uMOxzLC3NgEYP3hatj6ZNCfDV41B
	JjoYWgYdVnQda54YXkMbAsyD61mFQRIYc/c2Cr4wmOWU12uBtmqgyUy+9s6bbK1w
	R/XVUIAGjxwCfYq0ac+7Xsqgc23+I6X7WEpHQw=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 497E845C83
	for <cygwin-patches@cygwin.com>; Sun, 30 Mar 2025 22:45:29 -0400 (EDT)
Date: Sun, 30 Mar 2025 19:45:29 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
In-Reply-To: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
Message-ID: <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 29 Mar 2025, Jeremy Drake via Cygwin-patches wrote:

>     ++#if defined (__i386__)
>      +  static const BYTE thunk[] = "\x8b\xff\x55\x8b\xec\x5d\x90\xe9";
>     -+#elif defined(__x86_64__)
>     ++  static const BYTE thunk2[0];
>     ++#elif defined (__x86_64__)
>      +  /* see
>      +     https://learn.microsoft.com/en-us/windows/arm/arm64ec-abi#fast-forward-sequences */
>      +  static const BYTE thunk[] = "\x48\x8b\xc4\x48\x89\x58\x20\x55\x5d\xe9";
>     ++  /* on windows 11 22000 the thunk is different than documented on that page */
>     ++  static const BYTE thunk2[] = "\x48\x8b\xff\x55\x48\x8b\xec\x5d\x90\xe9";

I noticed that in 22000 the x86_64 "thunk" is the same as the i386 one had
been in every version I tested, except with the 0x48 "REX" prefix added
to two of the instructions.
I guess they found a different sequence had better compatibility with API
hooking software.

I just did some wandering on the internet and came across someone who
seems to confirm this:

http://www.emulators.com/docs/abc_arm64ec_explained.htm#FFS
> This sequence is not the original FFS we shipped in Windows 11 SV1
> (build 22000) back in 2021.  We had a simpler sequence but as it turned
> out this broke some video games because we used x64 instructions that
> their hotpatchers were not used to seeing.  After a constructive email
> exchange with the folks at Valve we zeroed in on this much more
> compatible code sequence.  Pro tip: This is why Windows 11 SV2 (build
> 22621) is the minimum version of Windows on ARM you should be using your
> ARM64 device.  If your device came with build 22000 or even Windows 10
> build 19041, or you are building using a Windows SDK prior to build
> 22621, upgrade it!
