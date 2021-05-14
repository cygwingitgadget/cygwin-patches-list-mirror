Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by sourceware.org (Postfix) with ESMTPS id 4871F3857033
 for <cygwin-patches@cygwin.com>; Fri, 14 May 2021 19:38:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4871F3857033
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1621021118;
 bh=GL3JqPNI4a877MhGgAq8UFcFirnAhDoWysTkVnSzK1Q=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=bAq38gxjYQ9Pij2SFFGarTMg5eFwNALCJRwu8pgfO0UBnHMis3pnFvIxwtcn9ovpu
 wz2ASIusoMpViSsW4dnfxIoJihInRig0BMJQrWyGcsaCfJSjXWNcDxx5Z38m3Oe5yq
 rVLJkSIOQpN0qT3lTCHXDmwhxpaiwW9DyBNfe6iA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.169.228] ([89.1.215.198]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1lmdZj3hlu-00ChV4; Fri, 14
 May 2021 21:38:37 +0200
Date: Fri, 14 May 2021 21:38:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Mingye Wang <arthur2e5@aosc.io>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: rewrite cmdline parser
In-Reply-To: <20210513131527.14904-1-arthur2e5@aosc.io>
Message-ID: <nycvar.QRO.7.76.6.2105142124390.57@tvgsbejvaqbjf.bet>
References: <20201107121221.6668-1-arthur2e5@aosc.io>
 <20210513131527.14904-1-arthur2e5@aosc.io>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tx3qbKFIyiUXqYk8cuqMa8GzlmTkpSUoxs9oDOFHGCzcM12tWmL
 BmdEBOY1fF161giUsOqVrwiM31UcROUc21zc+jIDc7aJF6K9EYEUvb2iecQ44CN0Tr9F8wM
 F/JDC36wM8FRRpFxrz7ko3yTncsviMo95Glt2Wu9mXYOfrGfKsjuTwu51QmQuN1mJtNYK5D
 zE0Kfb9gCFEonfCauVttg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fvQ/iI8Feq8=:ducC8vdxBqqmVM2QLyZyOz
 iYtrgjCnc+qiN1fr1Vc70RsaCSD1ieZuQaqDN853sifD2GgHWovYNctEotF+j7i6oEo2mcbD5
 EKTq0j0+hyY7AlbvAkrJ+W9mUhMPs4Ecol42ezs/y3bLXvXJ0ako3b5hdz6JN54ordW2cU4NJ
 BrnT06+tW3WCm2niIYYif3Imp0qGAlUh8PR+VmZeAZDaru+NgyHltqClV+mCynqRWom8ZrDcG
 rLmbg7ReOfHxmzaGNDNKuwdxSPDYR3oBLkZX438OL3A6rKioaX1VHqahQE6g6B2Ny86YeTz7F
 UZTef++kF8wAzU/daEVFLvtzDkOe+buelnNCZvPjcKEqBW7AQvT0DswbAk9wNyG6kmDSACje2
 TiGb9KerseJqscBnjG87OTV290YM/uqF9+DRNLy5PsvJP96BavW8i9KtevwpgQUT/JYJ4tx+E
 D6RSvI4hKj9XMlJRNefFuev/V7ssJdaUdhiPU5eSH91OxsghfyUcMfS729sKhqiHEyjuNBNVS
 /AfRhhz36DMkf50bhxwXJLWp0q8YFDPOSB+XjJoFXwL1we1lolVKBnMv5aamk14l2ikTTOxvX
 0ZH3iNNJN6hvhFRdTs1xKsdDpxzuDaaJayx1vQHXq/TZQ4VxP3ky5c4olxwCNOaZI/ZPcqtEX
 rqAuv57Nej2ka72+b5m8EMydFYK6gyq1SZdG9ZZVbiZGQ+ik6+KSBpzB9LKrmuE1Ps6JilpR3
 tZMya5GqCaZsgmdf1y+hgLXlC16j5xHpLNeItu5f3RvCo29QhISMYweTDcuHZKgt8H8zXm2yi
 9wnM26kRno5C+/6Eemwr8dLXVmM4JeSgL3NkRblq0apBPWf/6im9b3Z10VwrIieb+jP7fIPdU
 4HblN0hX8ibp02rdIfT4jiXhlSyEvnohCSeosfoEmOxkeOpFgeehWy1lIsbspTQe+C6xMUgln
 qaUeqpLyqX0+XooSRlHt/BNZ00QMR801RxVGZhi2O/AAlku/5VJa9olPqG340e4krmEZFEgxp
 IBSZ6eSw6psdJEOw7a/Slqs2X7SGdUsuqHAyrwxzO4Bvz171J9/X9lP1TSlpzc2mfF3uGxm5N
 rItiwUzJXmazfQaboEP4qWeec+WXR+OdSVzjdYUlgTYaT2AOzq40m8ZNmieiw0/kvi7zUXI4T
 INB1psl09izGxXUvPU/cziykIfJaYXu3wPuiRQAK/cw7F0btTVUY6pU31kLSRMFvOS020ZrPg
 2EYl3Hs9h4H1sP9Iv
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, MALFORMED_FREEMAIL, RCVD_IN_ABUSEAT,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 14 May 2021 19:38:43 -0000

Hi,

first of all: thank you for working on this. I have run afoul of the
(de-)quoting differences between MSVCRT and Cygwin on more than one
occasion.

Having said this, I hope to make it clear that I care about your work, and
I care about helping to make it as good as we can make it together.

It is a rather big patch, so you will hopefully forgive me for not making
it quite through it (yet). And I fear that my time is unfortunately so
limited that I will have to review it in a piecemeal fashion.

Below are a couple of reactions and suggestions to help you understand
where I am at, for now.

On Thu, 13 May 2021, Mingye Wang wrote:

> This commit rewrites the cmdline parser to achieve the following:
> * MSVCRT compatibility. Except for the single-quote handling (an
>   extension for compatibility with old Cygwin), the parser now
>   interprets option boundaries exactly like MSVCR since 2008. This fixes
>   the issue where our escaping does not work with our own parsing.

When I read this, I immediately think: This is probably going to break
backwards-compatibility, OMG this is making my life so much harder than it
already is.

But then I think: Maybe that's just poor phrasing? Maybe this is just an
opt-in behavior? So I get my hopes up.

But then I realize I should just ask, because the commit message does not
manage to answer this question: does this break backwards-compatibility?

I ask because as maintainer of Git for Windows (which bundles an MSYS2
runtime which is based on the Cygwin runtime), it is my responsibility to
take care of backwards-compatibility on behalf of the millions of users
out there.

> * Clarity. Since globify() is no longer responsible for handling the
>   opening and closing of quotes, the code is much simpler.
> * Sanity. The GLOB_NOCHECK flag is removed, so a failed glob correctly
>   returns the literal value. Without the change, anything path-like
>   would be garbled by globify's escaping.
> * A memory leak in the @file expansion is removed by rewriting it to use
>   a stack of buffers. This also simplifies the code since we no longer
>   have to move stuff. The "downside" is that tokens can no longer cross
>   file boundaries.

This bullet point sounds as if it cries out loud to be put into a separate
patch, accompanied by the corresponding refactored part of the diff.

>
> Some clarifications are made in the documentation for when globs are not
> expanded.

Likewise.

>
> The change fixes two complaints of mine:
> * That cygwin is incompatible with its own escape.[1]
> * That there is no way to echo `C:\"` from win32.[2]
>   [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
>   [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html
>
> (It's never the point to spawn cygwin32 from cygwin64. Consistency
> matters: with yourself always, and with the outside world when you are
> supposed to.)
>
> This is the sixth version of the patch, having fixed issues with
> compilation, rebased to the latest version, and tested by replacing
> cygwin1.dll. I provide all my patches to Cygwin,
> including this one and all future ones, under the 2-clause BSD license.
> ---
>  winsup/cygwin/dcrt0.cc   | 299 +--------------------------------
>  winsup/cygwin/winf.cc    | 351 ++++++++++++++++++++++++++++++++++++++-

This looks like it might be an almost literal copy. With that amount of
lines, it is real hard for any reader to figure out what remained the same
(simply copied over) and what was changed. As a consequence, subtle bugs
have an easy time to hide, which makes me uneasy.

I would like to encourage you to disentangle these separate concerns:

- moving code (`git diff --color-moved` should tell the reader that
  nothing was edited)

- clarifying documentation

- removing GLOB_NOCHECK

- introducing an MSVCRT-compatible mode (and make it opt-in!)

- whatever else I missed in the 304 deleted and 367 inserted lines (which
  is a tough read, and I have to admit that my attention faded after about
  a sixth of the patch)

In essence, pretend that you are a reviewer who wants to help by ensuring
that this patch (series) does not break anything, and that it does
everything as intended (i.e. no subtle bugs are lurking in there). Now,
how would you like the series to be presented (and I keep referring to it
as a _series_ because that's what it should be, for readability). Ideally
it would be a series of patches that tell an interesting story, in a
manner of speaking.

Thank you,
Dscho

>  winsup/cygwin/winf.h     |   4 +-
>  winsup/cygwin/winsup.h   |   7 +-
>  winsup/doc/cygwinenv.xml |   8 +-
>  winsup/doc/faq-api.xml   |   2 +-
>  6 files changed, 367 insertions(+), 304 deletions(-)
>
> [... snip patch ...]
