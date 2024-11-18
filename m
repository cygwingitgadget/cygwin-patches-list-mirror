Return-Path: <SRS0=0qDT=SN=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id A46A53858CD9
	for <cygwin-patches@cygwin.com>; Mon, 18 Nov 2024 18:10:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A46A53858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A46A53858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731953442; cv=none;
	b=sk1/75bqW00oK5yZcV6bCwunxVBxBuhZwsnI8m0u0u+duA4OPF5LeZwzM2/3AC6AyAbJBN6EdB93+0ZA8WW9L+4s4z+R8g6ek2ZhEtK51eHuFPcc9YYUPrc80j7ncVrqWivSnwbuMXxCuJ7mycxEH2zDix67Tvu+p6EXqJPeueY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731953442; c=relaxed/simple;
	bh=nsWGYerl1733g5WgAfc9zPha6CN+hEzkUSDfQ8LW29Y=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HDu24zJRVkT/5/HUNRx0KQytuRR2Agxk+pDq+q45YSwQgzpGDGZ/dSNR5DzAyoEVzh+T83JlE6wK/SRSuvuigNpy/aD44TPDUM5TA8VF8unRnfYzYmXiwQKVVbhkRrzxoCLIWnWZ8/Yvvsw/k/6yQ3DsaRiuo8MDMcsR02G7XkY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A181345C59
	for <cygwin-patches@cygwin.com>; Mon, 18 Nov 2024 13:10:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=TJRwvIJhxm25uxaln3OPjUdZWVg=; b=dHAIV
	0OQvvu1cKIASn9REWzZhh4jMa0shOAHzHdCn72o6aVxXIf63taevDLfS9T+BKpEn
	jrFeELCGPw0Tf1nyCXDvRBQmdzWhlxYW2MXS/r2QvfpRZQyLiifDxHKSUJqJ7hUj
	V7I8PDhTv1WuG/7AgVBeAOtw0pYPTTIJzbkkeg=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9AC3245C56
	for <cygwin-patches@cygwin.com>; Mon, 18 Nov 2024 13:10:41 -0500 (EST)
Date: Mon, 18 Nov 2024 10:10:41 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygthread: suspend thread before terminating.
In-Reply-To: <ZztRRVIiOBcJtnzZ@calimero.vinschen.de>
Message-ID: <08896610-b789-4b1c-645f-79dfb354ad74@jdrake.com>
References: <ac88704b-3f63-1f14-3412-4acce012f729@jdrake.com> <ZztRRVIiOBcJtnzZ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 18 Nov 2024, Corinna Vinschen wrote:

> Neat, but if this only affects the ARM64 emulation, shouldn't this only
> be called under wincap.cpu_arch() == PROCESSOR_ARCHITECTURE_AMD64?

Wouldn't this always be true though?  (Except that I backported this to
3.3.6 for i686 support, where I'd have to check for that possibility as
well).  Is this just to avoid the code when a native ARM64 Cygwin appears?

I have been sort of considering if the results from IsWow64Process2 should
be cached in wincap, then we could check that here if we are running on
ARM64 under emulation, and also used the cached value in the check around
FAST_CWD.  In addition, I was thining it might make sense to include this
info in `uname -s` like -WOW64 used to be when i686 was supported.

> A one-line comment explain why ERROR_OPERATION_ABORTED is exempt from
> the debug message might be helpful here.

OK (if I can limit myself to one line ;))

> > -	    chld_procs[i].wait_thread->terminate_thread ();
> > +	    if (!CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))
>
> This expression should be bracketed.  But actually, can you just change
> this to
>
>    if (chld_procs[i].wait_thread
>        && CancelSynchronousIo())
> please?  And another comment might be helpful here, too.

OK
