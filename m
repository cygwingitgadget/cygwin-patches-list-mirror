Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id 240843894C2E
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 14:02:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 240843894C2E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599055349;
 bh=sOdaflWwtBj/5i/xuiBhRrdZ1CYyhmgTJIdgg0WNKAo=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=K/IaoqTDP3S9Dl+gn/bT7QZujB25euYFEwgkXybuAdjLh+xNQN6ILLrdQzzMBZJpE
 Xlkt47+qPu778hG4um8OYNIXt+l6mw0x46+GVE74TUIafaW6owFUCngBgcGXh3wPqw
 N1D0SWHvwLEnRTCRN5M5Z/G88nlSFn4c0jkLVNeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.253]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1kGVbk2fpd-005oF6; Wed, 02
 Sep 2020 16:02:29 +0200
Date: Wed, 2 Sep 2020 11:12:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
In-Reply-To: <20200902220600.8e4e994b275545bcfafa1802@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2009021111190.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200902083014.GH4127@calimero.vinschen.de>
 <20200902184104.a4a754ab3827352eab126e5c@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009020822590.56@tvgsbejvaqbjf.bet>
 <20200902220600.8e4e994b275545bcfafa1802@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uDMaPkX2M9OyF0OP8CUngepHofcAJUnkg8+3gt8kqmIg3qEIdS2
 jUuvXPqcjwplGw+fCokXHLnRjgy3pWPU7dfo3/NGbgblSuEcJiaTWkzEDE6o9LJ/jLYQN9N
 CwNggGUsoRgiMCu/gKkZDxVCAuDpbv5aC1U1oun/BMNfBKuXhlwUUTLpNOFVR62yVIfrfI6
 XyAowWgpB+s/B/JjbLb1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yvqx9RitfsQ=:DyZJn5b6u8zwI1kZfxR2vF
 mJxoIcKVZ9nzQCnEPmw/Wv/7Ysn0YXdYiu+dXonRmJpcLzG54hopGIZSsDaLYgeEy1z/Jt+87
 d239osIRYHihBBSE1qUG9h1ht9fMGkoISD0PGXy691E1qDscBKcI5s7l3POKtejZrbR9Xh50t
 veLdgVph2bKk7iPc2zaeIz7rM+nQHOMSfcxyPH9EhJHHaIe6N952HXByTyRF3d6QXlJDnMK1L
 kKxql+K7woRRrF+rfBtumATdbRcrI6g/xYrm3UD5FYLnYDQP5lpjlQ+l0qCexYku+h1GQu70O
 qRLM9Rt3rdOTiaZ2YGkKeENTpYt7gHDAOBEv9iO356YhjgXq0TVzZkiVcaGveFY3Obi9Iakok
 IREmwIgkucyNWEYooyEeW2OBzoohU8r6mzfXazFXNM4LFu8R71nCoREFEoDhWGYkp/0zs3SYY
 bfuR3bjf9mcsFRqUcEWSxiqivTkbUeXOmSRxL6aMABdI2YAaOTBccAq8+olGYxWdXP7S9HRWg
 367yYFGQDYm9mzWil2JwKsCyusIPlsg04Bnsa9+aZOid5YIrCxe4gvoPqCKeim3+w9uzl8wBj
 We1zbKoV1oxXaE2p2yJb5OD8N6wQiuMJVMSDNc2/GcYVrA+SH5K2WEt2pof9/SQ3RyDZSFweW
 RjM2q++/tGCPV5nIWhJl+Nf5ffDmPCftvpipGV4DHc5ypiIBFgDJCIqWa7IXOYBCpowFOILLU
 R/9iFOAo9Cs+PIrIxKbrDjdsmPpdnFdVVbd5pGDyKq+psx44zZEIUZOlKbOCftdUK/aSyNQDT
 SoUz6W/uKUzCHpe36gEYBLMeVbqRGAuyUqhqDM+HKYYIWOFhg8/3L+VGa5TjJvbrv1Knxk1PI
 RwggPLsSPMWzf1fToSRn1DUI3EiM4NXqn7LwVSVsx189tLOYoOvfuJa8x2c+FgMq1Ev1uSFJW
 0qrTU38byrQIpJmArKo1uPN4DfUPNDNYI2i7vZcsQYbwxgmoNYp1KV9mbBYHDQJGc5U4mJNan
 iy8u+5Ho16VqNHfqQuoZHcJm6A2feOIX0vU65+uLTp6Jmje1p4pPV7kyJzERQ8bnIq4bvkkdQ
 K8jXM3GMVwXa7OMTbfFGQT/Yw4iUK0IOOdruIKJSoMj6uUo/7tc2wC8TAp6fF9QDBUgLA/lq3
 ZVQyH48pfNyPz2z5IHqw6JDcDPgbEKOuzQVz1Spcc/0GN/BwUYiVmFi76nK4LK8RwlIIo4X1h
 p9+yY0191S9jWBGPSB3XegjegtK73puvZgSH5Lw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
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
X-List-Received-Date: Wed, 02 Sep 2020 14:02:39 -0000

Hi Takashi,


On Wed, 2 Sep 2020, Takashi Yano wrote:

> On Wed, 2 Sep 2020 08:26:04 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> >
> > On Wed, 2 Sep 2020, Takashi Yano via Cygwin-patches wrote:
> >
> > > On Wed, 2 Sep 2020 10:30:14 +0200
> > > Corinna Vinschen wrote:
> > > > On Sep  1 18:19, Johannes Schindelin wrote:
> > > > > When `LANG=3Den_US.UTF-8`, the detected `LCID` is 0x0409, which =
is
> > > > > correct, but after that (at least if Pseudo Console support is e=
nabled),
> > > > > we try to find the default code page for that `LCID`, which is A=
SCII
> > > > > (437). Subsequently, we set the Console output code page to that=
 value,
> > > > > completely ignoring that we wanted to use UTF-8.
> > > > >
> > > > > Let's not ignore the specifically asked-for UTF-8 character set.
> > > > >
> > > > > While at it, let's also set the Console output code page even if=
 Pseudo
> > > > > Console support is disabled; contrary to the behavior of v3.0.7,=
 the
> > > > > Console output code page is not ignored in that case.
> > > > >
> > > > > The most common symptom would be that console applications which=
 do not
> > > > > specifically call `SetConsoleOutputCP()` but output UTF-8-encode=
d text
> > > > > seem to be broken with v3.1.x when they worked plenty fine with =
v3.0.x.
> > > > >
> > > > > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > > > > https://github.com/msys2/MSYS2-packages/issues/2012,
> > > > > https://github.com/rust-lang/cargo/issues/8369,
> > > > > https://github.com/git-for-windows/git/issues/2734,
> > > > > https://github.com/git-for-windows/git/issues/2793,
> > > > > https://github.com/git-for-windows/git/issues/2792, and possibly=
 quite a
> > > > > few others.
> > > > >
> > > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > > ---
> > > > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > >
> > > > Ok guys, I'm not opposed to this change in terms of its result,
> > >
> > > I am sorry, but I cannot agree with Johannes's patch.
> > >
> > > For example, code page in Japan is CP932 by default.
> > > In this case, cmd.exe, netsh.exe and so on are generate
> > > messages in Japanese.
> > >
> > > If the code page is set to CP_UTF8, messages from such
> > > commands changes to english. I guess similar things happen
> > > for other locales.
> > >
> > > I do not prefer this result.
> > >
> > > Furthermore, I looked into the issue:
> > > https://github.com/git-for-windows/git/issues/2734
> > > and I found that git-for-windows always use utf-8
> > > encoding even if the locale is ja_JP.CP932.
> > > It does not change coding based on locale or code
> > > page.
> > >
> > > Even with Johannes's patch, if mintty is started with
> > > locale ja_JP.CP932, the file name will be garbled
> > > bacause SetConsoleOutputCP(CP_UTF8) will not be called.
> > >
> > > IMHO, it is the problem of git-for-windows rather
> > > than cygwin and msys2.
> > >
> > > To make current version of git-for-windows work, it is
> > > necessary to set code page to CP_UTF8 regardless locale.
> > > This does not make sense at all.
> >
> > You are misrepresenting the problem. It has nothing to do with Git for
> > Windows. For example, if you run tests in an Angular project inside
> > Cygwin's MinTTY, the output will be garbled because node.js (or the
> > Angular libraries, I don't know) will interpret `LANG` or something.
>
> You listed these issues in git-for-windows:
> > > > > https://github.com/git-for-windows/git/issues/2734,
> > > > > https://github.com/git-for-windows/git/issues/2792,
> didn't you? Therefore, I looked into them.
>
> OK, I will check Angular/CLI next. But I am not familier with
> Agnular/CLI. Could you please provide simple steps to reproduce
> the problem?

Here is a report: https://github.com/git-for-windows/git/issues/2793

But why do you want to look into Angular/CLI? Do you really think that it
makes sense to try to fix every console app out there? Really? Wouldn't it
make more sense to just accept that there are many console applications
that are broken by the recent change, and accommodate them in the Cygwin
runtime? That would take substantially less time.

Ciao,
Johannes

>
> > This is a much bigger problem than you make it sound. The console
> > applications that do _not_ call `SetConsoleOutputCP()` are sooooo
> > ubiquituous. I think you are underestimating that problem rather
> > dramatically.
> >
> > Ciao,
> > Johannes
>
>
> --
> Takashi Yano <takashi.yano@nifty.ne.jp>
>
