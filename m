Return-Path: <cygwin-patches-return-10009-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 68744 invoked by alias); 27 Jan 2020 09:26:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 68734 invoked by uid 89); 27 Jan 2020 09:26:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.8 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, scenarios, critical
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 09:26:34 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MHndY-1ipwOn2498-00Exrj for <cygwin-patches@cygwin.com>; Mon, 27 Jan 2020 10:26:31 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8DC2AA80BC4; Mon, 27 Jan 2020 10:26:30 +0100 (CET)
Date: Mon, 27 Jan 2020 09:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Share readahead buffer within the same process.
Message-ID: <20200127092630.GB3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200125094548.958-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20200125094548.958-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00115.txt


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2277

Hi Takashi,

On Jan 25 18:45, Takashi Yano wrote:
> - The cause of the problem reported in
>   https://www.cygwin.com/ml/cygwin/2020-01/msg00220.html is that the
>   chars input before dup() cannot be read from the new file descriptor.
>   This is because the readahead buffer (rabuf) in the console is newly
>   created by dup(), and does not inherit from the parent. This patch
>   fixes the issue.
> ---
>  winsup/cygwin/fhandler.cc         | 58 ++++++++++++++++---------------
>  winsup/cygwin/fhandler.h          | 24 ++++++++-----
>  winsup/cygwin/fhandler_console.cc | 16 ++++++++-
>  winsup/cygwin/fhandler_termios.cc | 35 ++++++++++---------
>  winsup/cygwin/fhandler_tty.cc     |  2 +-
>  5 files changed, 80 insertions(+), 55 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
> index aeee8fe4d..ad4a7e61c 100644
> --- a/winsup/cygwin/fhandler.cc
> +++ b/winsup/cygwin/fhandler.cc
> @@ -44,11 +44,12 @@ void
>  fhandler_base::reset (const fhandler_base *from)
>  {
>    pc << from->pc;
> -  rabuf =3D NULL;
> -  ralen =3D 0;
> -  raixget =3D 0;
> -  raixput =3D 0;
> -  rabuflen =3D 0;
> +  ra.rabuf =3D NULL;
> +  ra.ralen =3D 0;
> +  ra.raixget =3D 0;
> +  ra.raixput =3D 0;
> +  ra.rabuflen =3D 0;
> +  set_rabuf ();
>    _refcnt =3D 0;
>  }
>=20=20
> @@ -66,15 +67,15 @@ int
>  fhandler_base::put_readahead (char value)
>  {
>    char *newrabuf;
> -  if (raixput < rabuflen)
> +  if (raptr->raixput < raptr->rabuflen)
>      /* Nothing to do */;

This adds extra pointer access to critical code paths, even if only
in O_TEXT scenarios.  May I suggest dropping the extra pointer and
converting readahead access to access methods, kind of like this:

  class fhandler {
    char *&rabuf () { return ra.rabuf; }
    int &rabuflen () { return ra.rabuflen; }
    [...]

  class fhandler_console {
    char *&rabuf () { return con_ra.rabuf; }
    int &rabuflen () { return con_ra.rabuflen; }
    [...]

and then use those accessor methods throughout:

> -  else if ((newrabuf =3D (char *) realloc (rabuf, rabuflen +=3D 32)))
> -    rabuf =3D newrabuf;

      else if ((newrabuf =3D (char *) realloc (rabuf (), rabuflen () +=3D 3=
2)))
        rabuf () =3D newrabuf;

etc.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4urMYACgkQ9TYGna5E
T6Cf3A//f526ZrtcHgyMSb+syYCYxZ8fNAacmdmQaZK/+Yfof/7DZ/0/smiDfl8N
/2/ROR89O6C4Ag+3I8kZ3UnF6ulkBfCJGKHER7YDw8OZVdDRRJ+su9Rux2FX+Jcz
TbejQp5Gi17d1Z/nNFgJdgppqrTDewntxb0V8IB9+b0duM/Bh75kwG4uf44548jz
o9GY+3xrku2RItPl4/mDWy1w0eQcU25/dxZbuCY/a1CYSCbfz8R8l2TuqXTAiz8I
Xq5OWVDoara0PtEHM7E0KEbgmadx7fQIVMwk9HzKZ7lyVAB7sq+fovxxgqDQSW6d
oRhbgrGegBGXvjiq4PJzfw/ADYJyialWdqP7/J3KjdFsiijc7TxBCxTBnehqV9WY
j2NNhnaMdIvxSrQuQHj3Xj2KOUphmqiuArp9Od/Es7PflFhS4j6ZX0t18LSgsPtQ
c9SuJ8uy9EPuOCTWbub15QVyQVfO/OoURk5J/Hba9wg4J7x+dKc0PmT0LwugziN+
8+BW7Hoc5Wc5s3KiWLAKNhlaM0Yzhpackpe8xsjXHg1ZJHI8X/rTjVTLrsvc9OFK
Pms8d07x5F0h++5OXxNZRqep4+ttXYrkNCUOE27dYLPptsiohoKJTngNk0TmxVHz
OQN5OB0lfyb7Hkt254SHOrYXa+U3kCZOLca9dTk0XUkPvUXZbnU=
=V7wx
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
