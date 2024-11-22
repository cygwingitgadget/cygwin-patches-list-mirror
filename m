Return-Path: <SRS0=UNdZ=SR=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2538C3857C6E
	for <cygwin-patches@cygwin.com>; Fri, 22 Nov 2024 01:20:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2538C3857C6E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2538C3857C6E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732238433; cv=none;
	b=bP9bDgyuEf8NpOHq3FjOKe7WjgK8lrmd6Rs8qlc2Ru4mvDA2Ulig4NQBjIOQptjZpwwLEDiySU6yRJz8LcNTYkiO9IphYgEaghnru76SX31oOTd2ASAleEoJXXlzLMHKoHc9IpGOrLReWH+f6Jr0isW6DRMu74B7TcetQeYikjU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732238433; c=relaxed/simple;
	bh=1hRB7utgCOjjG23RVbAo73DL6XVxG2FDF5LZuaHWaUQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HtRWiNixL63qbZr0Fn7Wg0I2kASGrx1nwJZzPT37c6EDZrZviZ9YAnOIEncXQaPClyurSUDjH99/9pxFfPT+wq1GNAaRZ470WKNXWjuZIsU1NC0FueVfG3GaRgK6F1KYvzfTTbFj9bxvQlQJaWYnbnu1hpdh1Kezc2SqH+qrJGU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2538C3857C6E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=S3f2PGdS
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A833545BF6
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 20:20:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=sH5aX/OGE0Mo/J1fd4dh0EvLVNY=; b=S3f2P
	GdSAGQsQDKD5JwUBsHKmC/3hYXJIXsqEdSi64+/0ezx1dQ0eB7jppXy9VbGDNgmc
	xLVKTATa4XiyR1nKO0g5jpiRB0xxJauKto0K29drB/rrUYK6kmffV1RqP0pURHX0
	UpGnHcg12x/deIAzwvigAAh9yBDEhTHHpnzz6k=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id A2B1645BE8
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 20:20:32 -0500 (EST)
Date: Thu, 21 Nov 2024 17:20:32 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] cygthread: suspend thread before terminating.
In-Reply-To: <1ce32afc-94ee-af96-db30-26d5f02a07ef@jdrake.com>
Message-ID: <765a746a-b5a1-cdab-242d-1ff3c5bd65ba@jdrake.com>
References: <45e536e2-e894-2548-e9d0-5937ff96b0b5@jdrake.com> <Zz0ER77IqtBDV_EU@calimero.vinschen.de> <4e2cbe74-2d1c-f8df-a457-57c0239844c1@jdrake.com> <Zz2_Czrk_qzn2fu6@calimero.vinschen.de> <1ce32afc-94ee-af96-db30-26d5f02a07ef@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 20 Nov 2024, Jeremy Drake via Cygwin-patches wrote:

> On Wed, 20 Nov 2024, Corinna Vinschen wrote:
>
> > Patch pushed.
>
> Thanks, folks on ARM64 will be very happy to see that deadlock gone.
> MSYS2 already made a release based on v2 of the patch, and Git for Windows
> at least merged that version of the patch too, and is looking forward to
> making a release with it.

Uh oh, MSYS2 is getting some reports of deadlock/hangs in similar
scenarios on native x86_64 now.  See starting at
https://github.com/msys2/MSYS2-packages/issues/4340#issuecomment-2491401847
if you're interested.

I was able to reproduce, debug, and found the following:

wait_thread is happily waiting in ReadFile, while the main thread is
hanging in ForceCloseHandle1 (close_h, rd_proc_pipe);. The pinfo::release
call is after the wait thread should have been terminated, so it's
apparent the CancelSynchronousIo didn't work for whatever reason (possibly
due to canceling some other sychronous IO, letting it come back around in
the loop and call ReadFile again.

Using gdb to call CancelSynchronousIo again resulted in the wait thread
exiting immediately.


Either we just revert the CancelSynchronousIo part of the patch (the
SuspendThread/GetThreadContext part is what actually solved the ARM64
deadlock), or possibly we can add a flag that the thread should be
shutting down, and check that in the for loop condition in the wait
thread.  Thoughts either way?
