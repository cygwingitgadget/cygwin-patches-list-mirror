Return-Path: <SRS0=sZqY=2F=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 848A4385B521
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 18:43:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 848A4385B521
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 848A4385B521
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753382632; cv=none;
	b=P4f9NJlBNN5bko9Iv9Iu0TKDLGdCU7dCp9s0g4T3kIM3p1sP6iHVZFvy39R/Tgc4B5wO5+aCqOggFptPo6pwS+jA8x/YDsiuftsLp5ZMJQGDACVemqRUA/lQ9m+TMS5JGq3d3aD3Sszw9cD/ge07QKaYUbT2sP/aMvBCVnDTv2s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753382632; c=relaxed/simple;
	bh=q4F4eWUhO3UKnJPQl6abIcKcFqWvSFORmiYXUq//wLM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=os8GNMoHkNZg3xkRRBEeQ8kyZrhXw2mIcTGMcSYJStvq4baszFhSFK0mg9yxZhFbFV5psDfM92Kaq+ENuR3JpxSqepMLq+0TxiotNgl8Q2j/aM1qu6uvSL/vbNPgX4dTqG1qK9XB0mAxTkRDsG34RVT3mAQO6he8HPphP/4U8u4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2671A45CD2
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 14:43:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=AusCLlZqLr6peQquvly8DeYlTSA=; b=ArBBL
	UXT/hksCsE9Ik18LtIdzpkjCuaPdIxvPTMbyidZ/d79GBK+4ifQ+wd2f0QAjOi9p
	XuguDffpmGdUT2ad6mpT/q1Zh71Q90md1uxHD9/RKy+KnwsPIGj8AuamVhqaJEKn
	LrsfxIb30XeuQYg0w1hwKSbk1DeaLkyt4fYZAk=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1F5B345CC6
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 14:43:52 -0400 (EDT)
Date: Thu, 24 Jul 2025 11:43:52 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
In-Reply-To: <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
Message-ID: <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com>
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com> <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com> <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de> <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com> <aGulX_0Azb6GI-_C@calimero.vinschen.de>
 <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 24 Jul 2025, Corinna Vinschen wrote:

> On Jul  7 12:45, Corinna Vinschen wrote:
> > On Jul  4 15:59, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 4 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > > > On Fri, 4 Jul 2025, Corinna Vinschen wrote:
> > > > > I see what you mean.  The question of questions is if "as if" only
> > > > > covers the "performed exactly once" requirement, or if the "as if"
> > > > > really encompasses all three requirements, i.e.
> > > > >
> > > > > - as if the specified sequence of actions was performed exactly once
> > > > >
> > > > > - exactly in the context of the spawned process (prior to execution of the new
> > > > >   process image)
> > > > >
> > > > > - exactly in the order in which the actions were added to the object
> > > > >
> > > > > in contrast to
> > > > >
> > > > > - as if the specified sequence of actions was performed exactly once
> > > > >
> > > > > - as if in the context of the spawned process (prior to execution of the new
> > > > >   process image)
> > > > >
> > > > > - as if in the order in which the actions were added to the object
> > > > >
> > > > > My understanding (as a non-native speaker) is that "as if" only
> > > > > covers the "performed exactly once" requirement.  Applying "as if"
> > > > > to the order requirement doesn't make much sense to me.  And applying "as if"
> > > > > implicitely to the second requirement, but not to the third, doesn't
> > > > > make much sense to me either.
> > > >
> > > > The "as if" performed exactly once doesn't make a whole lot of sense to me
> > > > either... To me, the only case where "as if" adds flexibility is the
> > > > context of the child process.
> > > >
> > > > > On top of that you'd have the problem that the man pages of
> > > > > osix_spawn_file_actions_addclose and posix_spawn_file_actions_addchdir
> > > > > contradict each other.  This, of course, is always possible.  Only an
> > > > > RFC to the Austin Group could clarify this.  Maybe we should really do
> > > > > that.
> >
> > https://austingroupbugs.net/view.php?id=1935
>
> Good news:
>
> https://www.austingroupbugs.net/view.php?id=1935#c7229
>
> I'm glad I asked.
>
> tl;dr: The Austin Group just changed all the descriptions in terms of
> posix_spawn_actions, so that they are to be performed *as if* they
> are running in the child preior to calling execve().
>
> This means, we're free to run alkl desired actions in the parent, as
> far as that makes sense.
>
> I still think it might make sense to run some of the actions in the
> context of the child's child_info_spawn::handle_spawn() processing,
> but we can restart discussing this as we go along.
>

Great!  I rebased the topic/posix_spawn branch yesterday to use a local
child_info_spawn instance, but otherwise haven't really been looking at it
lately (I decided to test packinging the release candidate of llvm 21 and
found a fun new bug that only shows up when binaries are stripped).

I'm trying to remember where things were at, and what I'm coming up with
was that I was going to revamp the struct with parameters to
child_info_spawn::worker.  I think having int mode and then the const
struct reference with all the other parameters makes sense.


