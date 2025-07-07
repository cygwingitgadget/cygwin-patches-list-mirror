Return-Path: <SRS0=hEVR=ZU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 15F523858D32
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 19:16:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 15F523858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 15F523858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751915809; cv=none;
	b=k4DQ3KpbYhUA7H+JL4kfKcouAAfzG1ZapIAm7lKXiNssROBme2umk9injlxXAoICxHtIwsih8DkVLopGrchn81WUfLCbY7xyZTEapakLClX1jwrme5YMReV+n/Cdc/8YgLBxmaRABqq+wWWC+GCAdPXo7o+7m6YtEaruc2thRXw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751915809; c=relaxed/simple;
	bh=7gTZU/lRvRb8p67xpTyd8lfNnv2o9ulQd7tJBLnastU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=RsJqgOzBLjF+gHjHuCy8m5cHkh03LM7/1mojtVbA8ra9XY2YxpIxdbqw59NbzL/TsZTldE9Ihpkx79F38Ik3MTkDu8ALmCo7SYC6YXjLLY2mi0oyW4f9HRBDQsiJPUWwAL3arb79T4zf7Sc70U2AKRapTNESnnaqflIm8YfJZQ8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 15F523858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Cq/sotgi
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id DCDF945C0C
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 15:16:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=2s4TUBRgn+EYrflBWaf6c83YgMw=; b=Cq/so
	tgiCegO2dsCE1DskZbqoeHtqQT/ALP/tySMv4LC3LoFYKz917sH4PQsfhlCPdjXM
	Hvfv3UeIkOk/Nhc4BMNX78MJXo8KSAv21J9wG6dTZF0P6oL6ZydkmkSS1ahulMkJ
	jmLvc3hlj5Wd8G6JNcm35yqZ96iwJ74ONqFDP4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id D650945A25
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 15:16:48 -0400 (EDT)
Date: Mon, 7 Jul 2025 12:16:48 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGulX_0Azb6GI-_C@calimero.vinschen.de>
Message-ID: <51a8dd9a-2cc4-39cd-d026-2b4b3920bfb1@jdrake.com>
References: <aGJl0crH02tjTIZs@calimero.vinschen.de> <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com> <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com> <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com> <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de> <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 7 Jul 2025, Corinna Vinschen wrote:

> https://austingroupbugs.net/view.php?id=1935
>
> > > I'm sorry if I'm sounding frustrated.  I am just trying to debate to find
> > > the best implementation.  I think that having two versions of processing
> > > the file actions is asking for inconsistencies and bugs.  As you point
> > > out, non-Cygwin processes are second-class citizens to Cygwin but are more
> > > important to MSYS2 and Git for Windows, so I can see bugs in the
> > > non-Cygwin case going undiscovered until after a Cygwin release, when
> > > MSYS2 and Git for Windows try to integrate it
>
> Maybe I'm just badly uninformed, but wouldn't it make sense to push out
> test builds of MSYS2 as well to avoid just that?

Yeah, before 3.6.0 was released I rebased msys2-runtime on top of it to
run the tests that MSYS2 and Git for Windows have.

> All good points.  We should actually see what the Austin Group comes up
> with and then we can reconsider.  In the meantime we stick to your current
> implementation.  Would you mind to push it on top of main into a new
> topic branch, i.e., something like
>
>   git checkout -b topic/posix_spawn main
>
> and push it?  If you're not aware of this, the "topic/" prefix is
> required to allow force pushing to the branch.  It's some kind of
> safety net from the gerrit macros activated for a couple of projects
> on sware.

Done.
https://www.cygwin.com/cgit/newlib-cygwin/log/?h=topic%2Fposix_spawn

This also includes the patch I recently sent, because I had done half of
that while adding pgroup support.
