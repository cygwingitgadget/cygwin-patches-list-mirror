Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id 29A604BA2E0D
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 11:55:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 29A604BA2E0D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 29A604BA2E0D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772884505; cv=none;
	b=FvWIGu2UCELtjV5m6qupF8FCmTrqVu8Pl1V3YnD/uB24YIRqbRXWxXvtZGFka8qyS28/FcuNIMF9NJNYOAbq008QaA9BMAQCqz5v/FnICt9Qb3Kqpmzi7fKU8q9o8oUEG9czI8KdMEzkBJzJBCIdSSw4BZNYejUALwH4UfjnFwM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772884505; c=relaxed/simple;
	bh=NO/4+pctkbx08OCmtD3oXCxd2IKySZb1hcXgFED10QY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WaF8WAMMb9gSvqA3Al11XF8aCpeRNZcpQbExDURcWGjuJgts2TuTcX+wjRJh/8Qbi9VS+Pp98jkmR+KX7SojaETQLjWd04Cnm2HLjVVx0sLjs1/ra3zTLO3XlYgPmPlLrFJBVDR3JQ2CLkZvByF34UHv24f04ad9L7ser9dlJLk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 29A604BA2E0D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=slXEXMLr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772884498; x=1773489298;
	i=johannes.schindelin@gmx.de;
	bh=4CSPnkDMoMudwJAAqTVWEp8tHLWvyBHRmK8fk+aZ8iA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=slXEXMLr5d5dGqsdvjANQ8Grrqa2W5pESiR4dZ/BZBZNc2BubB7ANNxUHHsRtNoY
	 xLL8WNTNBhQP4irm7ln3rxYf6DxlKOin5kjQRQdsTuD+JusLIKDybzKft4YdaE7uu
	 Qv4C6Y3bfvA9j2iwIiSmrUuSoSqAXG5U6OxUTQ60X0s5pNBwIQdG5OaJ36nVV3+dB
	 N/6omAkNGLJFCl0meAttc7BmWbJ8sZCFvaTKs3fPhtm2+AddWpR8fAvc0SlVcASj8
	 5rFmPKvCLZoFNko8+BfiOqgFkaDOefmXmF57Afep3Tz9IsyRahYlAQwJEyrFQM/95
	 txhyqZGHCJPZ3pjT1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1vsodn41ow-005WJH; Sat, 07
 Mar 2026 12:54:58 +0100
Date: Sat, 7 Mar 2026 12:54:55 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/4] Add support for OpenConsole.exe
In-Reply-To: <20260306100503.787b2f6feb902036a2103fea@nifty.ne.jp>
Message-ID: <7d5cf285-ce5e-69c8-c87b-228d07db19fe@gmx.de>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp> <257059f0-abeb-2109-9b6e-a4683deedb14@gmx.de> <20260306100503.787b2f6feb902036a2103fea@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6l06Dj8SK3tEmQ/HyDws3UOxSI4VyE6RGpVwVFjLlDmPP3oWCu9
 F9GMX329aruEBceiHzmT4Zjm0wKP8yFYmHaTgAYIfzhZ2tPSDQOnfxB6Y55ccfEIIXinXg2
 6cEwfC9FA9xWJGeT3jFgrNhRJvPc7arVE0fivBMAVEd75zZveX6kkDPkvIhndwFZdbhSttk
 TU2qywn1Rl9FY3OlsVH9g==
UI-OutboundReport: notjunk:1;M01:P0:ugXZZlr7bWY=;wvP7l5NLF2E08lTGUxHKtHEyBZv
 8Y8sV4Bn7oiG+7cNlxZ7rDQMWUacKWjt/ELdf/DwwfZky47mS4F28VSGIb4vP2qRkIxuqEP6i
 eaKW6VJFUIsAtli+Y/fCE0H61UjsZ5Tp9sj6/sJEMb27Xlun33KyaDUA9By4GT6ccB3i/dvzf
 PMMGwMwHi27Ohv74/66vDAxpyrw0kOGOdpAdx8Fa0z5C9MZQZmlPgkNqZb/GUoY1GJ5RpSahs
 1Iz9lC+LRUu3JkKpdnsnma6Baz0siiPq0bfBEY4huayD1qJS0U01QxkG2fNAJk3GQh0s7SAUO
 wHygBWUUEhqXR9daL48vAIDYF+Jkv2BLMh3VR67BgHBbb5IVAjOGe1Benb9+9ZHFn9y+7Chl/
 lMtf5Ox89i1QvhP+hWrEJV4ojL+T0UvnU0mwu4d+DTb4F77Ctxm/h7dTnXMMjK4kwidw3JS8J
 PPFzVen4LMHuJnqw7+PNC6TXBEYTWlz2CNQcKUQ5NCPCrDdU7BJVRw8otT4jPsvochIz9K9zE
 mouErxRRmGF9JwIMve0s+nqH24SXTWyZsDOjmtHoxw0W+MgS8deD/+Zn2b6eueUIKEUKspZFA
 3YAOZVfsWQjSr6swZX0sfetSSMzGvNlrkrWsny5L8bKVNanOvF1gGGDxvjOVYn1V9toDWlwWm
 q0TKKAul7DFyYejwGJOUnrhZNDOTIE3+3xrQTR9nAsVkA+6VTOGzUUmRw6cMmux2BvjRAD0nq
 +QOqqwRllwOk1LwNMX+jEQl+dDM9fzwi2mvyUCfHBZwX5xRZRVp18vyYOwU2g73NcUhs6VTU4
 Tmw/BQGe3L678u2K+MSrqoqfDi1uwhhOIFyeueLtefr8SPySFd9Mdzgwk40AuH5Rz3QL3KRSi
 Y18WuPvmcubu7ahrCwiwOxxyj5dmcIwJ+Fn0YWwWKPRrNGPEGda80eydrfUYcfIr8+Daq0Nai
 HAvi5PDf075N9Rjw6Yc3gtSk/eLLHzp/zju5hMa/9p4aElvZ/OvYtEgJsr7wRH7YX7NRZWtlM
 2S9LSbQucK3P+abiDD05Ps+idR5/tPuIjt5/Mywfa+WZtgsGztK4OgdkjRqWdqmqqpNYKeSr4
 aZwcN2QXY3Hig7jdRYB+fnReD7nrcijPNID3IweZtnxb+M5JJnApX28nzOKubw6qzNX3WKPb0
 BQ63YLOJmncRqxblUV/LWSKL+xu30+8ogFa4CYFibb63veUCTtGc6FGVRfKyHJigAGmcdh9xp
 iPBbebVld4Su2KJdD9Rdr9KIn4+Et28O5Qs/T3ODQKRl2E648wpd3QSPwJZMTnPtIW2L1J1nq
 nedSzc3yqpFS2cKkFxL+t+G7mYOadEPQfOJtNMBTCO/K9bowLMaOOp06Dijr+2AR0yEkCSEwx
 lD+5au2ZXlxI+OIr+dGMCrL6EYuAkrxQg6/5y+C9p6PU8tCGlZ+eKOSd05RQsNCn7vRgtsqlU
 +FqQtfbrPGF+DOWsmcsJu1IpubhZ9f9ZFZnDniRS47lFjyn3OfsXrR4iZB1wZgNCDMxrJwn9/
 iY2vR72MWK9nPtzgUyIE/NzsE0FbTECVvIppTuqarLruCF79nHqWVCCbpYa9uxFeSZKeUBXUF
 bwx4rY0sQ1J5/QJYnl9z0Swed8uEBhY4i4P2AbALdt+VQFkdoAhkeouf44Yc/WDcuUT1PIYiL
 7/nPzb5KE0fnXzHXq4lQ76Hwbx5hUk953YmmggbLHMObppoojowTOXO4w9q01ZRxp9H1xvidn
 CRD1jUw23CjTu1P9TIABLa50wDYQkgkkyaRkgO1IRkwNZ3PVYBcupTAyB5Xi6lJESZ7IJlNfK
 WENMNmsDfnACHAl65M3xAAyPmrAh53EiTxrxM1eOMUXAAwoVyg6brOn7B9CL7ND3az9J0GEBX
 ObuI0rB1350cq40BXtDDruYHCUxnEtesykwGygSIttSXcbcJUT/vwvNlmUaacrkhCzvEgXx01
 EKR+Dm4+tNyQFxjCPf4c74BlS/QFysnIAA08w/DU0es8r/VEB3UwPGyVKRlnYSHFj8zBWJ+Hf
 o+sbb+KaUL6TlWT7eBds9FHcQj3AJa6xmGqvBVsE2zZF+jJ+KuCMbPUHGTdcFiUo6hqMxtfrm
 gZAou3JFkDVfFqsfHoKXglmJkY/CPjuLfxAbfC68PvmScCWnHcBGDfsWbsL7ATWpKYIkDx4JA
 s2F5g0DoW4vNYoHn9fynYzXlqeIItZdiyATc79v50eaTVIwKCU/pr42R3T4B2pptBD3iFva03
 /RJolc1/1hHQNxebwrLjWTF8/t8B9s61moGKAMFDJYHYvNhWKXLjbiVlHzBSMUtqBwZifmnR7
 YdvsSe3d1i71LDgpSHbjHSpK4Luln9hm+j29xhY5er3Uk3sFjst6mrrWgwV4BL6bsHAiPpXQm
 Swq48E4Aa4emWLI6uX9+jTMhE4JZ4Km0Et0fk5Eb/zshw1igHqCTyeTYKFPFSK8ouR1doyI7q
 KX5fFU5xYfEmUFaLNQ/quJwoiRK1l4+q1aQU9oeDifuvA1BYLwYO7Qq2QqLCk16QFO/7VCTnT
 r6h9kVL21Jn8fohVYeW7x7adNZH2JS7nRX3hdp4/3QrggZSC3dFq//W6JmA15XNKizxfc0Xof
 1dasBJRWfIc40h3vcqSmyWomrROwToTESHWJq2n5QkwT4rTQ/4H6quUn8ysIe/L4tPbCkHTLE
 ehR9MQtxZTQ0VfCW3cVkVgVw/Y5rP3XoCO7V9aOsetGpEwrCs9ZNtLLZ4+OnEvlvGDf5M/lj2
 lL/dS73QAtMUS7G1yMcRewupDequ/OP8OH6bxaXbHe65vfjEKYh0EyDY6kJGTx9jJkHbZCfPg
 cKKo0MKidNqP1G2DZT4jjHyFic+ReRA68O2xLm7sTxzwTtPDjLtR4KxFLMbgWXMywhW10IbCe
 EGyfQzlNnxeAx1V9Ah/kmyb5wvG5dMZ08LRmgbTt3jfs7zuAZ5ALGuxsx56OALufOXo5EWa30
 TxkA+eBEFspUw0YSZa/FzJMXEsx1VbeXqkZ4leWl33wykBsolkiJOALLlgaiS0zCit727RXB3
 R2SyLisb1PH0kUrPms5FGW0YYcOszr0Buxttm1JKKSstxDbyX7LcwHD9jvH1D7JLQgya5xbrz
 C6Ka9euqhkwyKNx2ieRpzMaptXjeqZXfLH9I096yUBwmZmu7R5irAoXd5nP+U49dvy0NenETN
 mkbF0tT9MS8iaJJ0h4nUn1Mr8uRGFiIRHmTmu97+3uyaTmuCaRaUrXSaB1/URUN2t0MFXj/Fr
 jKp59iBVRbJ0LlNIBNVw6NfRn/M2tG/UkbcBDNeXU9aJ7c2okKw0VEgurggUEcjY5+t/zPi0b
 FmBCJcivw7f/8IalhENeHX6s4JOhWb6NJivNpVf2hKlOHeiHgOyy5WIAPGaCfoytqw9/VRHLo
 C4f3EeSADg84tS7IFgEVZTGggBM1A+dZG8jZ7QWyBGGlQTCPjG2Ev5hqfdtbpKym896o66QlR
 GWaas7rfheuopjvi8DtHcFNaRySNu987S48Hs6cCXz5JfdaFZNmvVEwrSmY3lG9Zhgt9zztAp
 NB9NHmWOZ7nZa3DenIAFQqa7LlDKIHm6PfbKf9G5LXRGXAdnBQXsiQ0c+Z8XsdI3up5TJJQuL
 +Oq8Llot5LKuGy1w+7CdMEfHT750E4/I666BrwTO1GF171eJXBs2KbsUJQAk033/3BCDuEhT4
 SRnA6EsidOkafhLPLhK8mMUYRyTtCHoKKZZ1jyzIeV7ITm9RvXSEN0bFSYbs2xWJhlOoWAgpI
 BSVqccg1HcHBgygoHIANcf2OArPXpHvGBDGJ52HGGURfbRZh3SFIhCjfv+YM8YHUCrGfFuRyF
 ZU65rNdDa1iF3sp+zOHv4uPwHSSdFqtm0TTvM4DjKTVxtqzuCpRKhwfV/L/sfmZaO0bK446mW
 SuEz63jPKcTjF0DOgv4PSMSnNW4wcYQBG1+9pWknvJUPQ8vjzo0Ju8xavFZ/HyCLDnsk3Ezkl
 5KirRh2+cTZqsVQUiWx6u3Fl7AwDs+f0EFdbNq2yggpt0xp91ZKQQ0A0T81V0VOF8O9T7XbEq
 M82gIjsErdxxjpC9woQE6jAMuIoitf6/5R6mNw9ZS+RxHP1hx4wNXkyxsn3WokMKDBczjI8f1
 YnY57SbaHnVOZNsLZ7StHKm1oLZOyonVTwo2WHN+sF7kv31xsK/LAc+vt1MrMXMb+0lkm3aHh
 ZLi0MCLkXjQ8yj/2aghWmhWhoDptD31TF4haFNbPiAd2fDVesHjdD8K6VoJZ2wFhYkeRz5PxD
 RHFojsKWCKWgMnpLFoLXRdlDaz3B2lyu05h7HHY0cqE6WDLMb5A2gjYVcxyHv8ZeOK3RkPqOc
 4s/AShenTP8+a7xxbNwicHOk4rkDZ3V6R8nOS3q56XP9BRhVazuW822iDcWpUbY697plkwOOi
 1Dq3JOmSCqKdZC6tXMVjS65h/EzOrog0xDbhtsFllk+M5w0ly0Ifj4DU2WrQHD+DUTApxdgWk
 Fs2i6jijmnDyd92P6Xn8X4ZMe3+OTRaVQhLrKkBo8Z2MZ3fQ0elCtrRZZCsI3QDuwikzQtoPX
 8hhI44FFd6Rk73drYlIFr1yEpOeJOilPm00RN9ecmhfT51DGjUMSY999rXmrUhVCpNXUNCiSM
 +WY5qJmrAd1+GnHCcnoPfFX6WZwn5aUxO7asFHNvGaPW2ZAg40UEpewT6bi7esRntwjB7N24w
 0BNYohLGLqeYwEMbjsF0MRPD5ciEYGSbYoz8e67lJ89Y8FletCtZs7oIP/xAn5n8/A3ibcTdP
 8IuvP11GJhJQhzRh8dD5yZEBmVxtxEgn4dlDyELMwUox3mS973VVuUC6H16/+DysHc5n2g7xd
 6awGfGlNQ0/pyxubo4wdRv6UlFelJPWgbgH7NsYe1FQqNDWj54VIHgWEASRUyFGn+sbxQC8fz
 QFAhEu1L6Rt64c8r4IuQWtOH+578zkm3/lHkU3PWqF6qfDgj0tVaQNM25NhLZ1n5lduh1bF5R
 VJogb1doEM/nGTYMnLpKm+tA1CY7ij0z1b2IwyLqIjAIGGPu+itCKVn2rksYRXSRD4avsVBZz
 Vie96q0n+7Ou7oyNooltsRaEv+GQinIQLgDMt++MkHvcH5uHfFno5prMjriLXAg9BMvwg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 6 Mar 2026, Takashi Yano wrote:

> On Tue, 3 Mar 2026 12:03:25 +0100 (CET)
> Johannes Schindelin wrote:
> >=20
> > On Sat, 28 Feb 2026, Takashi Yano wrote:
> >=20
> > > v4:
> > >   * Do not close pi.hProcess in CreatePseudoConsole_new()
> > >   * Modify handling of CSIc response
> > >=20
> > > Takashi Yano (4):
> > >   Cygwin: pty: Use OpenConsole.exe if available
> > >   Cygwin: pty: Update workaround for rlwrap for pseudo console
> > >   Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabl=
ed
> > >   Cygwin: pty: Fix the terminal state after leaving pcon
> >=20
> >  Three out of these four patches seem to be workarounds for bugs in
> >  OpenConsole.exe. The project is open-source and accepts PRs. Would it=
 not
> >  make _much_ more sense to contribute fixes for those bugs?
>=20
> Yeah, indeed. However, ...
>=20
> Cygwin: pty: Update workaround for rlwrap for pseudo console
> This is not a bug of OpenConsole.exe. This is for translation
> between POSIX terminall attribute and console mode.

Okay... I guess ;-)

> Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
> This may be a bug, however, by any chance, an intended behaviour.

The workaround, however, looks as if it invites problems. It's just going
too far into hack mode. It's assuming too much about being the single
actor.

If there is any chance, any whatsoever, to avoid this workaround, I think
we'll be a lot better off.

> Cygwin: pty: Fix the terminal state after leaving pcon
> Perhaps, this does not occur if the pseudo console is used as
> suggested by Microsoft.

Still. It is way too hacky, as it over-focuses on one particular mode that
might be stuck, who knows what other terminal modes might need the same
treatment "just in case". Even with just this single mode, a proper fix in
OpenConsole.exe would be much preferable, as it leaves a lot less room for
future regressions.

> Anyway, for now, since I don't succeed to build OpenConsole.exe
> in my environment, it is dificult to debug it by myself.

Admittedly I struggled with this, too. After cloning
https://github.com/microsoft/terminal I followed the documentation in
`docs/building.md` how to build in PowerShell.

In addition to the documented `git submodule update --init`, also needed
to run `nuget restore` and `dotnet restore`.

The I had to use PowerShell 7, a regular Windows PowerShell won't do. Even
after that, it failed the build (symptom: missing vcpkg dependencies), and
I had to launch my Visual Studio 2022 Community instance which pointed out
that I needed the WinUI workload (a hefty ~1.9G download).

Even after that, the build was failing because of "C1076: compiler limit:
internal heap limit reached": Apparently the default configuration is to
use a _massively_ parallel build which brings my poor little laptop to its
limits. I did manage, though, via this command-line (suggested by Claude
Opus 4.6 when I set it to the task of fixing that build):

  Invoke-OpenConsoleBuild /p:Platform=3Dx64 /p:Configuration=3DDebug /m:4 =
/p:ProcessorNumber=3D2

Note: I just verified that I could build it, I did not run any tests nor
did I look into the Ctrl+H problem yet.

Ciao,
Johannes
