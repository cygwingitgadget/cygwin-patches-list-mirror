Return-Path: <SRS0=st34=CW=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 77CF33858D35
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 15:50:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 77CF33858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688485822; x=1689090622; i=johannes.schindelin@gmx.de;
 bh=qX/a0Scu0zU+Lh3RNxpwJ4O/5GjjnMspZF+qo7XvT/4=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=OL2SOmMLAZInHP1j4nfUo4QTbzXdRRdsAzl4MR1GWhEQo5E1x0ZNcXU9dsC7bgY8Aj5fbEK
 zyjGZFG2PPirj/lVwSVANtTBWZQhnPwKcJmKlXlsRYDSPv7dHA0EaCnbUc0kRenKE89a6wvHr
 dpabWZE1zYkyPsUV+gVr/LNGw07dcNwnQf7n090QHurCUTZwjGqs4rpFSeY0N80eCJ95KUSJa
 5x6U+XLkNrpq45v0lJWlBBhjRjYTM6rRK5hHCwHm+JrF+jRAQWvzCiizGTA4W4wfsRWUuWXD1
 w8Q+hRRY6nSMxc52jnh52HIn0WiJIpJ+cYDG7GR9rcFq96bvkf6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.221]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1qEAdu3Ur9-00HSSm; Tue, 04
 Jul 2023 17:50:21 +0200
Date: Tue, 4 Jul 2023 17:50:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeremy Drake <cygwin@jdrake.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
In-Reply-To: <alpine.BSO.2.21.2306281142570.97921@resin.csoft.net>
Message-ID: <968b569c-02a7-b77a-7fde-236a7f12e85b@gmx.de>
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de> <alpine.BSO.2.21.2306281142570.97921@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IhBpjts4N7rTpQbtd+v9NJ0VTqoOFlihhjrw5Q0IV6d0pqaWbHE
 g2mQ/uqThXnn/SbR5107bJP7a4VROHTiqTJcKfWJKQ8UOkxIKFaBMR6vl4eq60enNyebbjn
 WaAWZiJdGNM0FTht48vLjNJV0KwnF6KZ8qAN6/QRvsGh0k1jk6Viq9Qw4iVH4CJtAwnw2If
 t4g1G4z7X1b1JJ2IIl8nQ==
UI-OutboundReport: notjunk:1;M01:P0:qXMJEEA5mQs=;Ey3bEpCf8jSuYjfp/j0WyYHNqkJ
 aMR8oxlyxCYIeO1WkyAUNgY6n6O6UWd2wASGcpcDmH3JOv7ge2NgJxcKDNsFHCeWIVuE+7frQ
 usza+2Dpn/JWgx/T+b4GfZOdN0a8KPqiQSkuQT9M2dRexVDfSPAADz5p39o8VTdnHvOis8dnL
 JfTnloaef54fhpTCwkfOsxpZRvQpJzPgDMrqKveFrG+mwsrqZWkzudL6M3nEqnv2+/liJ/xvN
 keu7VfOwpAw6aU9skIlSWTA1TgBmfjna8PkLhS60UcdSZlOAm/ueW12PiTGjwhGj48lIo2P/q
 1lGhfdwN2+Z3bLQgtIR8SFVaSYf+2vPZ+KfBKBErbbAyrwAwNszXcKd6kXEvs7XvA9FG7jFih
 9X1tei0XPLddbSWhA1Puoeq+HIAsMY6ErjC4tiT4c7KtLgiPZ4CkdapUxPbjgn3hxgtzl0Gax
 cYrOCrNBr63tnCEBKMee5ZF32BrVh9Vys+QbKp9liujX/UueBZMDWKSDSGfUm+NOvoM3sHUrp
 JKxQo8FPBXCEDTDx6GpgaPLlclDDd8ZH0VY6cfMtrD9tHtDBNMsbOs+AwbrJwWrnhs3/5uRbB
 oq9YherFDQfghENY4vGWWtk/U9CnAu6+5c5Qpl9HbFHwDnZjwen7qMGyDYWzOqMOGxhjdi4jn
 9QB11Z++vluMoFld4FCU5l6danQNscw7IcNKo2RoqDDpTiWF+NCggUn1PjzqARzAKbwyKF3uF
 cx5iy5QRUfqXk14PSLTGOfOasJlOrgp4pDnDN2kwE095p4kORxwZSlaM2kjBD3+mLQzwNulEC
 lmejM8sLJP0yG1BjOW7Tv1d8m8+4VCevbhGccAkrH1jBz9y2gAJ65SA7CmCciDrrMNqfKhwoA
 Sy+v7x5HVqU8Cf3tSPI4p8XATxWhGmYfaqRfloZSO+P3fJdlWtayURyqiP8Gxzr5BoH4AyUBs
 ZzX6nKHSQOM5ZICIIcT+XSysCPE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jeremy,

On Wed, 28 Jun 2023, Jeremy Drake wrote:

> On Tue, 27 Jun 2023, Johannes Schindelin wrote:
>
> > In 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
> > the code of `readlinkat()` was adjusted to align the `errno` with Linu=
x'
> > behavior.
> >
> > 	I noticed this issue when one of my workflows failed consistently
> > 	while trying to untar an archive containing a symbolic link and
> > 	claiming this:
> >
> > 		Cannot change mode to rwxr-xr-x: Not a directory
> >
>
> I wonder if this is related to the issue from the thread
> https://cygwin.com/pipermail/cygwin/2023-May/253738.html (sounds like it=
).

For reference, this is the link I am looking at (because it has superior
thread navigation):
https://inbox.sourceware.org/cygwin/CAJQQdJjUarc1hkZCVX-GWD=3DCq7XF4bnWE+A=
rzLxrUqWWpC7=3Drg@mail.gmail.com/T/#t

And yes, it looks like it's that very same issue.

> If so, tar was
> rebuilt to pick up the new behavior in 3.4.7 (presumably via configure
> checks), it may need another rebuild to pick up the fixed behavior after
> this fix.

Likely? But then, the patch in question should not _break_ the re-built
`tar`. Or does it?

Ciao,
Johannes
