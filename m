Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by sourceware.org (Postfix) with ESMTPS id 51B413857C5F
 for <cygwin-patches@cygwin.com>; Wed,  2 Sep 2020 10:56:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 51B413857C5F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599044180;
 bh=USV+wRKhkP9cXmur5/KL2ZTKY2coh1cFQWuYtagJHhI=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=P0aqR8UAWtF/pgYoyV7p3IYjfAKIe+vLWqFhrUb3iScanj3TjFgPykSeGxcu6sH1k
 O6V/jD3xMMjvjSXg2gOrxEnr39LM+x8x3dEHG1gTMguEVtdIxveg6v82OUPeY7yCB8
 otxT17CI0ns87oRBu/pqhJqy45rgOk44EV2LeI/Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.253]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1kew9I2lsy-017W4U for
 <cygwin-patches@cygwin.com>; Wed, 02 Sep 2020 12:56:20 +0200
Date: Wed, 2 Sep 2020 08:06:43 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
In-Reply-To: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2009020800410.56@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2009011818560.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5UIMEe39dtUuyqfe5EvQw91IuTcLeTl/M2huT6SS757Kje34hJQ
 TEhzSPEJhpIHcajHENRxCdyLaY+By6jESc1bzQtE+fouslZS4uALO+la5XoVJDGrw4aWjZt
 nJgruXZPzVLHMfidYGysyrHQrwdm05lZJ8CZR6G8JNVTUUmUCtIgPPYdR9PAV3rY1j+qG/Y
 7xbdVnxTGr7wCt9EMO3Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ba7gNCSy6E4=:BTQSJWHkaItN700tzQ9//N
 lc2OuwJe/E6LzigQDIAF5J6JWqhmf5Ry71mHdWxnTZSLZLEQN19hwsYitDrjoLf+1d8NTdudL
 MEyRN/nZKsqlZarGSgOz7yIxG8Jp+NOHFRcZ74Vs+9+bh5aWMK8c4a0/aAOMnND8pYl8q4FDB
 k1nVWYiC/DgFR7Wmt3lNnh1Mjtj7HyhvA2iOHMmEt/ivS02V8HfRy99j22/hvFELK+stse2gO
 nNjZSAEjIIermtj3Gn49zQmDSE3uFe/oax7abVtPu1BeXBWaeadNgRw+p4uhGiBPFdJa2CMZe
 tEaq/ecD3r9W3uSaIaNXc+vU3U4ezSsSiyhrThvOwgIDNNkbAahFU55M/tDxmHwAbtcu+aZNH
 n3J1DrH51A3ye4/RqwazP76bIlL1jY+g+G7OTxTwNC07tbIjA0LRW0BrmHvbRLuE4Q6KJFd3b
 g1x1lGiMdsOjb66tUP72I/P6QtF2ke++efXFaj+IWrAwUMghGI38mARlW5QjhmKJHe+2iHnAr
 jnxNr/dr52LY7euEy1QYpEo65l7sX+t2/1xD1D1sAQN3nrSLXmks1suqsScoBtHaTze3SkBH2
 hW/LtkHrWUEApTYQ6IgjbNDGeHwWpsRgtpgxBYORS9iDMVN9jBCWVP3GtWI2kBl9EC7EsEn9v
 kW1cIRHCfKuvxBlBPzMAuyEZ+Z2z15ISvXQC2TNlfxzLsj3LCqjsWEyQ4BvuQMLdYRMKuREnW
 zBwzbD2aM5NAScFz4Lo/nhPEaSIS6k8bJO11izNl0WTciPPACIqzb7/RGWoMbuThS38kEnQDW
 VE/Cz05XefG2Rf915+cgJm9K4JsarNnwnvg36USug/qf2qOjsMRi0M9NIKMMD7AWk2rzbG/Os
 Evw/q87cgUWEt7wgqIvrr2PII93kH3ThSHFIx7oD0rDhnqN8tUHuCP8HFQdCgvzSoBpINekbp
 NFy7/w+O0aft++fH4d03uSA8+78pqzVk1s/DhL47oWXP4BbGISuxu3/agsriGxO8/ahL81rd9
 j7bperXIYXVp0nM6E/iL7zomY2NM30gVDq40it66kiKSulYM7LxitaqIhNH03heMHE5Lk+URw
 i0sWGaV/2juszc8mSRc68S99GD3JP8IjLVDvIEm4A+uu9/EERvGZvU6TDvwNoEGyfnQwIETM0
 mMMDP7VT7nmQ8JOa+Nh2HQGzeMdosWVczcEg9NLR+CVDhv1HVEnyVShOtXEefe4lgHNmT5E0N
 NSVkhyRRytM2DAd8hD9ca34hkZss/Wx40VIsplg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
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
X-List-Received-Date: Wed, 02 Sep 2020 10:56:25 -0000

Hi,

On Tue, 1 Sep 2020, Johannes Schindelin wrote:

> When `LANG=3Den_US.UTF-8`, the detected `LCID` is 0x0409, which is
> correct, but after that (at least if Pseudo Console support is enabled),
> we try to find the default code page for that `LCID`, which is ASCII
> (437). Subsequently, we set the Console output code page to that value,
> completely ignoring that we wanted to use UTF-8.
>
> Let's not ignore the specifically asked-for UTF-8 character set.
>
> While at it, let's also set the Console output code page even if Pseudo
> Console support is disabled; contrary to the behavior of v3.0.7, the
> Console output code page is not ignored in that case.
>
> The most common symptom would be that console applications which do not
> specifically call `SetConsoleOutputCP()` but output UTF-8-encoded text
> seem to be broken with v3.1.x when they worked plenty fine with v3.0.x.
>
> This fixes https://github.com/msys2/MSYS2-packages/issues/1974,
> https://github.com/msys2/MSYS2-packages/issues/2012,
> https://github.com/rust-lang/cargo/issues/8369,
> https://github.com/git-for-windows/git/issues/2734,
> https://github.com/git-for-windows/git/issues/2793,
> https://github.com/git-for-windows/git/issues/2792, and possibly quite a
> few others.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler_tty.cc | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.=
cc
> index 06789a500..414c26992 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2859,6 +2859,15 @@ fhandler_pty_slave::setup_locale (void)
>    char charset[ENCODING_LEN + 1] =3D "ASCII";
>    LCID lcid =3D get_langinfo (locale, charset);
>
> +  /* Special-case the UTF-8 character set */
> +  if (strcasecmp (charset, "UTF-8") =3D=3D 0)
> +    {
> +      get_ttyp ()->term_code_page =3D CP_UTF8;
> +      SetConsoleCP (CP_UTF8);
> +      SetConsoleOutputCP (CP_UTF8);
> +      return;
> +    }
> +

Just a word of warning: while this patch can be ported to a634adda5
(libm/machine/arm: Rename s*_fma.c -> s*_fma_arm.c, 2020-09-01) relatively
easily (and the first two patches of this patch series cannot, as they are
no longer applicable after the complete redesign of the Pseudo Console
support), it only works as intended in the `disable_pcon` mode.

The new design calls for Pseudo Consoles to be created per spawned console
application.

And I have not found any way to convince my local version of the runtime
to change the code page of these Pseudo Consoles away from the rather
unfortunate default 437.

This is a problem.

Take for example https://github.com/git-for-windows/git/issues/2793.
Telling the users that they should patch node.js and recompile is probably
not going to fly.

Hopefully there is a way to fix this, otherwise Pseudo Console support
will continue to be quite the support burden.

Ciao,
Johannes

>    /* Set console code page from locale */
>    if (get_pseudo_console ())
>      {
> --
> 2.27.0
>
>
