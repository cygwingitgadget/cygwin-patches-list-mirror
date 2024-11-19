Return-Path: <SRS0=tabE=SO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 624CD3858D34
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 18:06:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 624CD3858D34
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 624CD3858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732039609; cv=none;
	b=ZURxH5SsQHw1tr9WAGgYeacNYgQEPtWBU/uLMV5eQzlwzGRen/hei9Larmi5J3kCX38NUYHMKOmVhKrYbvZ1lpjufsulM2YjPlRk6550QzHnch718I8UmuDs1Mi6Oi+zmq59L47jq1OGF0sgFVnz0Umk+IMtAaxU1WCKuDA9vQk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732039609; c=relaxed/simple;
	bh=8Qh9S/+5JTggOWc5dBmWOkRCkCKn5jpjIB4NSsHIYHw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=u/WWIbUMk0C/MlII8uU3BfMbQmD24Yx3kpq/P1yi1jxgm0lgGto6HxFtvTg65nQgXLBFi1gzEqjwzN2Aux8kFFAcK2hP81Mbv8t8XgZ295ghISR5WcPQE2G9mzF0iA1ibSVYG97spSpafZymPXEgdts7ypLDTZQJhRcd1LQ0PpA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 624CD3858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=L2crLANg
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 90E5245C75
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 13:06:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=BQ9luscKgvIn6W/2cT406TeW38M=; b=L2crL
	ANgB8Xkd1zjQOJ4mOG8uy7Dv1iFHsSWWEauc/nOpsrmIOoQXnPma3j4AHrWFK/sa
	jKuYMgN8+0x58t+L8RifTEpirJuKevPmIE+8Lh3L2gh2V3xiJv5TqL+PQR8dQy19
	g6I2XSg+T6Oyty7ZOofKTI3W73HiAP0UYGvNnY=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 62D1945C73
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 13:06:48 -0500 (EST)
Date: Tue, 19 Nov 2024 10:06:48 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygthread: suspend thread before terminating.
In-Reply-To: <ZzxeRTIcGPxqeJND@calimero.vinschen.de>
Message-ID: <7e6a2b0a-c549-b2e5-4835-75cd8d3c8366@jdrake.com>
References: <ac88704b-3f63-1f14-3412-4acce012f729@jdrake.com> <ZztRRVIiOBcJtnzZ@calimero.vinschen.de> <08896610-b789-4b1c-645f-79dfb354ad74@jdrake.com> <ZzxeRTIcGPxqeJND@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 19 Nov 2024, Corinna Vinschen wrote:

> On Nov 18 10:10, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 18 Nov 2024, Corinna Vinschen wrote:
> >
> > > Neat, but if this only affects the ARM64 emulation, shouldn't this only
> > > be called under wincap.cpu_arch() == PROCESSOR_ARCHITECTURE_AMD64?
> >
> > Wouldn't this always be true though?
>
> Copy/Paste and not thinking straight is doing that for me, sorry.
>
> The above was supposed to be PROCESSOR_ARCHITECTURE_ARM64, but this is
> obviously dumb either way.  What I *meant* was checking if we're running
> in an emulation vias GetNativeSystemInfo or IsWow64Process2.  We're
> using the latter in find_fast_cwd() already.

GetNativeSystemInfo also lies, following the Microsoft compatibility
theory of: make existing APIs lie, add a new API that gives the real
answer, repeat for new versions.  That's why we need to use
IsWow64Process2: that's the API that (currently) doesn't lie.

> > (Except that I backported this to
> > 3.3.6 for i686 support, where I'd have to check for that possibility as
> > well).
>
> Have I missed something?  I thought this only occurs in an
> AMD64-on-ARM64 environment. What is it used for on i686?

This also occurs on i686-on-ARM64, but since Cygwin no longer supports
i686 I didn't get into that here.  Actually, I was only able to get a
debugger to give me any info about where this thread was stuck on the
i686-on-ARM64 case.  In retrospect, this was presumably so hard to debug
for the same reason as this workaround works:
SuspendThread/GetThreadContext tries to get out of emulation before
returning, but the emulator is waiting on a lock that will never be
released because the thread that owned it was terminated.

> > > Is this just to avoid the code when a native ARM64 Cygwin appears?
>
> No, the idea was running the code only if we know we're being emulated
> on ARM64.  I just screwed up :}
>
> > I have been sort of considering if the results from IsWow64Process2 should
> > be cached in wincap, then we could check that here if we are running on
> > ARM64 under emulation, and also used the cached value in the check around
> > FAST_CWD.  In addition, I was thining it might make sense to include this
> > info in `uname -s` like -WOW64 used to be when i686 was supported.
>
> That might be a good idea in the long run and patches are welcome.
> Right now we have this isolated usage of IsWow64Process2 in find_fast_cwd().
> Given this function is called at least once in a process tree anyway,
> wincap would be a natural place to keep the info.
>
> And yeah, maybe we can just attach "-ARM64" to the -s info or something.

I'll save that for a future patch, and for now send v3 without an
additional check for architecture.
