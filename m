Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by sourceware.org (Postfix) with ESMTPS id EE47D385141D
 for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2020 14:48:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EE47D385141D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599230886;
 bh=YCHkJBmvGeaJdx+FnFHhxkZE8gutIOIctyijqe6DG40=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=KYawU/Cql+W3lZsDA+iLP0ijEh/iTz+9wUQotQaEtfhGuIE99YW/CqtNmB/WcWoAl
 7QIsDNxoVqivPy52n3Amm9CXG3cWkc44pu/hIuZDTFpXEfAjWiHc9ovoDQWwfXSaAb
 eqiygpR/tR2XNMz7QNIRZlsbo0bMDmX+KA+D0if4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.212.11]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zFZ-1ka0yj0ooF-0151v2; Fri, 04
 Sep 2020 16:48:06 +0200
Date: Fri, 4 Sep 2020 08:23:42 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
In-Reply-To: <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YeylBpnG/4nyHCJSpU8H8RHCK6aR9OlVggEtVQHa7mkONJko/Ag
 gJcMGD2J4fUXYzUn3Q4ML/u2KZa8aF5y+1N44Jlwi6YnMejl2oUgj9l//J1Hf8qSuRYmBAt
 MrVCcx7LhYSePFkTPBT+k2p+q4ONPMhh4ffA5YqJOvW8uMTvn+/Iob95UClPlRQMAGf6V5b
 CzJFSw6ymQ2BAUG4KCiqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Qm155/rCeA=:nscmlSVTbN/0n1szgFG740
 pfsNAKBifj0oytBSD0BctoNkYOPyjJ/6xHk31gFTD3t3x6Pzgis0oa5X1eDCCbIzJf7RhJZct
 X3ALjwDVusHVJT0tP9QrJxkqIcOQ4EV0P4EmENxyL2aNB0BUlzSk0OlP0PiVA2iuFic7GYHR3
 ZZnYvhz1xglVeiP+nIjmW7fleG3aug0FwDeXZDTGV2hxMXpXISrupbt3fcbCcJf/BqfPk691V
 6IZtQB5n8eMsT2ljQTb/S0LYsmKOb2jjqWJQ7E5kG4N+U0Wut59ah2YTvPtxi0fJR0Egl2pZ1
 SogJM1N2RJPJSP4B1DCGaJutJChWKZS3cSmpqvXI8oPKN6ZTOsDREPFl1I6811tC7lldCd0NV
 8Oeiqh8m6gN0oSK2TTkbNKy0UYv0agJRs63aEVc8HMjvdmuAhLju/jwCGPeKJO4idDUrqHaB9
 PoIeCMgO9ggFIjPl56FWC0C9uf0n3jSg2MGaKXQ4wVMBI07YnFDvpzjUHR0Bw0lOgyOQfwRt9
 /kiFTe7o2y0o99EMBsJPmwA3TkrEMg9QbAMa3U+dFYd59sEqShfwdPROuIkYn4LML2EKhGAeT
 x4+K8fX1+E472e6rnFYf4swsgCXqKRnT9jZwM/OT+f7cPecHm55q4fFdyz2rEwSLRyTbdfPlj
 XzuI2vhhWT2+hAbAP1IojpIJoU+4sFRODoki0to9nrgdqvNS3ZxsCRWUsUrOuJekdjtBzNlp4
 dcfr0z2aqVu0kAc0ZZu0w686Xqu3KnR1jnxBZUQVGtunZAZA3zZ5j/loIOEcznFJjEg8Rg4/h
 SKwYwU1g3bJ6i3nm2XqxXbNYbYhHHA0/evXjtB+2TMR6xnXX5c+Dm+lEOGyztQHzL0tEHk/O9
 VLrqX0nuWlOaPPCKXqn4ko0u1uaS8hjDnXMnhhVLuRPOZ6fRLCN22dGUztSwINEuOGcyB1sQG
 sayCXrDa43mUQeBdbFizD1gzmzDEk+/HwseobHDhE+JglhNXW8K24iKa28A3We1Zo97qG6XVI
 yD0V9HgfcjFyEgh8HMLZRa11kNpZFAd+ihAv+PdA60ubb+J5D7PIao/djGD6LXwruOYi7w5CD
 z94WxsEixZqy91Lca5Crf119IqAS8o5/xen7kKTh9JoBp2QItxcXSlZ+NpwGIYCV3JUyZ4TQI
 Kn4PzjvQyDF8egVrAn0w0xpV/vdH4elnI40rsjPVu/P/7NYm1PaoU6065AnFnkIFdgbmY7st1
 Hf0aI+rxD+6gG2arsxr/83/09nFSVqn5/MGVcpw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00, DATE_IN_PAST_06_12,
 DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 04 Sep 2020 14:48:12 -0000

Hi Takashi,

On Fri, 4 Sep 2020, Takashi Yano via Cygwin-patches wrote:

> Hi Johannes and Corinna,
>
> On Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
> Johannes Schindelin wrote:
>
> > When `LANG=3Den_US.UTF-8`, the detected `LCID` is 0x0409, which is
> > correct, but after that (at least if Pseudo Console support is enabled=
),
> > we try to find the default code page for that `LCID`, which is ASCII
> > (437). Subsequently, we set the Console output code page to that value=
,
> > completely ignoring that we wanted to use UTF-8.
> >
> > Let's not ignore the specifically asked-for UTF-8 character set.
> >
> > While at it, let's also set the Console output code page even if Pseud=
o
> > Console support is disabled; contrary to the behavior of v3.0.7, the
> > Console output code page is not ignored in that case.
> >
> > The most common symptom would be that console applications which do no=
t
> > specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> > seem to be broken with v3.1.x when they worked plenty fine with v3.0.x=
.
> >
> > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > https://github.com/msys2/MSYS2-packages/issues/2012,
> > https://github.com/rust-lang/cargo/issues/8369,
> > https://github.com/git-for-windows/git/issues/2734,
> > https://github.com/git-for-windows/git/issues/2793,
> > https://github.com/git-for-windows/git/issues/2792, and possibly quite=
 a
> > few others.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tt=
y.cc
> > index 06789a500..414c26992 100644
> > --- a/winsup/cygwin/fhandler_tty.cc
> > +++ b/winsup/cygwin/fhandler_tty.cc
> > @@ -2859,6 +2859,15 @@ fhandler_pty_slave::setup_locale (void)
> >    char charset[ENCODING_LEN + 1] =3D "ASCII";
> >    LCID lcid =3D get_langinfo (locale, charset);
> >
> > +  /* Special-case the UTF-8 character set */
> > +  if (strcasecmp (charset, "UTF-8") =3D=3D 0)
> > +    {
> > +      get_ttyp ()->term_code_page =3D CP_UTF8;
> > +      SetConsoleCP (CP_UTF8);
> > +      SetConsoleOutputCP (CP_UTF8);
> > +      return;
> > +    }
> > +
> >    /* Set console code page from locale */
> >    if (get_pseudo_console ())
> >      {
> > --
> > 2.27.0
>
> I would like to propose a counter patch attached.
> What do you think of this patch?
>
> This patch does not treat UTF-8 as special.

Sure, but it only fixes the issue in `disable_pcon` mode in the current
tip commit. That's because a new Pseudo Console is created for every
spawned non-Cygwin console application, and that new Pseudo Console does
_not_ have the code page set by your patch.

I verified that this patch works around the issue in `disable_pcon` mode,
which is good.

Ciao,
Dscho
