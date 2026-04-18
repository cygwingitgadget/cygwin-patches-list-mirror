Return-Path: <SRS0=tGrx=CR=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 320B14D108C5
	for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 08:25:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 320B14D108C5
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 320B14D108C5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776500702; cv=none;
	b=vXrZX1Zt65g/uP9HLWVZeZQJewgHztNXOz20s/9l50X/wn+4nUgJgCQVN5u/3/96hs00w/vdKPPJt2fHCBKUkQi0Ml9k+FGQ3LPBkEWb27AbMOX2j2jQnei8k2GOxEEAtlRx6AACSSE8/gfbRmxrFE4YLTEFKEjTpolNIvzeN1E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776500702; c=relaxed/simple;
	bh=L6m+5yRa1V0Xd9NG2AIfH1etpJ/NsIt4JrmcJrE3Vds=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=HYz3jbRF1j81RmHGURZCuWrRYCQJVccAUKircr863pfnxbxsLQzjaVg57atjVeYKwyQMkr88ICDASwL6jTYHZvaq4deWGprYxUTVWeGLTsqcHikcM1CiE3jJzLG45avYRCi89tVRXgI8QZXD9qmI4bWzGT//L5exbL+YeKMIo2w=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 320B14D108C5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=OF055qkw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1776500700; x=1777105500;
	i=johannes.schindelin@gmx.de;
	bh=ROEdlQnUU119TkBQSGB2qu4XfCktn/sPDPcZOMkcb0Y=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OF055qkwYs8XLVuA//xyQh3nQzgGckl1Y67EAl7eSlRMHcbsqmfUe7oq9rNNb3Wy
	 wBD6leXvzMyI8AkaVGx1i3JVueos+jP5kFjIaQ3nOEywOr+n4ps8VMQSDn/eJIEr2
	 WovK0ZiFaNaoJffqOUhFHK5AKK8jhdW5qBDmKMnNlUYH0NSxytpBl8amjC7EwuX/P
	 /yGsZDTGgp/vmqJUEVzTOYUMhabJU7GBixfzrdfSaLZyQvRs9axGsgsZPUBBGunmv
	 FZoRb17cbKBK64wP0LRBHrVxZgw8wbHFq5a/HANXZfUvMcl09NeoZ3SYRfTy7bwTc
	 AtEKyiNBCJAQS9pMOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Mj-1ve7rz1PsJ-00jbTV; Sat, 18
 Apr 2026 10:25:00 +0200
Date: Sat, 18 Apr 2026 10:24:58 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: John Haugabook <johnhaugabook@gmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: cygwin-htdocs: website fresh coat of paint
In-Reply-To: <CAKrZaUtijrdP8Li1uBmh7s_2aXJAGb__RkO5CRXrJR4mrMWwMQ@mail.gmail.com>
Message-ID: <f60d803c-59a8-637d-0ec8-75ac50cf107e@gmx.de>
References: <69e1cbb2.530a0220.249b6f.22da@mx.google.com> <CAKrZaUtijrdP8Li1uBmh7s_2aXJAGb__RkO5CRXrJR4mrMWwMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1894408608-1776500700=:114"
X-Provags-ID: V03:K1:n4hThjx4HFluWDeW1FhWNMUiAhGmL15TX25pF+jErXvmynjgjoU
 Tf7p1qUH5Kh/tT1SZA6UVufuoMunUm82CcTraK7UYZv13WLyGw2BvQWWsXcUS/4rtRxmiQw
 6XFCJjyJO1q0RujiAn00WiFMsE/Ch3OYl2uFe0SR9fzV0W71sSBaIs0N6re1UXvfCnYM//V
 POn559AWepIlJWhiE8mcQ==
UI-OutboundReport: notjunk:1;M01:P0:7DB8SNehUp4=;IwmKDN5zIrMXoKwEmmfNRnje9gw
 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
 /Jq5Q0hl4OtC/3c0QXmxAtb/kdc=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1894408608-1776500700=:114
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi John,

On Fri, 17 Apr 2026, John Haugabook wrote:

> On Fri, Apr 17, 2026 at 1:57=E2=80=AFAM <johnhaugabook@gmail.com> wrote:
>=20
> > Attached are several patches that update the site's UI/UX. As a whole,
> > this is a fresh coat of paint for the website. For a full demonstratio=
n of
> > all the patches applied to the site, see this support repo:
> >
> > https://github.com/jhauga/cygwin-htdocs

Thank you for publishing the patches that way; I wanted to see what the
site would look like, deployed it to GitHub Pages (because I didn't want
to open Codespaces on my phone), realized that the CSS and whatnot is
broken, set Claude Opus [*1*] to the task of creating a minimal GitHub
workflow on top, and now it is deployed and can be viewed at:

	https://dscho.github.io/cygwin-htdocs/

Obviously the first thing I did was to open https://www.cygwin.com/ in
another tab and then switch back and forth to compare the differences. I
like the new look a lot!

> > For the debatably controversial patches, I added nested links to UX/UI
> > research in support of the "whys".
> > This mostly consists of links to UX/UI studies, and the research takea=
ways.

While I have too little expertise to lend to a valuable review (and I
still owe Takashi a thorough one elsewhere on this list), I do want to say
that I love how you documented all the considerations and studies. Thank
you!

Ciao,
Johannes

Footnote *1*:
https://github.com/dscho/cygwin-htdocs/tasks/684575b6-8ef6-4272-98fd-690b6=
08e27cf

--8323328-1894408608-1776500700=:114--
