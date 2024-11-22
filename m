Return-Path: <SRS0=UNdZ=SR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 0540A3856DCD
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 17:56:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0540A3856DCD
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0540A3856DCD
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732298176; cv=none;
	b=KtqX6HYxqQIKa51dJWJaWrUAVRU+G+YNE+zWMJsNFc9EI/+o+zFr7nVULdHxrUauleGjO8TPWivc9KPwj4aMlPDzCpZLoXnDhgp5E9X1yH3hf0kvD2dy/1EZQM5mM1D9XpaMX/xxK2IdvewJb1ZCuUWgUOR8IZlecYOpl5CkPCc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732298176; c=relaxed/simple;
	bh=mF9oR89rv41b/FATNc/qAov7MzQZJqvPVNG571sj/xI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=bQMhp+qNTc0WqcMpnxU66dbV4RNLqdY4zX94X7lv3W2QNQXX3WLhvXRXPF11QpLpy1KidyaAfXQrySytX8FU7ja38usOS7t68Kv5/vEAzS3UbFtRcroghJd0u/SOEC23/rLxJJdyu7rN2kCGXaP/aa3gJifjN9A6vz8QUMu/kI0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0540A3856DCD
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=bK4BBSRS
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A3F1445C37
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 12:56:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=LmqH8QUEx4netLdoq2f4TLSrQdo=; b=bK4BB
	SRSPOTtRsLPS+FWskPc3aupvHw1GNhliISiYK1VUz3dyf4SBfchnb45dS59Nx0eE
	mBEJgdQMfjUbU+G2V02xynoUP3Hwe0/QHa0H91mqIisx0CnK4NrV+kNpGJ1J1mPe
	JloA3cCu5utJHwMPM57HfyQJumF4ctDPHA6pXk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 6B30E45BE8
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 12:56:15 -0500 (EST)
Date: Fri, 22 Nov 2024 09:56:15 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
In-Reply-To: <Z0B-ue4nNgCYZDrw@calimero.vinschen.de>
Message-ID: <15927c29-7e55-f560-ac57-648cb087b452@jdrake.com>
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com> <Zz0ER77IqtBDV_EU@calimero.vinschen.de> <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com> <Zz2_Czrk_qzn2fu6@calimero.vinschen.de> <1ce32afc-94ee-af96-db30-26d5f02a07ef@jdrake.com>
 <765a746a-b5a1-cdab-242d-1ff3c5bd65ba@jdrake.com> <Z0B-ue4nNgCYZDrw@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 22 Nov 2024, Corinna Vinschen wrote:

> > wait_thread is happily waiting in ReadFile, while the main thread is
> > hanging in ForceCloseHandle1 (close_h, rd_proc_pipe);.
>
> ....which is one of the great annoyances of Windows.  CloseHandle
> on a pipe should never hang, but... well...

Yeah, I thought TerminateThread should never hang either, but I was proved
wrong by emulation :P

> > The pinfo::release
> > call is after the wait thread should have been terminated, so it's
> > apparent the CancelSynchronousIo didn't work for whatever reason (possibly
> > due to canceling some other sychronous IO,
>
> How would that be possible? A thread can only run a single synchronous
> IO at the time, isn't it?

I thought something in the rest of the logic in the thread might be doing
a synchronous IO.  I dug through and found a WriteFile somewhere, but I
didn't follow the code logic to prove that that happens in the particular
cases in this thread.

> Rather than calling CancelSynchronousIo(), what about sending a
> signal to proc_waiter() via alert_parent(0)?

How would that work?  Wouldn't that have to be done in the child?

> On second thought, the current behaviour after getting an
> ERROR_OPERATION_ABORTED error doesn't look right either.
>
> Rather than entering the error case, it should be exempt from
> being handled as error, just as ERROR_BROKEN_PIPE.  Otherwise
> it never runs the case 0 code in the following switch statement, but
> it should.  Even that change might already fix things...

I thought this was correct, because in the case where CancelSynchronousIo
was added the thread otherwise would have been terminated.  Therefore it
should exit ASAP, do not pass go, etc.

> Either way, this looks like yet another synchronization problem:
>
> You can't be sure that ReadFile() actually exited after calling
> CancelSynchronousIo().
>
> And you can't be sure that proc_waiter() was really in the ReadFile call
> when you call CancelSynchronousIo().  proc_waiter() could easily be in
> the followup code and only enter ReadFile() after your
> CancelSynchronousIo() call.
>
> All in all, it looks like calling alert_parent(0) might be the better
> approach, but ultimately, I still don't see a way around
> terminate_thread().

I will submit a patch reverting the CancelSynchronousIo changes, since
they were not necessary for the ARM64 fix, and were just an attempt to
avoid the necessity of using TerminateThread.
