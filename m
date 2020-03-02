Return-Path: <cygwin-patches-return-10159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28534 invoked by alias); 2 Mar 2020 19:27:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28523 invoked by uid 89); 2 Mar 2020 19:27:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 19:27:43 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M9FX5-1j3bP01vsd-006S7l for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2020 20:27:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 08602A82778; Mon,  2 Mar 2020 20:27:41 +0100 (CET)
Date: Mon, 02 Mar 2020 19:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Cygwin: console: Some fixes for console in xterm mode.
Message-ID: <20200302192740.GV4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="DRp5/Sds4nAqvQzf"
Content-Disposition: inline
In-Reply-To: <20200302011258.592-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00265.txt


--DRp5/Sds4nAqvQzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 556

On Mar  2 10:12, Takashi Yano wrote:
> Takashi Yano (4):
>   Cygwin: console: Revise the code to fix tab position.
>   Cygwin: console: Fix setting/unsetting xterm mode for input.
>   Cygwin: console: Prevent buffer overrun.
>   Cygwin: console: Add a workaround for "ESC 7" and "ESC 8".
>=20
>  winsup/cygwin/fhandler.h          |  1 +
>  winsup/cygwin/fhandler_console.cc | 91 ++++++++++++++++++-------------
>  2 files changed, 55 insertions(+), 37 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--DRp5/Sds4nAqvQzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5dXiwACgkQ9TYGna5E
T6A1bQ//cRIXgo5GmtYj9qwQVY+da/KzuAyyHZu+sUwfH6wwkZZTpGDBUZavYJhm
Uv/UyqKRFu+yxakpOUeWUaRXceBbs+Rhp5tBnxOKQouW/KhoQbatsQif9qItUjtC
Egp8yH7n5B8znoiHkzdQwc8AvoDnYmGsYABad1URok+sKZi6XNr5sgFjSLf8BQP7
rJvprgCjB/p95qmreL2CJdp98lKIktxNCMnanFnn/cziW7OuNtfaALAgnw9PHyef
JdLcp1cQTIcB4fNsrcygyYu9jNqUda12ol1I50TPeIN/DIaA7UXp/snDLMDy58jT
+MNpQnUYYxjPw6tXDgGWZv29xeBzWaULCLISKjAJXGtlzYqcmh97cooGZn7FUFXZ
pEytb3WtdlwNfQcrPPGDFwoImVerB9Cm4srAq/8m9P6M6xu11yNE74xc0xd+zPBy
POu9dTyJVeausAIlTfYLwKKnlUqAjU0RyKfCQcM8Ib8OlDulLiOkvNXsU8jyx5SD
ndmB7ZiBfqT4XUV1jL91nfSC75uhVKfGttTZZhPiozEO3fKCBSRkVl51fhza9qfi
zu9qPuQKJLd3KmU+PNrfNOtAO8ccBoXrTCez399scMjiZoItMEoac/oeESoF3NOp
i9Zn9F1PL0PDFUNNdu32DexER6vBCB8a16YH+vOUYuxs9RrhcoM=
=MP4L
-----END PGP SIGNATURE-----

--DRp5/Sds4nAqvQzf--
