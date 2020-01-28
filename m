Return-Path: <cygwin-patches-return-10017-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58008 invoked by alias); 28 Jan 2020 17:02:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 57902 invoked by uid 89); 28 Jan 2020 17:02:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Jan 2020 17:02:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MHmuE-1ikvXB1O3a-00Ew1e for <cygwin-patches@cygwin.com>; Tue, 28 Jan 2020 18:02:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C8FC4A80B77; Tue, 28 Jan 2020 18:02:34 +0100 (CET)
Date: Tue, 28 Jan 2020 17:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Revise code waiting for forwarding again.
Message-ID: <20200128170234.GE3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200127112224.1322-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
In-Reply-To: <20200127112224.1322-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00123.txt


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 551

On Jan 27 20:22, Takashi Yano wrote:
> - After commit 6cc299f0e20e4b76f7dbab5ea8c296ffa4859b62, outputs of
>   cygwin programs which call both printf() and WriteConsole() are
>   frequently distorted. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler.h      |  1 +
>  winsup/cygwin/fhandler_tty.cc | 37 +++++++++++++++++++++++++++++------
>  winsup/cygwin/tty.cc          |  1 +
>  winsup/cygwin/tty.h           |  1 +
>  4 files changed, 34 insertions(+), 6 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4waSoACgkQ9TYGna5E
T6DzAw//dr67BDIf/GHqOcSNBeprJrBWcCUlzqmv4PE0tjWwv7BFg3I6quLAnSO0
dUVxZDVvS+hSjJuh33JrAMwqCIzild04irkpMuOhNrDgwgfVwPJQefw9Jr/a1OH3
JKKzc2DLwKABqZEwQlNnQZrWxQRKVNgzC3yNNVch6Jk6KLrAuAUgTtkzHT/chWms
8ak+43/XalybvqeaA5sFAMfvgd4YWcb83vsRGP4Y9jW9MMhvQ3Xj+y6N12hdk2r9
Gp4X+e7SU2BDLydq8KtLT7L1pACCn9HGjddPkWgbzh/09aFRUao9QTuG10d0iTTj
YcS/johGYF+O3uv0APA87JYeksXLJzZAitvl6ZJPu8E0+lH1qa8ERn7C8uI3KF70
6854fADMJLXlYsHlUNskyRo9ODqw43KFgyluvPdJMtCo6L0h+DUNKGYeNpcnmyFJ
TsQ/qSAK0vLPQO6mOfwV1lYbIZXpmZrJPlWZvl/e283nhgj4jR4mEck79/6XOQVk
Fq21952FVM7JGQP4Ua7Zp2iTiXRakDDldf578jo5xGD/lLgazqFHVVYBNRtWO1sv
BziuHeCzjhMBQwiiVhYwwrpUXyDMVTMDriFCOX+goF8cgZSYnr/QxRjbTWwNLrxM
YXFxyzZ2+SoZa8CKUrIm8UIkNovYv6X4q/IwToF9U+rwCbCrAQ4=
=1bOe
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
