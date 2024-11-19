Return-Path: <SRS0=tabE=SO=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 7B8663858D34
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 21:58:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7B8663858D34
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7B8663858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732053525; cv=none;
	b=eaZeXV7QDdhsPLpusf8YzEX7XfHCybves9iK0vAi25qePki4Srpfsieq3oAEbWxaHzn+VlwnAK2GdUE2jRDxSghiLSDp94FrSkYahf7QjuaKYMiAaiqT8er6fvX+VBakpaex43Uqla61zGOedy32bhGmik6XTVT8iYmtxGXuAL8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732053525; c=relaxed/simple;
	bh=ruyehxllcpC+Gf3jN2l9aHL3cmG7ng8JOiSXyaacXsA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WLLBzBnbMr2KlXXlvY4uzdiiKXzUu4qlATrDxal4V5Ma4pv7uwtQG9AZn10YlZ+qCBSWwYGU19QTzyQw7xugnvnBz0Hi1NMprJrPQ5tUnRiSSwUF1eQRabtDLCynIcfnZ1Ro2ljM+PSpM4KBGOVpEyCRsYMUpA5pPp5xMV6UlIM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B8663858D34
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=KEUN2mko
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A38ED45C75
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 16:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=mAJ3xDcBu1Q+54tPjXc9XoO9TBE=; b=KEUN2
	mkox2nwlmMHfKIAQhEQVDOQTyCWbiflvh5V+yBr9WXWLTrCRpXHuuYN4BlOX5tNB
	BtK8a/jR7+a8HgIeN7fb4EX2u/sP6PZ0PrhrfmLjKmrBq7BoO057Uf2EPXdRIpoS
	r3GWqiPhYaMIYcbvWaQPHfRK0hi1afdnOXdBAI=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 74EF545C73
	for <cygwin-patches@cygwin.com>; Tue, 19 Nov 2024 16:58:44 -0500 (EST)
Date: Tue, 19 Nov 2024 13:58:42 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
In-Reply-To: <Zz0ER77IqtBDV_EU@calimero.vinschen.de>
Message-ID: <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com>
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com> <Zz0ER77IqtBDV_EU@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 19 Nov 2024, Corinna Vinschen wrote:

> On Nov 19 11:06, Jeremy Drake via Cygwin-patches wrote:
> > (I searched for other callers of terminate_thread after this, and the only
> > one left without CancelSynchronousIo is in ldap.cc and I'm pretty sure
> > that's a "can't happen" case.)
>
> I'm inclined to push your patch, but I'm not quite sure here...
>
> Yes, terminate_thread called from ldap.cc is an unlikely last resort kind
> of thing.  And there are more places calling terminate_thread().  But none
> of them are terminating the wait_thread, so they shouldn't matter in this
> scenario.  I think?

I grepped in winsup/cygwin for TerminateThread (which only showed up in
cygthread.cc) and terminate_thread, which shows up in cygthread.cc (where
it's implemented), flock.cc (where I saw the CancelSynchronousIo trick in
the first place), ldap.cc, and sigproc.cc (which is patched here).

I have not seen a hang in places other than at (or near) the termination
of the wait_thread in proc_terminate.  That doesn't mean there aren't any,
it is incredibly difficult to get a debugger to tell you where things are
hung up.  The reason that I think this wait_thread scenario was
problematic (and the reason that I'm not concerned about the couple of
times I saw it hung "near" the TerminateThread call rather than at it) is
that the lock in question was described as being a "code cache lock", and
this double-fork scenario results in the process exiting almost
immediately after being started.  The emulator is still translating and
caching code both for the thread and for the process as a whole, so the
wait_thread is holding the lock when it's terminated, and the main thread
needs to acquire the lock to continue translating the rest of Cygwin's
process shutdown code.

> Assuming they do matter, CancelSynchronousIo() only makes sense
> if the thread hangs in synchronous IO.  Other internal threads use WFMO,
> and I don't see that you can avoid a TerminateThread in these cases.
> But those are covered by the neat SuspendThread/GetThreadContext trick,
> right?

Yes, the SuspendThread/GetThreadConext trick makes sure the thread is out
of emulation before terminating it.  The CancelSyncronousIo was something
I tried before learning that.  It helped but was not sufficient because
the thread may not have been in ReadFile at the time, so the thread still
needed to be terminated in some cases.  I included it in this patch
because TerminateThread is documented as being unsafe, so any effort to
avoid using it would be an improvement.

For threads that are in WFMO, what I do in my own code is include a
'shutdown' event that code that wants the thread to shut down can set and
then wait on the thread object to know when it's done shutting down.

