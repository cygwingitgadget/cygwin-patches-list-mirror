Return-Path: <SRS0=mUBA=ZC=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B04E338E4EEA
	for <cygwin-patches@cygwin.com>; Thu, 19 Jun 2025 17:40:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B04E338E4EEA
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B04E338E4EEA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750354833; cv=none;
	b=DCPs5f1VVkxMWaEuiG3JSx+RRFWdkvsXFBVKVfP3pTcYM/jQA9GqmlgNpRkXqu6KZWSBvSFmv0xG81zgKVSnCp+p1SQgRQFxWUdJ3FFwi8f5vQGsee5RY7K6f4/xbjfKok+iBjN8Hvv5SVHvKmov4xtcZ7MseX1Wbm82lNDRZks=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750354833; c=relaxed/simple;
	bh=Q4a1D6RczG2LyFca3wZq1tQMPoBU1gpKFmh+fASYO3M=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ZKXzTnBgeQD81mS53TwGlC/b9+7pRyT5bErnz9iZD8YNTRCol2HddLdgRUMNlhG0nvg4j/smkxSXa3EANgUvr64V9ZxzUqyS9i1ImeE3PllKXc9SfU8v+z02YGRZytL/3hlwJNbcuGztR1TQoH1pyj33O4NVo4kXdd6OU3WivNI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B04E338E4EEA
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=BZ5c1qiu
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 2009045D04;
	Thu, 19 Jun 2025 13:40:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=oW8z1HL00YLWcq29WH6EZ/7UMhE=; b=BZ5c1
	qiuVDY+rT42AjCgLEfcCxrVlHX5XzaDUmjXYTAY2FPtG/N0qksqYnrJ+Vsdp8Ao/
	JLr6vtD007FFiUpDuWW5QB/wfChvTO18T6pNQs267qVZLPK+912ODpuAbsoyK3l1
	WqHXnpBGGIct8B13fa+WBJHay1GBh0Rock54S0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 1A47D45CC3;
	Thu, 19 Jun 2025 13:40:33 -0400 (EDT)
Date: Thu, 19 Jun 2025 10:40:32 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: obtain stack pointer on AArch64
In-Reply-To: <03f0cd43-0adc-fee7-911c-2a553669b095@jdrake.com>
Message-ID: <ee310087-cf59-27fb-5fd5-e751b69e2cd2@jdrake.com>
References: <DB9PR83MB09238701426EDE79BDAAFA2F9272A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <03f0cd43-0adc-fee7-911c-2a553669b095@jdrake.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="15599321219072-2084653751-1750354833=:11368"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--15599321219072-2084653751-1750354833=:11368
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> On Wed, 18 Jun 2025, Radek Barton via Cygwin-patches wrote:
>
> > Hello.
> >
> > This patch ports stack pointer reading to AArch64 at fork.cc and cygt=
ls..h.
> >
> > Radek
> >
> > ---
> > From cc920233d50fe38f22610cb51f219e3c9b566109 Mon Sep 17 00:00:00 200=
1
> > From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microso=
ft..com>
> > Date: Fri, 6 Jun 2025 10:21:10 +0200
> > Subject: [PATCH] Cygwin: obtain stack pointer on AArch64
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >
> > Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> > ---
> >  winsup/cygwin/fork.cc                 | 4 +++-
> >  winsup/cygwin/local_includes/cygtls.h | 6 ++++++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
> > index f88acdbbf..4abc52598 100644
> > --- a/winsup/cygwin/fork.cc
> > +++ b/winsup/cygwin/fork.cc
> > @@ -660,8 +660,10 @@ dofork (void **proc, bool *with_forkables)
> >      ischild =3D !!setjmp (grouped.ch.jmp);
> >
> >      volatile char * volatile stackp;
> > -#ifdef __x86_64__
> > +#if defined(__x86_64__)
> >      __asm__ volatile ("movq %%rsp,%0": "=3Dr" (stackp));
> > +#elif defined(__aarch64__)
> > +    __asm__ volatile ("mov %0, sp" : "=3Dr" (stackp));
> >  #else
> >  #error unimplemented for this target
> >  #endif
> > diff --git a/winsup/cygwin/local_includes/cygtls.h b/winsup/cygwin/lo=
cal_includes/cygtls.h
> > index 31cadd51a..44bd44e72 100644
> > --- a/winsup/cygwin/local_includes/cygtls.h
> > +++ b/winsup/cygwin/local_includes/cygtls.h
> > @@ -325,7 +325,13 @@ public:
> >         address of the _except block to restore the context correctly=
.
> >         See comment preceeding myfault_altstack_handler in exception.=
cc.. */
> >      ret =3D (DWORD64) _ret;
> > +#if defined(__x86_64__)
> >      __asm__ volatile ("movq %%rsp,%0": "=3Do" (frame));
> > +#elif defined(__aarch64__)
> > +    __asm__ volatile ("mov %0, sp" : "=3Dr" (frame));
> > +#else
> > +#error unimplemented for this target
> > +#endif
> >    }
> >    ~san () __attribute__ ((always_inline))
> >    {
> > --
> > 2.49.0.vfs.0.4
> >
> >
>
> LGTM

Pushed, thanks
--15599321219072-2084653751-1750354833=:11368--
