Return-Path: <SRS0=UmZJ=UB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E2BA73858D35
	for <cygwin-patches@cygwin.com>; Thu,  9 Jan 2025 02:05:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E2BA73858D35
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E2BA73858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736388355; cv=none;
	b=WjxxAZ/0eVIYyweBlLjhXtg82BLr3CA/zEW8HfDM48vsfOT6cO0WVMkzQLDm56DCZq0/FWDpFgjbmUWvneHREXrJFNsnbjmDX7P7Sq/bng9QD5Jy5w0inrxj26kSLAAR4SuTc/ZPt1fgUNvD54+gAUdxlMkWngL4ei0RRkAtIBk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736388355; c=relaxed/simple;
	bh=nSB4e+09ReO/IziWEtR0vzjz7y1xDXQa44lHArWJAUY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=oA71X7jw8IquwqGyu6BDzVNL8aeHMYzTCwgQEza1ukreDVsOWweWRnau6IyDPUgYG4ZIO9Qat1SAzWAsYUtErM3q9wD2zo9h0Dw+XmC5HC104g8t4zLH+E1ZPozMWFt68Mzh64GKYf2oa/Sp1zBRViGf+egwi7O2JFWbmkQ8qV8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E2BA73858D35
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=uuIv8InO
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3BDC645A49;
	Wed,  8 Jan 2025 21:05:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=TTFtpRKGSyLdiOl1oHoemcQ+dVY=; b=uuIv8
	InOxd0RIOJIlvoc/eVcN1RIGieeJvERmZBH5mC5GB7+6EbXWlsm/HLuTEY5/1kzu
	EncGJ4DDYQnt5zvLTTo3qTTar5Cb0c+Mnzw8prjBMcMyDFi2wTWrJsVF6sWgj1lV
	x0zFRVUP8yDl+vXv1bhRWNr5/XARNDKv5uostM=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 06F5245A25;
	Wed,  8 Jan 2025 21:05:54 -0500 (EST)
Date: Wed, 8 Jan 2025 18:05:53 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Do not handle signal when __SIGFLUSHFAST
 is sent
In-Reply-To: <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
Message-ID: <7aac0c64-e504-f26e-165e-cd1c0ed24d6c@jdrake.com>
References: <20241223013332.1269-1-takashi.yano@nifty.ne.jp> <Z36eWXU8Q__9fUhr@calimero.vinschen.de> <20250109105827.5cef1a8c1b27b13ab73746eb@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 9 Jan 2025, Takashi Yano wrote:

> On Wed, 8 Jan 2025 16:48:41 +0100
> Corinna Vinschen wrote:
> > Does this patch fix Bruno's bash issue as well?
>
> I'm not sure because it is not reproducible as he said.
> I also could not reproduce that.
>
> However, at least this fixes the issue that Jeremy encountered:
> https://cygwin.com/pipermail/cygwin/2024-December/256977.html
>
> But, even with this patch, Jeremy reported another hang issue
> that also is not reproducible:
> https://cygwin.com/pipermail/cygwin/2024-December/256987.html

Yes, this patch helped the hangs I was seeing on Windows on ARM64.
However, there is still some hang issue in 3.5.5 (which occurs on
native x86_64) that is not there in 3.5.4.  Git for Windows' test suite
seems to be somewhat reliable at triggering this, but it's hardly a
minimal test case ;).

Because of this issue, MSYS2 has been keeping 3.5.5 in its 'staging' state
(rather than deploying it to normal users), and Git for Windows rolled
back to 3.5.4 before the release of the latest Git RC.
