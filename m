Return-Path: <SRS0=WwA8=SJ=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 1D1633858CD9
	for <cygwin-patches@cygwin.com>; Thu, 14 Nov 2024 00:28:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D1633858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D1633858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731544136; cv=none;
	b=YGbLSwDrWpQLiKqjHJ3p9JFKytvxfg9Ot9wALs2TC2FA9z9evcu9A4fcl5cqUP1bYQLjhmeLEUtpsO11Rad1rZiuIXI385l8xH8ViDiCWTneoThCPuQ7RdGtaMAIutkVo+r6CFwajCWpNn/dgzBhKGd8c+b75Ikh+eQ/5EF2uPE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731544136; c=relaxed/simple;
	bh=iByFHzbrawSOe9mGPWRZDwmpzVRzotw9QaT+WqIIrk4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=XeACHXNlCd9FUt8845kDvaFCQESW7rnYHsvfpFAJHN24AJ01uxfiJSouv+foU3VWuFyuwDmMJt9emeyca72uETLKUIRzcaPRYO7KsNhvT3ocCdXccCUcXladrJy5zvjnEJKR8l2xHSc1rBF8/9pKfiHFYoU5+YgBkdAfGs6osYQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D1633858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=YM+z3Uft
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A7D6D45C2E
	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2024 19:28:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=VSnwqjKrfQXYCotGzVDM74YbWFo=; b=YM+z3
	UftcP+n69beaZsiXNWlp1tyJRDxp2GGVrKQ1fFtWMIU0Ank3WeGnLrXc3esZwVoG
	0tkcgcJdH2LZPCHDhd5DQTQnzcEkmG1AVsyeAfa8n80ANLr2566t7yDpmaNn0S3b
	2Y2w2tgFX2gtRoVHeNkhEpiTkyJFek+WF1Wue8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 6B7CF45C1D
	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2024 19:28:55 -0500 (EST)
Date: Wed, 13 Nov 2024 16:28:55 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygthread: suspend thread before terminating.
In-Reply-To: <2c68d6fe-5493-b7e0-6335-de5a68d3cd3f@jdrake.com>
Message-ID: <dc6bdc6f-a706-c45a-b27e-c1c96ccf9b3c@jdrake.com>
References: <2c68d6fe-5493-b7e0-6335-de5a68d3cd3f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 12 Nov 2024, Jeremy Drake via Cygwin-patches wrote:

> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 81b6c31695..360bdac232 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -410,7 +410,8 @@ proc_terminate ()
>  	  if (!have_execed || !have_execed_cygwin)
>  	    chld_procs[i]->ppid = 1;
>  	  if (chld_procs[i].wait_thread)
> -	    chld_procs[i].wait_thread->terminate_thread ();
> +	    if (!CancelSynchronousIo (chld_procs[i].wait_thread->thread_handle ()))
> +	      chld_procs[i].wait_thread->terminate_thread ();
>  	  /* Release memory associated with this process unless it is 'myself'.
>  	     'myself' is only in the chld_procs table when we've execed.  We
>  	     reach here when the next process has finished initializing but we
>

It turns out that in some cases (that I never saw when testing on ARM64
but apparently happen on native x86_64) the CancelSynchronousIo results in
the ReadFile in proc_waiter returning ERROR_OPERATION_ABORTED, which is
logged to the console.  I'll be submitting a v2 of this patch with that
handled (the behavor is otherwise fine, just the output is spurious since
that error is expected now) once I get confirmation that it's working.
