Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id A5E89385703C
	for <cygwin-patches@cygwin.com>; Sun, 23 Oct 2022 20:48:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A5E89385703C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1666558091;
	bh=V3Hg7c5VpUhh/y4juTFALSokxHnmnmbGjY1rBWlnjHA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=jpGrz3GTGmrmzPl0hnVh82ppSN8eUvel3Z5ogfz5oXJIu6IKx9b0i4JqN9pTc8OKx
	 10T3j8KPJuVYj0KeroPX/fePE7nPcaS4GMsOLEkd9hCPrKnEcf5KW4+d+kURPv33l9
	 0JVb3hVv7MvWuUVEBnUo6jM8b9Zj0Vzur9BGz/C4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.182.144] ([213.196.212.100]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDNl-1pRWUv3wvX-00qf49; Sun, 23
 Oct 2022 22:48:10 +0200
Date: Sun, 23 Oct 2022 22:48:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix `Bad address` when running `cmd /c [...]`
In-Reply-To: <20221022150754.b60ed857badc06a7648c7dc3@nifty.ne.jp>
Message-ID: <o352sop3-q0r0-r5r2-qqr9-6oqp2973s5r9@tzk.qr>
References: <8rqs6n82-0oq9-2200-944n-74s7o699385o@tzk.qr> <20221022103639.0be6d01709fc99d06b3d0d41@nifty.ne.jp> <20221022105406.12f2c65e497e80df4014a8fb@nifty.ne.jp> <20221022143709.b54643c7b29b3d6260382e85@nifty.ne.jp> <9E4B94F4-2E88-4B95-AEB0-24B083662D32@gmx.de>
 <20221022150754.b60ed857badc06a7648c7dc3@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mmptMMiInR742jkmuwSxiPuL78AIcUDt1sFt4zik1abaUpA8R0i
 hnayyIsOeJAaa8HDqFHErnhg75BIkzP/c/X/8ozKOx7gDehg92r94Kii4mYdXm8iTLVuSUd
 2pIHlCYYrkrBQQIZt6EmJK+vF+a4TyQGwtwlYnBDBMYnKF70Vfti2RtwWhhsMpxTqVFQmo8
 Ghlyy9F3Rar60QT/4mjGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uB8pYAmvsc8=:9F9KStDASCE+Z28xPxoC+H
 Ki3muLhSCiPTnqHsSTRSLaI7od4yQemEEsh2R1sOaQ8cwqkY2Bqsh8Q3uyGZPLPVbRFXJdd6e
 ExdaVx5wlHE1tQp7AUdpODkPeRrfTwab/ahyOc/O6ZDrNK6uKj7tfbpYv9vfotqNzMSJkYcHn
 3W5rTHzcT+wEtDu204K6sC3hMNB7L/6Jf1uQLwSVOaX0d3LXDXBfynFq3+V/v1OLyV+oK2DcV
 eYpobA/SgKFCWnUhr9b3GGZF/jtiA+FqL3VQjIYeliS38YV4VQ2jrssBgvMgmCJo64oZcIKFN
 942R3wjwb1MOTAPYRpJfUld5+lWzjST3b/j5Q1iNhzpw4Md/p/zaD18cNc7M50jrg9X1y4HwG
 7GbYjcldHToc8zKP1DaPvFAzZriLYvmhIp5g1bsl5HMEqAhJqj9HqHADC5Bqmgvte3pxWBAVc
 2v/rmIg07NaHoNawg+6q3FbY94dfS+VenEUqb+HNU6ODU9MD3u85HbsEUzRAz7gTlQL7dHNcm
 TCfo+73Dg+StCZXPYT6auGDBLXjdrbBT1aZ/4RAxVqef6M4ZTxtulKMrI5ok6EmDJrMDoGIZ+
 PA6Dr8oHOIHYcPOd5NxeBschJv5f6Ae15fVTynRNxQO8t+3z677I0/jnXdls+PjnowvwUmJU1
 rv+Waho43l9gxgAENFQ+GssxI8nNanAGMOgaBiYFE0/La820HUNgOzQHJbg2gukFSM3mIHDoc
 dWVaVXrHuoCogKWxX/RknQ4XGBbvqPBAkGHPykgMCbQvYvtojRUwaTmOqe5y1APQ9BajPLOMu
 pIu5ph1iuiLBudXKcoisQSf2l97Tegmqu8GtADAsAI7QeuPnvajAcmrPEF23UZb6/C4inNLSM
 BqNQswXnHhL+AchKQtN8aJCecEtTlzlB0Un8lVUZ0Zny3VuaFeGEGAK6Yu/ePLYf0afCdWH2k
 WbNdA/N9EjDaqP4/AR1IiGhootq4Hijwlp6ItZHB6AE+JS7o45IEgVo/gIvCVCm4d26PIguSl
 jHk7vQXyD6AftNoOFTLilyuvMnVZzousWQm7YoMIX6VNfMrHNHIjGNkD+9O9XzuhudEUtUduF
 dIsYshJOdGEp2besiXk1l3126k8Ze13NWNzBDEOgxFljgjiDBWnCvenKbr9IMRbQy9t5MhBx5
 XTri6PqtQ6rnss+bwh/lTykjUaEroedvUT5v0+8cMa1xVJdX1ZRpPLzqoy6xSnF5ilpC7QuYV
 bG5D1MRfFQuK5jF8RFQEGofe/UOGkS5gXpy+c09rCTay9dVftZ8F/L9dN3Rwz47Mp/nf0AciG
 SSRaHAvrI4iavVVgKXaXVOaX/5WqywjC09PuhUMgnVE1KZVyxE/VGfrpPVWSnUY7S43NNeB9X
 FLZ/orOTK5HZ+z2L3zCK85OhHSlfcfnAzEKC1zzZbgiLtNM7tnCXF0yIJDx1HQIBadnquiA15
 UX/CKklJQHu0xovc5LKi8iBpmll6rK+O7g0AKnD8b6BqNmytwCGsY+kiQegaix1vMALUx0NcX
 MQVe/rrbEcDWRqQwj9/nRDSvqLS/qkMwNS4ctkMdju65jcbcFr3JgLXd9wqZbodVUpQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 22 Oct 2022, Takashi Yano wrote:

> On Sat, 22 Oct 2022 07:55:53 +0200
> Johannes Schindelin wrote:
> > It's not very nice to simply drop my work, and then not even link to y=
our "counter".
>
> I am sorry, however, your patch can be indirectly reached
> via link https://github.com/msys2/msys2-runtime/issues/108
> in my counter patch.

You misunderstand what I wrote.

You answered the question "where is the link _from_ your 'counter' to the
original patch?"

But the concern was "you did not link _to_ your 'counter'".

For posterity, here is that link:
https://github.com/cygwin/cygwin/commit/08281cf4cca9593adcc3d30184322dc60f=
a1cd61

Ciao,
Johannes

P.S.: I quote "counter" because what you meant is actually a counter
proposal, not a counter (which is typically a variable that is used to
count things). It's one more irritating thing in a thread that was not
exactly short on those things. Quite frustrating.

