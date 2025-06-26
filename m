Return-Path: <SRS0=1xMm=ZJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id DE4AE385703B
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 05:22:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DE4AE385703B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DE4AE385703B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750915374; cv=none;
	b=rlLLu66er+uPoGio+h1UpkEakSOTyi8BS6QKC8XjTLKeSCFDw9G2oGz559DE8CDDi3RWSMgUtJQDS/GX1Zc3szIaDJ6tQb9f1hK9E12tyi7c+SCl2fK8fMdIfOrYOiq7T2uH9dYQNXSqMhbDeG+RZVh3rPbkNSLm3/Ux8mrE90k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750915374; c=relaxed/simple;
	bh=md+3mph4bjzdhSlByWs49KFhECd/80JHN2/X6wjtNNQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=A5GFwLRCXvj5wQU//1opr4yxPK9Dqt69cGp04d+z9DsX0Fe1pnUbgFAGPoTIqiw5PTSUUzuYYOVKWzvcj0EyTjKEpGTwzotzZnYrhOCioG9micRmbZkybmJ+7P45b5usjEmZmP4dy80vn5WzAkmkitrEIMp2eBcWW0KD/K6YmhA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DE4AE385703B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cwA0RqUL
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20250626052251368.ZVVH.50988.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 14:22:51 +0900
Date: Thu, 26 Jun 2025 14:22:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] pipe: fix SSH hang (again)
Message-Id: <20250626142249.9a4d7378ec9fd68a7b2b8cb7@nifty.ne.jp>
In-Reply-To: <934bc894-d2c4-2a7a-e236-abec9e1717fb@gmx.de>
References: <c9b1313d5d8a690aae9788402ec5190a1f18ce75.1750679728.git.johann>
	<62e79c50daf4e3ae28db3ae1a3cf52460f0d8968.1750775114.git.johannes.schindelin@gmx.de>
	<20250625085316.35e6dda457b6dce9792c824a@nifty.ne.jp>
	<701dca10-214a-aa25-a58d-913dbcd258a3@gmx.de>
	<4ad377e7-a75b-d7c4-ccbf-904c18bf3713@gmx.de>
	<20250625195534.dc322b8f310c7b1c0d3abd03@nifty.ne.jp>
	<20250625205102.6b2bcc4f5e7f1ae0606197c5@nifty.ne.jp>
	<20250625211754.c9b38091a64362f2d28da1f8@nifty.ne.jp>
	<934bc894-d2c4-2a7a-e236-abec9e1717fb@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1750915371;
 bh=mvNl2xwwmH6qumN3zWoGGmGk9pK6zKflZHFKl7Y3caE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=cwA0RqULD/94MWxr1MiGqn82GDe1vajJO9L+cvKTR6G8ER5RLsOmlV7AdhnGvF3WkgtCpbJx
 6dlwI0GVORSuWjMGpPPeaMlBTma8vIl2JdKvftf7Ee3aitwovvvZt/UWkdKaG1pvI4CKpxQXrC
 B6l8aTrf8cT9lPBf9bwJF+IMALMb1QQEBVUnijGAKyZkXkZlH4uTjJJpoCiM4o6TvsbysMeutS
 1s2BqoMikFelsGk55AVc56Oydnl+VLwV6jbAQDqmCWFcFUhIlQvuZzRJ1dmPqn5sdDF/1D6mkL
 W3HIl/tp0o+7Q/FXrAAQhN0R5J1OnPzv4Y5WFRI/fnlHZkHQ==
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025 17:57:56 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Jun 2025, Takashi Yano wrote:
> 
> > On Wed, 25 Jun 2025 20:51:02 +0900
> > Takashi Yano wrote:
> > > On Wed, 25 Jun 2025 19:55:34 +0900
> > > Takashi Yano wrote:
> > > > Hi Johannes,
> > > > 
> > > > On Wed, 25 Jun 2025 09:38:17 +0200 (CEST)
> > > > Johannes Schindelin wrote:
> > > > > Hi Takashi,
> > > > > 
> > > > > On Wed, 25 Jun 2025, Johannes Schindelin wrote:
> > > > > 
> > > > > > On Wed, 25 Jun 2025, Takashi Yano wrote:
> > > > > > 
> > > > > > > I'd revise the patch as follows. Could you please test if the
> > > > > > > following patch also solves the issue?
> > > > > > 
> > > > > > Will do.
> > > > > 
> > > > > For the record, in my tests, this fixed the hangs, too.
> > > > 
> > > > Thanks for testing.
> > > > However, I noticed that this patch changes the behavior Corinna was
> > > > concerned about.
> > > 
> > > The behaviour change can be checked using attached test case.
> > 
> > Hmm, then, nga888(Andrew Ng @github)'s solution seems to be
> > the best one.
> > https://github.com/git-for-windows/git/issues/5688#issuecomment-2995952882
> 
> "Best" by what rationale? That it passes the attached test case (which is
> not a test case, by the way, as there are no assertions that can fail, and
> it is not integrated into the test case, please fix both aspects before
> you call it a test case).

The "bug fix" should not change the current code intent. nga888's patch
keeps the code intent regarding write size for non-blocking write, while
other patches do not.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
