Return-Path: <cygwin-patches-return-9764-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39732 invoked by alias); 18 Oct 2019 14:33:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39723 invoked by uid 89); 18 Oct 2019 14:33:16 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-113.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1564, H*F:D*cygwin.com, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 18 Oct 2019 14:33:14 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M72Xn-1iP3Hv18Kl-008ZpT; Fri, 18 Oct 2019 16:33:08 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C260BA80734; Fri, 18 Oct 2019 16:33:06 +0200 (CEST)
Date: Fri, 18 Oct 2019 14:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191018143306.GG16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20191018113721.2486-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00035.txt.bz2


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1557

Hi Takashi,

On Oct 18 20:37, Takashi Yano wrote:
> ---
>  winsup/cygwin/fhandler_tty.cc | 21 ++++++++++++++++++++-
>  winsup/cygwin/tty.cc          |  1 +
>  winsup/cygwin/tty.h           |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index da6119dfb..163f93f35 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1305,6 +1305,20 @@ fhandler_pty_slave::write (const void *ptr, size_t=
 len)
>    if (bg <=3D bg_eof)
>      return (ssize_t) bg;
>=20=20
> +  if (get_ttyp ()->need_clear_screen_on_write)
> +    {
> +      const char *term =3D getenv ("TERM");
> +      if (term && strcmp (term, "dumb") && !strstr (term, "emacs") &&
> +	  wcsstr (myself->progname, L"\\usr\\sbin\\sshd.exe"))

Sorry, but this doesn't look feasible.

You can't base the behaviour on the name of an application.  What about
other applications like telnetd, rshd, just to name the first ones
coming to mind?  What about a renamed sshd, or sshd installed into
another directory, or just an sshd in the build dir during testing?

Is this workaround really necessary at all?  Even basing this on the
terminal name looks pretty fragile.

Why exactly is the clear screen necessary?  You wrote something about
synchronizing the pseudo console and the pseudo tty content, IIRC, but
it still seems artificial to enforce a clear screen.  Is there no
other way to make the pseudo console happy?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2pzSIACgkQ9TYGna5E
T6A95A//VDyes/epXIdLhb4+2vO+Pw/YkhoKkqDUcr0JtKufMlADgGs5Mv3+94fe
m3likXmi284FRy9m3RSAmZM8eM74aRN5dbm6mohSs0Aj+X2+c2Vw7xhzhfq6bUkS
RBYM/gFfEwFPAMNgd3sPs6+TA0QqCVcnGSuHNxayJkejvh6x33k1alE9y4GEI2bM
cErnn1pqliRTWG1M0g5Z7jWwDj04eQB2QkSYBKrfiOgg1iLpmYnDJg+iVS6IUVpu
bVF39/UqrMd78FciaYHdmIsc40mcxdfS63E7WAH7JiBNk1dQk2KlZSzAdehgWGHP
Jsdr7B7b+CtXLxoA+9nQ2WAuhBM1ke9GehgSI2W18aQPSA0yKlHZsDi2Q8ydgZXC
PXfJtHjGed1ZevwesncoSUkNPhv2z+VvXQ8xwL67uxvSWrlhNZUDPrv/vXCGsone
585z3zpGvAZfFy6N6J5i6XTT2kvk2PgjKmXuXCTyDv+xjMmC9VqghzjTTUa/1p7D
ogUgYrzdA+kjUuFbtBZKDZnM3BbkFOG1zjpPxknlA9ouQrSjx3xhfjMJSLoAMKeP
cbPbfo5PpBQPh+9l1UNHSGQY4Rq0sl1uBEPl/Vo3QzMXV4ELwNJKL4ymggjUC42A
n8cjU1FTjdsuEGKnMn4mOTgeCkG7XQp983Zpg0BKC3ajyS0MHfI=
=iEEG
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
