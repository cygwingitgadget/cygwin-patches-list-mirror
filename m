Return-Path: <SRS0=eEjd=GR=nrubsig.org=roland.mainz@sourceware.org>
Received: from hamster.birch.relay.mailchannels.net (hamster.birch.relay.mailchannels.net [23.83.209.80])
	by sourceware.org (Postfix) with ESMTPS id 8E2BC4BA799B
	for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2026 11:53:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8E2BC4BA799B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nrubsig.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8E2BC4BA799B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=23.83.209.80
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787572442; cv=none;
	b=PrCCOzVYR2TSZojFFLOKAbi9rbZll65wpQXqmQNK6w+uKWN4B8s0bq1avm83EdMenX4GsywNY6akVjI7zWp/v4alxMjB4VagyCmkopSnrCuaJYZzp/TAyBRl49NmxmrGDCuX2E+pHWuicd4zdnxyoTna3XLOJiUlwpfpxhxtkCU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787572442; c=relaxed/simple;
	bh=hFNPC3tSZVJGtv+fscan7tUhTZdr54kLXek5EFszxkk=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=bxyTNpWsjFyjzMerVZxMnqtbvw2JwE2Py8zefOZXcel155imw82nSZbtHxaM+/ihdf6konAQncK9sIFytOkxFQbz8NJvNYOkt3ai74kOZaw7Ge0pypeX8YDN4Jeq9Czf+mlhUfaNic8EmwJnj6aEYfhhVfUkU6q3uTPa5deVQdw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nrubsig.org header.i=@nrubsig.org header.a=rsa-sha256 header.s=dreamhost header.b=mAxWApi4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8E2BC4BA799B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nrubsig.org header.i=@nrubsig.org header.a=rsa-sha256 header.s=dreamhost header.b=mAxWApi4
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 623CB400844
	for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2026 11:53:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.96.15.145])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2268C400EC8
	for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2026 11:53:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Trade-Shelf: 5d168f690cf63274_1787572435292_694568180
X-MC-Loop-Signature: 1787572435292:1699053358
X-MC-Ingress-Time: 1787572435292
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.15.145 (trex/8.0.2);
	Mon, 24 Aug 2026 11:53:55 +0000
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4hT8St6wm8z104d
	for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2026 04:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1787572430;
	bh=Spp2BEkqEEyjMA5q/KxK7bhnLtB8RSI0TFlO3gy5ArE=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=mAxWApi43TCfb5BNES8qu9yizs+Xf4aDsvZhkScnvpQJVFGLasxJlUdOjsMqUAPgM
	 /0gkX5xw9Ln+tg4r51WW4YW/C4EKTE2mSmh+LjA5l+rrr2ZEzzQAWikz13aFF0J7Wh
	 cQEGJfJtbElS0Ni3shtZjhY7jF0Eng6K7CZVydUY7PKsQZpAX3qBQEH5UjXTF4wO9K
	 CndRBjRhxAg59dxYeP8Kk0WjmpypnK2s3SoUZJIbB8gYFgu8+GX/eImdaJkBFigYsn
	 6Uh9FzzckXnWizK7BAEF1v/t3m3+ojDLc4VW57ynIeyrWmEqOEJDHS+oAg/UO+YJsm
	 EGY+hUi82eimw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so27034145e9.1
        for <cygwin-patches@cygwin.com>; Mon, 24 Aug 2026 04:53:50 -0700 (PDT)
X-Gm-Message-State: AFuF++mh4/4gbqzboWi2IvQsEdB2DZJYYCtGKn1XvMSMj+ux1F5s2X9h
	grSqGT4P+zR2ezWNNB318b0qks6tHFMSdBYdOvxBYVSjn8ZrqOzR9EZeeK+hCL6FNiZ3e5JR0i4
	U/WXAr5eqqVrqU9YIuaUVP/1WsFCdsSg=
X-Received: by 2002:a05:600c:5486:b0:499:a0f3:9d5c with SMTP id
 5b1f17b1804b1-499b82f412amr302443725e9.3.1787572426469; Mon, 24 Aug 2026
 04:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
 <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com> <CAAvCNcBwn0F84avS5pFS+oUoHuUAoSuKBEc2ybYScO8RDHV9NA@mail.gmail.com>
In-Reply-To: <CAAvCNcBwn0F84avS5pFS+oUoHuUAoSuKBEc2ybYScO8RDHV9NA@mail.gmail.com>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Mon, 24 Aug 2026 13:53:08 +0200
X-Gmail-Original-Message-ID: <CAKAoaQk+qgptFfmBugTcvfdLLhEnGPJWY70tLdQg1qNRFT+hQg@mail.gmail.com>
X-Gm-Features: AcwNN1VVXJ0QMb822d-VBrbYA_nJ7M4fx0B58rnqcyuCO2-mpHtVm6n3LltOS4E
Message-ID: <CAKAoaQk+qgptFfmBugTcvfdLLhEnGPJWY70tLdQg1qNRFT+hQg@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] [PATCH/RFC] Patch to fix uid/gid lookup
 for NFSv4 filesystems
To: cygwin-patches@cygwin.com, ms-nfs41-client-devel@lists.sourceforge.net, 
	Takashi Yano <takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOCAL_AUTHENTICATION_FAIL_SPF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NEUTRAL,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun, Aug 23, 2026 at 4:38=E2=80=AFPM Dan Shelton <dan.f.shelton@gmail.co=
m> wrote:
>
> On Fri, 21 Aug 2026 at 17:21, Lionel Cons <lionelcons1972@gmail.com> wrot=
e:
> >
> > On Sun, 16 Aug 2026 at 19:35, Lionel Cons <lionelcons1972@gmail.com> wr=
ote:
> > >
> > > Repost with proper [PATCH/RFC] tag.
> > >
> > > I've attached a patch
> > > (cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
> > > ms-nfs41-client project) that resolves an issue with uid/gid lookups
> > > on Windows NFSv4 filesystems.
> > >
> > > Currently, Cygwin assumes that all Windows NFS clients operate
> > > similarly to the Windows NFSv3 client. It expects that account names
> > > and numeric uid/gid values are identical on both the client and serve=
r
> > > sides, with LDAP acting as the sole authority for these numeric
> > > values.
> > >
> > > However, the NFSv4 protocol fundamentally changes this paradigm. As
> > > defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rule=
s
> > > for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gi=
d
> > > protocol representation in favor of string-based identifiers (e.g.,
> > > user@domain and group@domain).
> > >
> > > To handle this, all NFSv4 clients implement a local "idmapper"
> > > component that translates these string-based identities from the
> > > network side into local account data (in the case of Windows, mapping
> > > user/group names and uid/gid values via nfs3attr XATTR). Because NFSv=
4
> > > clients manage their own uid/gid translation locally, Cygwin's
> > > reliance on raw LDAP data fails in these environments and results in
> > > the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
> > > owner/group output in Cygwin ls -l.
> > >
> > > The attached patch addresses this by detecting whether the underlying
> > > filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption an=
d
> > > performs a direct pass-through of the uid/gid values supplied by the
> > > NFSv4 client's idmapper.
> > >
> > > I have successfully tested this fix against several major clients, in=
cluding:
> > > - Exceed NFSv4 client
> > > - OpenText NFSv4 client
> > > - ms-nfs41-client
> > > - ms-nfs42-client
> > > - Windows NFSv3 client (no change, it continues to use LDAP raw data)
> > >
> > > Please let me know if you have any questions or require modifications
> > > to the patch.
>
> This is the same patch as
> https://github.com/kofemann/ms-nfs41-client/blob/master/cygwin/cygwin_pat=
ches/cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff
> right? Who did auhor it - Roland Mainz or someone else? Why was that
> patch not submitted before?

That's my patch. The issue is that - while this patch is ready (and in
use by CERN&co) - I wanted to do more, but didn't had time to catch
Corinna for further debates.

The ToDo-List:
1. get this patch into Cygwin
2. Add another set of methods to delect |is_nfs()|, |is_nfs3()|,
vis_nfs4()|, |is_msnfs3()|:
- |is_nfs()| is to detect all NFS filesystems, and enable the use of
ServicesForUNIX-style attributes to lookup uid/gid/etc. and NFS-style
symlinks/etc.
- |is_nfs3() to detect NFSv3 filesystems, where uid/gid<-->name lookup
can go directly through LDAP
- |is_nfs4()| to detect NFSv4.x-filesystems, where uid/gid should be
treated-as-is (no LDAP) ... that's
"cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt"
- |is_msnfs3()| to detect specifically the Microsoft NFSv3 filesystem
driver, because over many many years lots of workarounds were added
for bugs in this driver, which are not appliciable for the other NFS
filesystem drivers

IMO "cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt" patch can go
into Cygwin right now, it works with Microsoft NFSv3, Hummingbird
NFSv4 and ms-nfs41-client/ms-nfs42-client ...

@Takashi Yano What do you think ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)
