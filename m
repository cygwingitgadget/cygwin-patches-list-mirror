Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by sourceware.org (Postfix) with ESMTPS id 501103857C48
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 11:15:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 501103857C48
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599045343;
 bh=UxV4m/jpPC2nQSGQ6tEozSMbwTj3KEYZvMpD2X3gJKc=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=atPTCXcqQjM2+vt1czsetYlzOocBu9KvKllvReUe+pZSbyQdtOgu9EHqBcDiEJQag
 oTbtqinxZIqnLUGd4KM9ndGOJlXT7MhsprzxHM5EX0DGnhDUlRDKKCFUDWmeqcXKJf
 tdPHjdiNKv9QQb350fgvpWKTOxjgPu0xUNmKXFqI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.253]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAOJP-1kJA2f43cB-00Bq5m; Wed, 02
 Sep 2020 13:15:43 +0200
Date: Wed, 2 Sep 2020 08:26:04 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
In-Reply-To: <20200902184104.a4a754ab3827352eab126e5c@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2009020822590.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902184104.a4a754ab3827352eab126e5c@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m9bzDLOVZLwVeEd1Ei9XK7FXpeN7i+JdzFpcCaVLB0xRKdhNzN6
 R25W/HC6SNyF2a8znU/Fx1+IJX0CsVf8XuiM1CyzU78y9TDUhmys7g80LlIBZv/uv0tNmn2
 qyls0ZAP5JVbS2IUYEI9yTsvbE2n9h4oiASKu914uVCf5F0pXP578d4eNjrgKDGeWJkF6n5
 a8ghmQt6v6omoU54qmKEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wECN0E9dAjM=:6RDWHuQ7hV0gi4y4RqR4+n
 PGId0WJOSLq46+3rxgin+XIBdkDSUhup6Run3JL4IgYCztD0mY+um1797VgiGleR4gbB7L6dn
 ZwCxoxmSTu0ayx50haozfdjbZHMxvVsnM0ak8XXYGlt52oHvZM0PjE5GtMbijGawr6W2IowqB
 z2v5acdaISERwy5ay+ntffHXaTfuTMZhtaFdNNr694X0hswCzAyGWjbSVLte6Cz069iWgcAAZ
 JMzj16asv3ty0lMUH4M4NFgpXEOQgaVEVijgvvyiXbfBipzzf28wcUeZni29ttz1fzDEXnQlg
 aOHjDdstu0Dd6GPITopOUBaL5zV4MlJ4JZeFCb0QffR1IAoS8x1HY3Dr7X+oR571tS4XN+6fT
 vSKOEot3utON2ACdHUPQOFr2Q0DQqhVcFIulbVy1ZqGUhMvyrNFfkK6GkSo84mYDyapE4VaoZ
 SgMS9r50MY9UkhfpuoJYnaeE52yu6FcJdlnhjUqtZCQ2d8CUwTXWWNhXI7vX4ecdUmhJfdzfJ
 HjlNgM581yxsz/gsGqWzuJ2PoSsrI4rn8El9RSDwddzDpzZB5XIy4Rx8GgFH1lm+tNWbg76jK
 56em9FdoSs2NNi8HsWOeN5VkLhcHDpwOKPSNlgtFFCeoaWn2gvfhYfmFVmeE2senFzc9GSFZ9
 AZNPnnBu++7vMIYQKK5PMaMl0VdSq5MQBCJBC9GVev6MVTeBxbehaDTEaitpD3n+MHWrg/v3D
 +MKWMEnn85/97VD7Jbi2MbW+9IXG4g4gdsj4wAg4kjzKmchLIkGCE9CvzWJNpJ6smRGnlIWpf
 vbjRZmm7V4u8hQc+yCvFCojpbCpPYCAfvIguqAR/ga2K2sIZAjJkxfwkPS2C/lYPAh2PjnuZJ
 W1e3g163EXKQ/TqExDOdjn2/089EkzdtvZclYGkl5ayXexlgGVZ8krDuXEBFczqVzdvi7L6Az
 gd+UMHweHhor/mCieidepNaDgnOiHILWmvUoT4Xo9CR1+1OLbUPfS/8kAne3ao4PzIPzC/d7R
 OyxoDoJBq8HizMotPdvteJPOlbjFDaxqwHesh3QaQqqqQPXdeDej/zzT2R1qnUzsCN1gHDssT
 pesMwEWaLycCAAM0E4g42tqw9Rnx1BCb+x5EtjrQp5u8GXIkthB4Rx1p1yzd369Rq0SqCZWaU
 rWzNSGMbo5QyQJIwydUOIHLJnqf2ecbIYkHwaehCrw7A/IQtYOSyHMtIQLc6LwCxTNR3sNJoK
 R112nI/PCWVw21xHtaWWMOIHiQwdO7aN3xZk4KQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
 DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 02 Sep 2020 11:15:53 -0000

Hi Takashi,

On Wed, 2 Sep 2020, Takashi Yano via Cygwin-patches wrote:

> On Wed, 2 Sep 2020 10:30:14 +0200
> Corinna Vinschen wrote:
> > On Sep  1 18:19, Johannes Schindelin wrote:
> > > When `LANG=3Den_US.UTF-8`, the detected `LCID` is 0x0409, which is
> > > correct, but after that (at least if Pseudo Console support is enabl=
ed),
> > > we try to find the default code page for that `LCID`, which is ASCII
> > > (437). Subsequently, we set the Console output code page to that val=
ue,
> > > completely ignoring that we wanted to use UTF-8.
> > >
> > > Let's not ignore the specifically asked-for UTF-8 character set.
> > >
> > > While at it, let's also set the Console output code page even if Pse=
udo
> > > Console support is disabled; contrary to the behavior of v3.0.7, the
> > > Console output code page is not ignored in that case.
> > >
> > > The most common symptom would be that console applications which do =
not
> > > specifically call `SetConsoleOutputCP()` but output UTF-8-encoded te=
xt
> > > seem to be broken with v3.1.x when they worked plenty fine with v3.0=
.x.
> > >
> > > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > > https://github.com/msys2/MSYS2-packages/issues/2012,
> > > https://github.com/rust-lang/cargo/issues/8369,
> > > https://github.com/git-for-windows/git/issues/2734,
> > > https://github.com/git-for-windows/git/issues/2793,
> > > https://github.com/git-for-windows/git/issues/2792, and possibly qui=
te a
> > > few others.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> >
> > Ok guys, I'm not opposed to this change in terms of its result,
>
> I am sorry, but I cannot agree with Johannes's patch.
>
> For example, code page in Japan is CP932 by default.
> In this case, cmd.exe, netsh.exe and so on are generate
> messages in Japanese.
>
> If the code page is set to CP_UTF8, messages from such
> commands changes to english. I guess similar things happen
> for other locales.
>
> I do not prefer this result.
>
> Furthermore, I looked into the issue:
> https://github.com/git-for-windows/git/issues/2734
> and I found that git-for-windows always use utf-8
> encoding even if the locale is ja_JP.CP932.
> It does not change coding based on locale or code
> page.
>
> Even with Johannes's patch, if mintty is started with
> locale ja_JP.CP932, the file name will be garbled
> bacause SetConsoleOutputCP(CP_UTF8) will not be called.
>
> IMHO, it is the problem of git-for-windows rather
> than cygwin and msys2.
>
> To make current version of git-for-windows work, it is
> necessary to set code page to CP_UTF8 regardless locale.
> This does not make sense at all.

You are misrepresenting the problem. It has nothing to do with Git for
Windows. For example, if you run tests in an Angular project inside
Cygwin's MinTTY, the output will be garbled because node.js (or the
Angular libraries, I don't know) will interpret `LANG` or something.

This is a much bigger problem than you make it sound. The console
applications that do _not_ call `SetConsoleOutputCP()` are sooooo
ubiquituous. I think you are underestimating that problem rather
dramatically.

Ciao,
Johannes
