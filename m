Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by sourceware.org (Postfix) with ESMTPS id D112738460A2
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 21:17:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D112738460A2
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599513458;
 bh=fB3L7sbS8lTHfoaAsZ6/fhdL7D/0hg/ofy8fsmhflo4=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=Q21yfME5TUN/y/GT4wHL36BU7dl/hM9JNwuPGCcU2/pGpX49WGma5clmae3L2Y5Hl
 OWVV4vF3qjzm2rjnw2ddmGyFbHtUCdieHpkyoqZgPNykvjk+xHG6e+VKTRqOMdtn/B
 nTQSQNq+ZJIzswDFuhgAD2LWOz9OuAYuQYQH/ze0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.215.223]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1kDkMG1JBO-001ksj; Mon, 07
 Sep 2020 23:17:38 +0200
Date: Mon, 7 Sep 2020 23:17:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
In-Reply-To: <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2009072309070.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
 <20200904190337.cde290e4b690793ef6a0f496@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2009040822000.56@tvgsbejvaqbjf.bet>
 <20200905000302.9c777e3d2df4f49f3a641e42@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lv6elIjIEVFBQCBFH3ECaRc/H4bRJnuWeIjSwBxgK3AXqjlqKDv
 Yu8Aq6UW4G4i4SFIygMGdPtBNPt7CIRYxkRlpeq8D2mVLOhd19Inob/BiapHBDPBnI7g/xh
 qXXdW26NB1AlVgiJKgxpfd6EOj7+BM5K5YcKeABQjOpwq6oWRgNV0rA4k4ycJ5pSnU2+eGQ
 mUT/+1Ao7X9WGvjx9hGKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:px2VQDL1i7Q=:0WI0roYyN2qJOz2uonD7tz
 0+FUQyyrLwnYL0ib+U/9VnWh5qUZF03LOFeep2mLkTirbgr2FmHR2OupplYEqDxrkqaQAEBB7
 tsLeU7HX1CygFgP+0NgLLcqdl4isQ3acd4ab0dior9Z5vT4/ArAqeVfHYXnOvDbQLw5M4+ZsX
 x0+z4/JVj+mpVjhMqWOER0ndIzUUf/tpeq/LxN+rD36f41StG1VxsEAqOUSJiVoWvmfb4e8OC
 NRj32at9eU5pNPnFQ2LQcaPtQiS/BVRR78NnUXg63MxAF3jQyS8+7pbbgez2E6FUW+IMD7+ZB
 dG7il34XVoH0Fv0bP6UMPlp+9uKMcAdcB05sgBYPwTBYf1M0D/krNq+r7Y5HxFGRTVodG7slb
 1z2Y9ZaEniDJFEezI/EO8/x0W7G1PiAkl4zGP11JVktm/oq9CGqNujZbKUFxNhQ7+CgOSGWar
 LfGnYZai6GIZQumGAWImmbbQvr7twhIChnDyi494YuxOH3fKpjB2rAzIdLBlQTg7mJI8wbqmn
 AZQuqGQQ9ymDxyLKvHhPDiqPsPEg7TwD/hRAw1CuYyjMDx0slwLi9EwCvBXnPEpBGoPRia84P
 LzRe3loQVkaBoEjzPYNxxby0eLBbj01kV4V4PIWvT0czX/D8DfDtMb9wuMprCiC1g9WE4cSn0
 Szc0j2vby822+J1kdOX60IcXEYecBpO1qVyRXVnxahUv4dntTa+nDyInHRJwa6w6EGhBx6VZr
 BzPaJKmKa+mo8QQcaYUOzwwInu+Pxg3qEN9z7YBNbwpe7xsbcltEDNGy2Phs/bThSi8vU0Z2K
 gDzlpciw5FiSR5xSNDXTJ4CjWoVVW+rd6oowLXZ5VtQks/u8vajPiCeuRTOSdtGNg0BvPO3iA
 o3sYWowLqXbw+/YYJjwegm22j7OnoGcEuhSWqMduCL/aokRye5Osjs/nFmNhK5fkdW2wggK83
 aoqx7a7UwEucuJe6ziq/V5TQ6Sz46ttriVr01vkKyVsoQhYKE+CswUxLGn+vzj+pCbMqIPzxF
 KwaJ7BeED1UR+RH4wlo5m1ha/HiZOJ+eS/XsAvTlNZq/6xJ/YtC+6AU9GWiWmuh3SWGGGTSaQ
 3rQbib9kES50Qmyumzq/bzngmGrQzwB4wMpEVGqosupSGe1e9BMdaCBqUiC0mbDSADbCEr9rx
 zHlYsVR1u8xE872hY5JyEbuAqzGXzwc29mmr47zJvP9WftotacnWNDI7uQdKVO6I77mqq/xZF
 tAqbzqDD/LEyyq+v269I8YO6vsl4bkD/6EiouFQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 07 Sep 2020 21:17:45 -0000

Hi Takashi,

On Sat, 5 Sep 2020, Takashi Yano wrote:

> On Fri, 4 Sep 2020 08:23:42 +0200 (CEST)
> Johannes Schindelin wrote:
> >
> > On Fri, 4 Sep 2020, Takashi Yano via Cygwin-patches wrote:
> >
> > > On Tue, 1 Sep 2020 18:19:16 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > >
> > > > When `LANG=3Den_US.UTF-8`, the detected `LCID` is 0x0409, which is
> > > > correct, but after that (at least if Pseudo Console support is ena=
bled),
> > > > we try to find the default code page for that `LCID`, which is ASC=
II
> > > > (437). Subsequently, we set the Console output code page to that v=
alue,
> > > > completely ignoring that we wanted to use UTF-8.
> > > >
> > > > Let's not ignore the specifically asked-for UTF-8 character set.
> > > >
> > > > While at it, let's also set the Console output code page even if P=
seudo
> > > > Console support is disabled; contrary to the behavior of v3.0.7, t=
he
> > > > Console output code page is not ignored in that case.
> > > >
> > > > The most common symptom would be that console applications which d=
o not
> > > > specifically call `SetConsoleOutputCP()` but output UTF-8-encoded =
text
> > > > seem to be broken with v3.1.x when they worked plenty fine with v3=
.0.x.
> > > >
> > > > This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> > > > https://github.com/msys2/MSYS2-packages/issues/2012,
> > > > https://github.com/rust-lang/cargo/issues/8369,
> > > > https://github.com/git-for-windows/git/issues/2734,
> > > > https://github.com/git-for-windows/git/issues/2793,
> > > > https://github.com/git-for-windows/git/issues/2792, and possibly q=
uite a
> > > > few others.
> > > >
> > > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > ---
> > > >  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandle=
r_tty.cc
> > > > index 06789a500..414c26992 100644
> > > > --- a/winsup/cygwin/fhandler_tty.cc
> > > > +++ b/winsup/cygwin/fhandler_tty.cc
> > > > @@ -2859,6 +2859,15 @@ fhandler_pty_slave::setup_locale (void)
> > > >    char charset[ENCODING_LEN + 1] =3D "ASCII";
> > > >    LCID lcid =3D get_langinfo (locale, charset);
> > > >
> > > > +  /* Special-case the UTF-8 character set */
> > > > +  if (strcasecmp (charset, "UTF-8") =3D=3D 0)
> > > > +    {
> > > > +      get_ttyp ()->term_code_page =3D CP_UTF8;
> > > > +      SetConsoleCP (CP_UTF8);
> > > > +      SetConsoleOutputCP (CP_UTF8);
> > > > +      return;
> > > > +    }
> > > > +
> > > >    /* Set console code page from locale */
> > > >    if (get_pseudo_console ())
> > > >      {
> > > > --
> > > > 2.27.0
> > >
> > > I would like to propose a counter patch attached.
> > > What do you think of this patch?
> > >
> > > This patch does not treat UTF-8 as special.
> >
> > Sure, but it only fixes the issue in `disable_pcon` mode in the curren=
t
> > tip commit. That's because a new Pseudo Console is created for every
> > spawned non-Cygwin console application, and that new Pseudo Console do=
es
> > _not_ have the code page set by your patch.
>
> You are right. However, if pseudo console is enabled, the app
> which works correclty in command prompt should work as well in
> pseudo console. Therefore, there is nothing to be fixed.

I am coming to the conclusion that your definition what is correct differs
from my definition of what is correct.

For me, it matters what users see. And what users actually see is the
output of UTF-8 encoded text that is now interpreted via the default code
page of their LCID, i.e. it is incorrect.

Sure, you can argue all you want that those console applications are _all
wrong_. _All of them_.

In practice, that matters very little, as many users have
`LANG=3Den_US.UTF-8` (meaning your patches force their console application=
s'
output to be interpreted with code page 437) and therefore for those
users, things looked fine before, and now they don't.

Note that I am not talking about developers who develop said console
applications. I am talking about users who use those console applications.
In other words, I am talking about a vastly larger group of affected
people.

All of those people (or at least a substantial majority) will now have to
be told to please disable Pseudo Console support in v3.2.0 because they
would have to patch and rebuild those console applications that don't call
`SetConsoleOutputCP()`, and that is certainly unreasonable to expect of
the majority of users. Not even the `cmd /c chcp 65001` work-around (that
helps with v3.1.7) will work with v3.2.0 when Pseudo Console support is
enabled.

Ciao,
Dscho
