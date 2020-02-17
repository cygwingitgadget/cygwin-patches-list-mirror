Return-Path: <cygwin-patches-return-10069-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43700 invoked by alias); 17 Feb 2020 09:00:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43579 invoked by uid 89); 17 Feb 2020 09:00:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, H*F:D*cygwin.com, HX-Spam-Relays-External:sk:mout.ku, HX-HELO:sk:mout.ku
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 09:00:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mth79-1jJuf906JT-00vA9l for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2020 10:00:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 37284A80773; Mon, 17 Feb 2020 10:00:15 +0100 (CET)
Date: Mon, 17 Feb 2020 09:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-ID: <20200217090015.GB4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20200216081322.1183-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00175.txt


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1270

Hi Takashi,

On Feb 16 17:13, Takashi Yano wrote:
> - If two cygwin programs are executed simultaneousley with pipes
>   in cmd.exe, xterm compatible mode is accidentally disabled by
>   the process which ends first. After that, escape sequences are
>   not handled correctly in the other app. This is the problem 2
>   reported in https://cygwin.com/ml/cygwin/2020-02/msg00116.html.
>   This patch fixes the issue. This patch also fixes the problem 3.
>   For these issues, the timing of setting and unsetting xterm
>   compatible mode is changed. For read, xterm compatible mode is
>   enabled only within read() or select() functions. For write, it
>   is enabled every time write() is called, and restored on close().

Oh well, I was just going to release 3.1.3 :}

In terms of this patch, rather than to change the mode on every
invocation of read/write/select/close, wouldn't it make more sense to
count the number of mode switches in a shared per-console variable, i.e.

LONG shared_console_info::xterms_mode =3D 0;

on open:

  if (InterlockedIncrement (&xterm_mode) =3D=3D 1)
    switch to xterm mode;

on close:

  if (InterlockedDecrement (&xterm_mode)) =3D=3D 0)
    switch back to compat mode;

?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5KVh8ACgkQ9TYGna5E
T6Bwrw//d20Pz6/wEOnio+4pZoe6az2qKmMTZckHxie9VIwcechqPuujGzKJ5eHm
VVboMZnePs5nxuQuwxiOlOj10HsxYKjzympWdQZZGskkGX5fak2eST8C7SP+Tzxh
MPDvdIz1DHWnmppJp3OAaMF3OZflF62Hf43lDawaT1QqOBYRWn36Q7Qhr0HsrCuB
1QdW5aWVNu/HPhM0TZnVaOyENy1TngLUDpN1yjF4qwmBN4OuyhnR3kjGloPZwqik
j3ZhDlBK9Bvn+qefa0LR8k6WlpAhWjhgIjJNXeqeYXrFqOoR8kNPEX3huPWEV1ts
u687LwAxgxg64ZTMtBQ4hGU7DvWdAWkNXO1gkWaKAeJFZTvEZXLZi1xWb+Le+3KC
3yH9OzUwHbNaGFQ9CYQDUF2hhI/MVzAaXatzxXP+bC13oKcHaMSM1Mkes2QLOWAX
ai1v5oVyOMmxCSmRxlRzYFC4SVTIhNTwRTMGCJ4Ws1t/LmATz/wFTjRog6gE7hBS
MCNxw0dRYvsinvrxznWWji+ugXj0cb3W361+dHQTPupztoBsLxXv00i0jaZ2m5a1
K869W42oCA0df7qOvpNd7CzSjIpvS4R4Wgj20oAwVKERRgdVkkT81Vdl/4qhtq7M
k1v8IsZrL2pIgCt0qgi7xyuVzCNJVHWazPXyPMRrlh9MFSfUhyM=
=xej/
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
