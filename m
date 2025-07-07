Return-Path: <SRS0=hEVR=ZU=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E550F385AC1E
	for <cygwin-patches@cygwin.com>; Mon,  7 Jul 2025 21:43:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E550F385AC1E
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E550F385AC1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751924587; cv=none;
	b=bLaXDNNQ/Zf/Oz9wYSLhtK0xLDOSlJojEag+lUHMdFZKI9dPF8gfvZrLHuuNXkH6i3wfSHuZiCf6eN5AM7Jhs7+swabO3dXMUFc40HrOemva56al3oVeLHcsynjKSlSt8gtAW+EIyb8P7zieD4VCfv3EMePfUzl/ysHv/2vKyOg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751924587; c=relaxed/simple;
	bh=61weHnydRfel+fXdDXg+UyFaFzE3k9fTNj7OugBIoqM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=KWsbqWiMfx3GQPp71/o70CYxLWaFQ5hAj9Q6KSHbMXJo/MapzbIiauVI80NG1IZi8caH1QJoupDmeWwqglxc1Rk9Id/1mrqADR3UjkWntc4zYHmcVnLD3qT9Z27pNuNaYBFrjb5TpelPDKSILE9AXdADjxy8h396j063pyBDeoA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E550F385AC1E
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=Rujl4mZz
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id A0A8145C42
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 17:43:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=u2rQvwhYn6i0oa2P2vCJeGEXSDw=; b=Rujl4
	mZzlZBJpOMiS3lCw7RVwp+j1LG2tZV0LBXaJEY7qqQhFFojouQF1CqYPdjHSNf3T
	aOu2VN2w8+WOUnwTBo6SSVQ1UP/6GtTPUId43UmDF/YlKu834C/QQ6/e/xQ1Yr0o
	9CM/fMohaSDxZB7RY3Yi23fp5vUu2n00R5tWEc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 9BC5145A5F
	for <cygwin-patches@cygwin.com>; Mon, 07 Jul 2025 17:43:06 -0400 (EDT)
Date: Mon, 7 Jul 2025 14:43:06 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aGulX_0Azb6GI-_C@calimero.vinschen.de>
Message-ID: <104e960f-852b-cf0b-76c8-ec950e4cf564@jdrake.com>
References: <aGJl0crH02tjTIZs@calimero.vinschen.de> <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com> <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com> <aGaZq6sSSuNCKX59@calimero.vinschen.de>
 <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com> <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de> <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 7 Jul 2025, Corinna Vinschen wrote:

> On Jul  4 15:59, Jeremy Drake via Cygwin-patches wrote:
> > On Fri, 4 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 4 Jul 2025, Corinna Vinschen wrote:
> > > > I see what you mean.  The question of questions is if "as if" only
> > > > covers the "performed exactly once" requirement, or if the "as if"
> > > > really encompasses all three requirements, i.e.
> > > >
> > > > - as if the specified sequence of actions was performed exactly once
> > > >
> > > > - exactly in the context of the spawned process (prior to execution of the new
> > > >   process image)
> > > >
> > > > - exactly in the order in which the actions were added to the object
> > > >
> > > > in contrast to
> > > >
> > > > - as if the specified sequence of actions was performed exactly once
> > > >
> > > > - as if in the context of the spawned process (prior to execution of the new
> > > >   process image)
> > > >
> > > > - as if in the order in which the actions were added to the object
> > > >
> > > > My understanding (as a non-native speaker) is that "as if" only
> > > > covers the "performed exactly once" requirement.  Applying "as if"
> > > > to the order requirement doesn't make much sense to me.  And applying "as if"
> > > > implicitely to the second requirement, but not to the third, doesn't
> > > > make much sense to me either.
> > >
> > > The "as if" performed exactly once doesn't make a whole lot of sense to me
> > > either... To me, the only case where "as if" adds flexibility is the
> > > context of the child process.
> > >
> > > > On top of that you'd have the problem that the man pages of
> > > > osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
> > > > contradict each other.  This, of course, is always possible.  Only an
> > > > RFC to the Austin Group could clarify this.  Maybe we should really do
> > > > that.
>
> https://austingroupbugs.net/view.php?id=1935

I noticed a bit that you quoted that I hadn't noticed before
additionally, when the new process image is executed, any
  file descriptor (from this new set) which has its FD_CLOEXEC flag set
  shall be closed (see posix_spawn()).

The "from this new set" is not handled properly in my implementation, and
I'm pretty sure not from the existing newlib implementation: I copied what
it was doing, which was to clear the FD_SETFD flag after open.  That
would be wrong, if faced with an addopen with the O_CLOEXEC flag set.
This is obviously a stupid thing for a caller to do...
