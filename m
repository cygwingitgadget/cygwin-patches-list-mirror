Return-Path: <SRS0=Wi/b=GE=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 86C7B4BA2E20
	for <cygwin-patches@cygwin.com>; Tue, 11 Aug 2026 09:23:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 86C7B4BA2E20
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 86C7B4BA2E20
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786440224; cv=none;
	b=Gcwk7p1B8LacKOdt7dP9qL8984JazN3wZTWkY05xglAJvJVQBcajXQeqrR0DtZW+GthUG78yvHOx3pP4eIXeKjs5fuExdmBLtygBefDIewUO+D9kFp7Qxm2tde79ZjJof9XYxydr4MdWc1jODDkPG+pMi1e3KXdey8Psc1jTXVY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786440224; c=relaxed/simple;
	bh=vAHP7DJYikUvsP3fFtYfcZrnc0MIQXI7eCU52uoGbqY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=VrT392X7g774D8oMhFKVXqebXcY5by9FC2+CAr1m+ns5zeHr/7ZZSnEDmFT5oalpCEWnpSgQW/SWmuKml4U//Qw+JLtufHwtTBTUMzpg0ErGNP0loalCnZg08+Q6XMq9Eo6NYFGEVfdEZh1C2n3QyX6j61fCSR/kYQSTzPUsBmk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=CwkBmkpe
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 86C7B4BA2E20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=CwkBmkpe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1786440223; x=1787045023;
	i=johannes.schindelin@gmx.de;
	bh=TVH5ncZpiVX7nytaCPZYiiBsPV2J/9JN/5nJkDeSKg0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CwkBmkpercVf8LKCllSKeD9+Uqr3dAOfYNySYtoOGnDWSwYuIsyLcJ41O42uuufZ
	 qGYKJEbTYV41+Ls8z7PFDkNkAKOcyjyLExdQXLKv7cTjizndSs3wDWbfyCVm/a9ZJ
	 aHiat+oMZHTgNG+WR9CRpCi8qJnr11Priq20tmwNxYGghQMICGtx/vMNKOpiQUxHP
	 iaQqBfJ+40A1eonwpsTXydncMA6qw9TNDnYxxoMqainLS9+Pejji3HU3652hhZIHu
	 KWMD4A2nRMSt8r6L6gVPtLPmvPG1UNW1E+X+L2yIPjxRBb2xhhEDXjVRjxhD3zeLL
	 No9FMXXPeqoXKvexxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1wdQuQ0cZp-00YHXs; Tue, 11
 Aug 2026 11:23:43 +0200
Date: Tue, 11 Aug 2026 11:23:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?6aOb6aOb6aOb?= <chenlijon@gmail.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup: console: validate duplicated handle set for
 master thread
In-Reply-To: <CAD8hRBMNcuh+k0btNomyhcmn=yuNyn-Hh1bkC7gBKEiT=9kT0Q@mail.gmail.com>
Message-ID: <8f057c7e-4763-0cf3-1080-94198e63d46c@gmx.de>
References: <CAD8hRBMNcuh+k0btNomyhcmn=yuNyn-Hh1bkC7gBKEiT=9kT0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323329213404671617864402221624784
X-Provags-ID: V03:K1:/TVt9JtDwIT2lrIqlnDhkdfPYdYHgFMg/fOhh9oxsiVQGxDTAbE
 9bsFzKIiZi9gHzDXUfaWkl7UDbJJanhWpQkOjZIIrxBFoYfv8Qv16jvndRB0FjV9+mJuCnE
 ccJwrcq7XnP9223mcb+SRkU8aJmezH+T+7PT5mQJOmZaCnUMvG0yfiFUFwZBk+SVvR/MqUJ
 i3dlLSp+e1MMm/pY50PFg==
UI-OutboundReport: notjunk:1;M01:P0:EYIUKUr9Afg=;e7d52vUZz308JmTTNE/2KA0PLSp
 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
 Tj6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329213404671617864402221624784
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Tue, 11 Aug 2026, =E9=A3=9B=E9=A3=9B=E9=A3=9B wrote:

> Hi Cygwin maintainers,
>=20
> I originally came across this issue while working on LibreOffice develop=
ment
> on Windows.
>=20
> My main development environment is:
>=20
>   CPU: AMD Ryzen 7 9800X3D, 8 cores / 16 hardware threads
>   OS: Windows
>   Visual Studio: Visual Studio 2022
>   Windows SDK / UCRT: 10.0.26100.0
>   Cygwin runtime: E:\LibreOfficeDev\cygwin64
>   LibreOffice source tree: E:\LibreOfficeDev\src
>=20
> While developing LibreOffice, I found that parallel builds could become
> unreliable in my environment, and I often had to reduce the parallelism
> significantly to avoid a stuck build.
>=20
> Out of curiosity, I started reading the Cygwin source to understand what=
 was
> happening under parallel workloads. I used ChatGPT as an assistant while
> inspecting logs, dumps, source code and synchronization paths, but I
> reproduced,
> built and validated the changes locally myself.
>=20
> During the investigation, I reproduced a console-related failure path:
>=20
>   close_handle: CloseHandle(p->input_handle<0x0>) failed, Win32 error 6

That's ERROR_INVALID_HANDLE, which in and of itself is curious.

> Reviewing the console master-thread handle setup showed that
> get_duplicated_handle_set() assumed that all DuplicateHandle() calls
> succeeded, while cleanup could later attempt to close members of a parti=
ally
> initialized handle set.
>=20
> The attached patch makes handle acquisition all-or-nothing.
>=20
> It:
>=20
>   * initializes handle_set_t before duplication;
>   * changes get_duplicated_handle_set() to return bool;
>   * checks every DuplicateHandle() result;
>   * cleans up already duplicated handles if a later duplication fails;
>   * avoids starting the console master thread with an incomplete handle =
set;
>   * releases duplicated console handles if thread_sync_event duplication
> fails;
>   * makes close_handle_set() tolerate partially initialized handle sets.

While the premise and goal of it is good, I'm concerned about the shape of
the patch.

It does not defend why it introduces initialization that seems not to have
been necessary before (was it implicit? was initialization forgotten and
is the initialization fixing a real, unrelated bug?). Mixing unrelated
changes in a single patch makes it unnecessarily hard to review, and
therefore unnecessarily easy for bugs to sneak in.

Also, this patch introduces a _lot_ of repetitive code. That's not only
less than pleasing on the eye, it also opens the door for subtle bugs to
creep in undetected (or for unnecessarily repetitive fixes to be needed in
the future). Can you please try to make this code less repetitive? An
inline helper, or a closure, or even a preprocessor macro, should help
dramatically.

Ciao,
Johannes

>=20
> The patch does not intentionally change console synchronization semantic=
s.
>=20
> I tested this against the current official newlib-cygwin source.
>=20
> Upstream base:
>=20
>   81f45549e771fd4da7b88ad04bd9e6ec5c765d50
>=20
> Patch commit:
>=20
>   1d5fbfa8e
>   winsup: console: validate duplicated handle set for master thread
>=20
> The patch was also verified in both directions:
>=20
>   reverse apply against the patched HEAD: PASS
>   forward apply against the upstream parent: PASS
>=20
> The resulting current-master Cygwin DLL was built and tested locally.
>=20
> Runtime smoke tests:
>=20
>   true.exe   PASS
>   uname.exe  PASS
>=20
> I then installed the resulting DLL into the Cygwin runtime used by my ac=
tual
> LibreOffice development environment and tested real parallel LibreOffice
> builds:
>=20
>   make -j4   PASS, exit status 0, elapsed time 25 seconds
>   make -j8   PASS, exit status 0
>=20
> The -j8 run exercised the normal LibreOffice gbuild process tree, includ=
ing
> make, sh, touch, cp and other Cygwin utilities.
>=20
> I am submitting this because I believe that when an open-source failure =
path
> can be reproduced and hardened without changing intended behavior, it is
> worth
> trying to fix it rather than only working around it.
>=20
> I am not a Cygwin maintainer, so I would be grateful for review and any
> corrections needed to better match Cygwin conventions.
>=20
> Thank you for maintaining Cygwin.
>=20
> Regards,
> Chris Chen
> chenlijon@gmail.com
>=20

--8323329213404671617864402221624784--
