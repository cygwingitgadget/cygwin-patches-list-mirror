Return-Path: <SRS0=H7in=IS=nrubsig.org=roland.mainz@sourceware.org>
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	by sourceware.org (Postfix) with ESMTPS id 502AA4BA2E05
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 13:14:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 502AA4BA2E05
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=nrubsig.org
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nrubsig.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 502AA4BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=23.83.223.166
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793193252; cv=none;
	b=aLYjPwq50QUBgZK/lg0A12AxmE82nzKCUASykZ3vJjsyLiQb9EKJ5fOA6MEj7Wv1UcSe6+Ovc4XPzzUAAqePWvVtHluC6PKM561NxasNrTXeL4IhK81PXXpaLpeBDBYxHUdzyIU39Xfj9wijf5Ab/IhUZct+19tyLHwgZwPdo7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793193252; c=relaxed/simple;
	bh=BFM/jKKpiiuWwDztOU+HQnwm87GyIhYctI278mZHvUw=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=DhI0ZrZJjSnHTIIPK/0WOYRA8QVoZM9htxc3nCYqPHvc0M7s/3L0T1Sti7cfEEDFa18M/dFVujFUycmAlM/P8fNuI32fnmFJG+KLET/3QPNbHHi07bHlcDizhExWlAffXKZD8mClDsNAqKZN+G+cj/0IpLNQIG94tQyTvqRvnD0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nrubsig.org header.i=@nrubsig.org header.a=rsa-sha256 header.s=dreamhost header.b=Ro2zUho8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 502AA4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nrubsig.org header.i=@nrubsig.org header.a=rsa-sha256 header.s=dreamhost header.b=Ro2zUho8
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 44BC64C3A26
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 13:14:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (100-96-9-235.trex-nlb.outbound.svc.cluster.local [100.96.9.235])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C9BC94C3A5E
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 13:14:06 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|gisburn@nrubsig.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|gisburn@nrubsig.org
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Little: 01501e1921ecbb2e_1793193251009_3007145837
X-MC-Loop-Signature: 1793193251009:2124911133
X-MC-Ingress-Time: 1793193251009
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.9.235 (trex/8.0.2);
	Wed, 28 Oct 2026 13:14:11 +0000
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: gisburn@nrubsig.org)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4jF79V4qb9zVj
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nrubsig.org;
	s=dreamhost; t=1793193246;
	bh=4ZHve7M6vcPhkFElcxZLD4eUIi9tMOlvLWeoQyMd7aU=;
	h=From:Date:Subject:To:Content-Type:Content-Transfer-Encoding;
	b=Ro2zUho8SrdjoCQSgCPe1rFCVkLqrbK6GPr6rSOdF/s9p89smBLt0r5YfhEG0OG4x
	 /Urn9zWt5PnogbzjqNGyzsCoEoZQFdEL+5NyAfv2t9K6oFROd1ztaBTq/vK/jDByGI
	 QzjGW5G5V3Fg+diZY87AYt8UYsnRVq3hBnEOngeT3a/RBIgnr/mMEoqy96toTLbYri
	 x6odvlqOBQ2GemptxAunp6G+YgmUYq/0eYrx/Z4VJwzDSQ5IgGnPk0nVuJBZRGGl9H
	 yZ6nLdgRcWF1y6Yd+S2sFtsyBuMiHwyZtLf7HaOGEZ4c3xJ7S5ZTttl5vHm/83PqOt
	 6e4+6Xcsxrp8w==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso1012275a12.0
        for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 06:14:06 -0700 (PDT)
X-Gm-Message-State: AFq9FYLOnSRNtuY0MBhqk96qzs7Q2zYQ60o+2T4dzP09Jw2LUj8LAI/F
	2bHYlgaTjUw/ykxBhzocgECpGDOpSCGYIo3rjoFPdHLEidck7Kxz4KKcdYAO7v+1yZf6KwCpOYW
	j5P6OrsgbUKXmBERduwV70N04dbm6Lbs=
X-Received: by 2002:a05:6402:223a:b0:6b1:c34b:f1de with SMTP id
 4fb4d7f45d1cf-6b49cbec0c7mr950551a12.23.1793193245530; Wed, 28 Oct 2026
 06:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
 <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
 <CAAvCNcBwn0F84avS5pFS+oUoHuUAoSuKBEc2ybYScO8RDHV9NA@mail.gmail.com>
 <CAKAoaQk+qgptFfmBugTcvfdLLhEnGPJWY70tLdQg1qNRFT+hQg@mail.gmail.com> <83ee12dd-70e3-4e27-85df-c9b860648044@dronecode.org.uk>
In-Reply-To: <83ee12dd-70e3-4e27-85df-c9b860648044@dronecode.org.uk>
From: Roland Mainz <roland.mainz@nrubsig.org>
Date: Wed, 28 Oct 2026 14:13:27 +0100
X-Gmail-Original-Message-ID: <CAKAoaQ=Fj_junDr_5992EUayLRhmG8Gq81KDMQB6NORoCVNA2g@mail.gmail.com>
X-Gm-Features: AclHuK9q1uVQpecniONJKGqksadLSwrofUtXpZocb6V9xQfAP_w8ylb_6H3EQXk
Message-ID: <CAKAoaQ=Fj_junDr_5992EUayLRhmG8Gq81KDMQB6NORoCVNA2g@mail.gmail.com>
Subject: Re: [Ms-nfs41-client-devel] [PATCH/RFC] Patch to fix uid/gid lookup
 for NFSv4 filesystems
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOCAL_AUTHENTICATION_FAIL_SPF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NEUTRAL,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, Oct 28, 2026 at 1:30=E2=80=AFPM Jon Turney <jon.turney@dronecode.or=
g.uk> wrote:
>
> On 24/08/2026 12:53, Roland Mainz wrote:
> > On Sun, Aug 23, 2026 at 4:38=E2=80=AFPM Dan Shelton <dan.f.shelton@gmai=
l.com> wrote:
> >>
> >> On Fri, 21 Aug 2026 at 17:21, Lionel Cons <lionelcons1972@gmail.com> w=
rote:
> >>>
> >>> On Sun, 16 Aug 2026 at 19:35, Lionel Cons <lionelcons1972@gmail.com> =
wrote:
> >>>>
> >>>> Repost with proper [PATCH/RFC] tag.
> >>>>
> >>>> I've attached a patch
> >>>> (cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
> >>>> ms-nfs41-client project) that resolves an issue with uid/gid lookups
> >>>> on Windows NFSv4 filesystems.
> >>>>
> >>>> Currently, Cygwin assumes that all Windows NFS clients operate
> >>>> similarly to the Windows NFSv3 client. It expects that account names
> >>>> and numeric uid/gid values are identical on both the client and serv=
er
> >>>> sides, with LDAP acting as the sole authority for these numeric
> >>>> values.
> >>>>
> >>>> However, the NFSv4 protocol fundamentally changes this paradigm. As
> >>>> defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rul=
es
> >>>> for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/g=
id
> >>>> protocol representation in favor of string-based identifiers (e.g.,
> >>>> user@domain and group@domain).
> >>>>
> >>>> To handle this, all NFSv4 clients implement a local "idmapper"
> >>>> component that translates these string-based identities from the
> >>>> network side into local account data (in the case of Windows, mappin=
g
> >>>> user/group names and uid/gid values via nfs3attr XATTR). Because NFS=
v4
> >>>> clients manage their own uid/gid translation locally, Cygwin's
> >>>> reliance on raw LDAP data fails in these environments and results in
> >>>> the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
> >>>> owner/group output in Cygwin ls -l.
> >>>>
> >>>> The attached patch addresses this by detecting whether the underlyin=
g
> >>>> filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption a=
nd
> >>>> performs a direct pass-through of the uid/gid values supplied by the
> >>>> NFSv4 client's idmapper.
> >>>>
> >>>> I have successfully tested this fix against several major clients, i=
ncluding:
> >>>> - Exceed NFSv4 client
> >>>> - OpenText NFSv4 client
> >>>> - ms-nfs41-client
> >>>> - ms-nfs42-client
> >>>> - Windows NFSv3 client (no change, it continues to use LDAP raw data=
)
> >>>>
> >>>> Please let me know if you have any questions or require modification=
s
> >>>> to the patch.
> >>
> >> This is the same patch as
> >> https://github.com/kofemann/ms-nfs41-client/blob/master/cygwin/cygwin_=
patches/cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff
> >> right? Who did auhor it - Roland Mainz or someone else? Why was that
> >> patch not submitted before?
> >
> > That's my patch. The issue is that - while this patch is ready (and in
> > use by CERN&co) - I wanted to do more, but didn't had time to catch
> > Corinna for further debates.
> >
> > The ToDo-List:
> > 1. get this patch into Cygwin
> Roland,
>
> As the original author, can you please make a declaration about the
> licensing of this patch, as per [1]. (Ideally covering any future
> contributions as well.)

Statement:
My patches/changes/contributions to the Cygwin sources are under the
2-clause BSD license.

Is that OK ?

----

Bye,
Roland
--=20
  __ .  . __
 (o.\ \/ /.o) roland.mainz@nrubsig.org
  \__\/\/__/  MPEG specialist, C&&JAVA&&Sun&&Unix programmer
  /O /=3D=3D\ O\  TEL +49 641 3992797
 (;O/ \/ \O;)
