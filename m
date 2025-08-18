Return-Path: <SRS0=nJKE=26=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id D9C093858C98
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 05:31:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D9C093858C98
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D9C093858C98
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755495069; cv=none;
	b=c9+BGlOt8Jsyfd3pQ/QAOE/3buijdP7X/h9358bTAukeiJyYvBR7a0bTqLSHYu+/CCyYVSRS1zrittIeYyWvTeplll5eV2o1q8LraG+giNY4aAj5kVptRHShJtBcO7LHD33BXsYzcPlqCYLUGlWFxm2v4D3gDJFdzB7Ix3aIjYs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755495069; c=relaxed/simple;
	bh=giu1kreToZRaquBGlzM8u/wCjN4eK/qQ1WZpKF6c1Sk=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=DRAvbEWMo2yqsqU03a2cR4hvjiCa+9YOIE5RL4THbvzap57FXQkQ5J4h6kFienVJdw+0gm3dkGyV/jKw/lxIWcc7nbesq/DpR1V/zyzUQfXywtpPhiznHf2kvfVn1UJsjsLPF3Oiav03Q+qdSZa5v6xeIJA6xEMv5ctr0uc75zE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D9C093858C98
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=eEVBtEnx
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20250818053105611.VVBU.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 14:31:05 +0900
Date: Mon, 18 Aug 2025 14:31:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: spawn: Make ch_spwan_local be initialized
 properly
Message-Id: <20250818143103.f9d71413fb36f551f4ea09d7@nifty.ne.jp>
In-Reply-To: <129ca853-27b1-e4be-d5d2-2482c245a80c@jdrake.com>
References: <20250816031650.557-1-takashi.yano@nifty.ne.jp>
	<7f233866-9276-1eb6-1876-2f8d44b5c042@jdrake.com>
	<129ca853-27b1-e4be-d5d2-2482c245a80c@jdrake.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1755495065;
 bh=cKvKP9avNyZtT3jFZA64eNd6hCOn4yi8aZvYBm/zN9E=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=eEVBtEnxmjGnxIt8sFbke51pAqFVQFcbUMd02vuhpCRbxGbp8fhSwQlKTb12Gikc+VAksd1O
 FqFtTBy7xW1KbspP4Hpkp3y1WEfzxgM4ij+8lGFQqGZOXwY9Tfej0KVsEo+zft337hGRIghAVV
 +3XNmXwB+GZ5tQyTh/ZWxSjr/sR/KRtFvI4o1xpTzw4DO9QjrvF/mX1TLJi4YWgbAiFtJJ2zf0
 UiMlJAzIeIC81XlVf0ciHxvNY8mpzkmyQBvq/uuhUy5OEo0jU3WfRYPSfFNqqobbqWlq0c7mFw
 IOlMzBtSAqvncRqaWDAP5koDe7EYJwGe9oOf7a6NRotTWXxQ==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 16 Aug 2025 00:45:22 -0700 (PDT)
Jeremy Drake wrote:
> On Fri, 15 Aug 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > On Sat, 16 Aug 2025, Takashi Yano wrote:
> >
> > > The class child_info_spawn has two constructors: one without arguments
> > > and one with two arguments. The former does not initialize any members.
> > > Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
> > > (i.e., ch_spawn_local) would be properly initialized. However, this was
> > > insufficient - it initialized only the base child_info members, not the
> > > fields specific to child_info_spawn. This led to the issue reported in
> > > https://cygwin.com/pipermail/cygwin/2025-August/258660.html.
> > >
> > > This patch updates the former constructor to properly initialize member
> > > variable 'ev' which was referred without initialization, and switches
> > > ch_spawn_local to use it.
> > >
> > > Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
> > > Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
> > > Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
> > > Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/local_includes/child_info.h | 5 +++--
> > >  winsup/cygwin/spawn.cc                    | 2 +-
> > >  winsup/cygwin/syscalls.cc                 | 2 +-
> > >  3 files changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
> > > index 2da62ffaa..b8707b9ec 100644
> > > --- a/winsup/cygwin/local_includes/child_info.h
> > > +++ b/winsup/cygwin/local_includes/child_info.h
> > > @@ -33,7 +33,7 @@ enum child_status
> > >  #define EXEC_MAGIC_SIZE sizeof(child_info)
> > >
> > >  /* Change this value if you get a message indicating that it is out-of-sync. */
> > > -#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
> > > +#define CURR_CHILD_INFO_MAGIC 0x39f766b5U
> > >
> > >  #include "pinfo.h"
> > >  struct cchildren
> > > @@ -148,7 +148,8 @@ public:
> > >    char filler[4];
> > >
> > >    void cleanup ();
> > > -  child_info_spawn () {};
> > > +  child_info_spawn () :
> > > +    child_info (sizeof *this, _CH_NADA, false), ev (NULL) {};
> >
> > I noticed that moreinfo is checked/used in cleanup too, but it is set in
> > worker.  It'd probably be safer to initialize it too though.  Looking at
> > child_info, subproc_ready seems to not be initialized if
> > need_subproc_ready is false.  It'd probably be subject to the same issue
> > as ev.
> 
> More thoughts as I'm trying to sleep.  "Complicating" the default
> constructor may now require actually running code to construct the global
> ch_spawn instance.  Perhaps a new constructor for this purpose?
> 
> I'd put the constructor with initializers in a .cpp file rather than
> inlining it in the header, due to the CHILD_INFO_MAGIC hashing going on
> with the header.  Then I think it'd be cleaner initializing more members
> too (all the pointers/handles would make sense).

Ok. Thanks. So what about v3 patch?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
