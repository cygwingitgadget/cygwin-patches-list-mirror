Return-Path: <SRS0=E9tV=BJ=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by sourceware.org (Postfix) with ESMTPS id CB5384BA2E0B
	for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2026 09:55:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB5384BA2E0B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB5384BA2E0B
Authentication-Results: server2.sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::22f
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1773050138; cv=pass;
	b=Pm7q8FQ0L+wCn75uzH8woOlhrD2kNB4nAEbc/C3PROnWV5dcS7oBu6c3LR4dLneZ2S1co4fIR3V+qTbhxTpTiGopvGxENmc4tGVmWbebif+hNhlE9PKo/0wmqVua6lkudLercKX29lG69a3fim/bBTI0HnYJ8DjnmfnFzPiaikg=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773050138; c=relaxed/simple;
	bh=ikN3kBTh9K4eW6IMi3gKE8tPUC70NoRq4F0MT5vgrM0=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=jsYC7E2a6tVuAUwoPvvr5lQ3C+jr6qnI5dbHKyi/ApIza1fxHQ865kNH/M7t0y3LfTJ8mYH4djR8c22ic0hlmnOg5plPbSAJFPObHU0tGUrCP/JeQdl/ZpqQPnfqVypBPnTyv4SE3W0DCL7Q3JkgdL8eFZ/QR08HzCq0BXk4Mxo=
ARC-Authentication-Results: i=2; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB5384BA2E0B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kw4yxJGT
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so69155761fa.1
        for <cygwin-patches@cygwin.com>; Mon, 09 Mar 2026 02:55:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773050136; cv=none;
        d=google.com; s=arc-20240605;
        b=L+DuSpuSrZakwLv/y81LYVHvcsgR1R1B+Z+1trM9QXVbqPAZejbqOWqGum1bpz6+80
         z8JvFfmz9vrufwbgwM+fotRcPZp01IA3qJSmTs/ZuagtKfPZNWLKuoGLPfQ1b0IEcAk7
         Kzuhwh8UIjHQXSMQLmnesQv7r9woLZOq0TsxNT0A5R3WZkueEqPvT98LFy6c4z5bKcNj
         qCwLA7lo+KFYbNt1BMborWKOZZaRvrXRBALPAMaTH23s3NPnmZk5SdQ0fLiS1yyYt085
         uJzPGCigM/BvMJhy/g5Q6HR2eOdSzVNuoCgnQrLj1HAd7W/6/s4tatBabnPlymn4mJFD
         uunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMwwCk4mFfv9VYwK/2mKYdPKEwGm7VeGzhNwYD3Z67U=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=UH9/tFaqXYZ6o3i3U9z1MHs/cmnhF7qOgwdPQQJjIk4HoU9XSKVnw7Mq8/QDpoMO1Z
         ioPxqAK/ASHECQBMfQQGUyYW3ZMs8nLR0kWjFQiUlyV3rLCmaAoa3fShkyD7pM9zsc3W
         ie3jQX2iWeXGZvPclEt9APEbrVrnZDLiImcVndyHyPKztAIw+eoG6CPbyn4+KtrafJ3y
         BunMgdr7NzmooQYJeBR4CMPfWNR1M0GdJdqdRVSVb1HKSpmhMnHguldvrdOosnNC9+Sn
         PVusI5BzzJYZ9855Q+sP5UByXJni/GWNWrR8SFZd3JZbCZrPL8WVTb7PRKppfmcX2UKC
         TAkw==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773050136; x=1773654936; darn=cygwin.com;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMwwCk4mFfv9VYwK/2mKYdPKEwGm7VeGzhNwYD3Z67U=;
        b=kw4yxJGTi3qcAz8KbybGUJNiy2PrDOUk0uCGy6EVuGNwbJaqTSNM9nHHH33NtllTuz
         ZKfYG2gdN9EciJIGEZvxiHYwzIoBq3KaUNToEUoREKUx03fHekrHR3xpkXLzjCMKfxYn
         mDNmEheFMYbDalBD4yQWgmC5vybghBESJ/KzVVjawNAsC5Ont5z9DezQJkQe4kTNipfe
         s1ZLGqG5gU3UMk+cRaPO2pRTnUhv6Zh62vD0R3bUD/4ePJAQfZIUYpgLhimd7qwofdVH
         SjMyKCgQBZ/H+RZU9XvJ46fF0PAQIynHGQ2yq0k4gzMLqE3lNKrW8XPFifSbbhai4z/l
         ZOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050136; x=1773654936;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMwwCk4mFfv9VYwK/2mKYdPKEwGm7VeGzhNwYD3Z67U=;
        b=jidGnTwg4i3LVBx0V98nBG9Ztqd94x7r0k+MFjYbX4kNLKBL3MLScC+ojbCfLAzlKg
         6M/utqVJe31VxRKZ0WEGhmJes5aJEOYQvNZGCRZ7tX8IFSPSIPnUdej2sdP4lhKThXZX
         NkPLBDnClHKY4+qnwItqus1oI3f4zjfyuwsiUnQsKzvld4jEydGVlNCxbN/INUycpTd8
         dI3jGzGff2+j7Dpo1WIfoDwLmtonjHITMjpOegodt0wcRVjyFjMA71//BOe/EQUVIyVu
         6CeOrnOw7pee7dE/8NOx/Q5eVZpf576cUzpioKUXVH7HAoXEyJOJEdRnODgD0QOqKC7B
         W5nA==
X-Gm-Message-State: AOJu0YxgnUQpbZ2Y/3RVSQ4bF+2Oh+QMs3m0XKcnjHKXeozTuAA5r9uk
	IPHReeNGIvIlgR2+ILeS3lDVF0fUFCj+hNNF0LI3Whj6yl13HSY9gvIDe7DppBUhIoIPAb081hv
	p91V8Uo+1xVeaBL+ccL2/lYCsn1UEjmjLtA==
X-Gm-Gg: ATEYQzxHLm/yWlFps1N1Ysk5pOpVZCMF1dNtdyZq3Qb34XDx2rZhPFPnWC9M0ynrW8Z
	uDW2Zx3Ig3cpIOMOxN1xaceKB2quCpVU4I+c6nMfxmJ8/C3FkG4cQHX1043QdsQnRMfDkKCTLQJ
	teQtU5vwm7itUiaXlo8wJbbVH5eBB/O5SwUZ39x89fXSi2XgTtlexuDuDl7KfFknTL6j1t67DYx
	zY4Jur+a0/B62Ossmo08Yeb4Xko6J/vxb/KLKVJ9087gSgcgd5D197dDHpJYhMk4+XswV9OTXrR
	/TYslquIWi99+TayEo1QigBAPCVuvc7y08euTr8=
X-Received: by 2002:a05:651c:50c:b0:385:bbd2:2f with SMTP id
 38308e7fff4ca-38a40da0200mr30256321fa.41.1773050135426; Mon, 09 Mar 2026
 02:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <5f60e191-e50e-32d3-53cc-903e03cc7a5e@jdrake.com>
 <aGUfpy6cTysuyaId@calimero.vinschen.de> <fe6b5e2f-9709-e6fd-6031-1193c7fc8b94@jdrake.com>
 <aGaZq6sSSuNCKX59@calimero.vinschen.de> <fcda3f51-7737-5e21-30a9-443f5f4f8c97@jdrake.com>
 <5e4ebc57-cedc-577f-264d-6cc68be6ee99@jdrake.com> <aGeQMtwhTueOa4MT@calimero.vinschen.de>
 <206e78ac-9417-605d-14c1-d9ae2e93782d@jdrake.com> <832b300d-9eb9-bef8-46ff-36cce4520f4d@jdrake.com>
 <aGulX_0Azb6GI-_C@calimero.vinschen.de> <aIJ2kbx6UOK6mAnG@calimero.vinschen.de>
 <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com>
In-Reply-To: <b05a2798-ce6a-28cf-f8e2-3f0cd7bf165b@jdrake.com>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Mon, 9 Mar 2026 10:54:57 +0100
X-Gm-Features: AaiRm50778lrpjxczJH6vjWjYqbkphVaKC1RZcYD3yAKodQ_WJ-KOeGkUYKav-w
Message-ID: <CAHnbEGJT8vKZjR8aXqB+aANZ8J9P8G5bnLO6gf860FzAeCCXMA@mail.gmail.com>
Subject: Re: [PATCH 4/5] Cygwin: add fast-path for posix_spawn(p)
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Was this work ever merged into Cygwin1.dll?

Sebi

On Thu, Jul 24, 2025 at 8:44=E2=80=AFPM Jeremy Drake via Cygwin-patches
<cygwin-patches@cygwin.com> wrote:
>
> On Thu, 24 Jul 2025, Corinna Vinschen wrote:
>
> > On Jul  7 12:45, Corinna Vinschen wrote:
> > > On Jul  4 15:59, Jeremy Drake via Cygwin-patches wrote:
> > > > On Fri, 4 Jul 2025, Jeremy Drake via Cygwin-patches wrote:
> > > > > On Fri, 4 Jul 2025, Corinna Vinschen wrote:
> > > > > > I see what you mean.  The question of questions is if "as if" o=
nly
> > > > > > covers the "performed exactly once" requirement, or if the "as =
if"
> > > > > > really encompasses all three requirements, i.e.
> > > > > >
> > > > > > - as if the specified sequence of actions was performed exactly=
 once
> > > > > >
> > > > > > - exactly in the context of the spawned process (prior to execu=
tion of the new
> > > > > >   process image)
> > > > > >
> > > > > > - exactly in the order in which the actions were added to the o=
bject
> > > > > >
> > > > > > in contrast to
> > > > > >
> > > > > > - as if the specified sequence of actions was performed exactly=
 once
> > > > > >
> > > > > > - as if in the context of the spawned process (prior to executi=
on of the new
> > > > > >   process image)
> > > > > >
> > > > > > - as if in the order in which the actions were added to the obj=
ect
> > > > > >
> > > > > > My understanding (as a non-native speaker) is that "as if" only
> > > > > > covers the "performed exactly once" requirement.  Applying "as =
if"
> > > > > > to the order requirement doesn't make much sense to me.  And ap=
plying "as if"
> > > > > > implicitely to the second requirement, but not to the third, do=
esn't
> > > > > > make much sense to me either.
> > > > >
> > > > > The "as if" performed exactly once doesn't make a whole lot of se=
nse to me
> > > > > either... To me, the only case where "as if" adds flexibility is =
the
> > > > > context of the child process.
> > > > >
> > > > > > On top of that you'd have the problem that the man pages of
> > > > > > osix_spawn_file_actions_addclose and posix_spawn_file_actions_a=
ddchdir
> > > > > > contradict each other.  This, of course, is always possible.  O=
nly an
> > > > > > RFC to the Austin Group could clarify this.  Maybe we should re=
ally do
> > > > > > that.
> > >
> > > https://austingroupbugs.net/view.php?id=3D1935
> >
> > Good news:
> >
> > https://www.austingroupbugs.net/view.php?id=3D1935#c7229
> >
> > I'm glad I asked.
> >
> > tl;dr: The Austin Group just changed all the descriptions in terms of
> > posix_spawn_actions, so that they are to be performed *as if* they
> > are running in the child preior to calling execve().
> >
> > This means, we're free to run alkl desired actions in the parent, as
> > far as that makes sense.
> >
> > I still think it might make sense to run some of the actions in the
> > context of the child's child_info_spawn::handle_spawn() processing,
> > but we can restart discussing this as we go along.
> >
>
> Great!  I rebased the topic/posix_spawn branch yesterday to use a local
> child_info_spawn instance, but otherwise haven't really been looking at i=
t
> lately (I decided to test packinging the release candidate of llvm 21 and
> found a fun new bug that only shows up when binaries are stripped).
>
> I'm trying to remember where things were at, and what I'm coming up with
> was that I was going to revamp the struct with parameters to
> child_info_spawn::worker.  I think having int mode and then the const
> struct reference with all the other parameters makes sense.
>
>


--=20
Sebi
--=20
Sebastian Feld - IT security consultant
