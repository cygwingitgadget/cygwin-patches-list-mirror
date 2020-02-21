Return-Path: <cygwin-patches-return-10102-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117415 invoked by alias); 21 Feb 2020 19:43:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117397 invoked by uid 89); 21 Feb 2020 19:43:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Feb 2020 19:43:36 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MHX3X-1j9quC3yQD-00Dakm for <cygwin-patches@cygwin.com>; Fri, 21 Feb 2020 20:43:33 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 12C8CA80706; Fri, 21 Feb 2020 20:43:33 +0100 (CET)
Date: Fri, 21 Feb 2020 19:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-ID: <20200221194333.GZ4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qKhyKP9HH88saeqA"
Content-Disposition: inline
In-Reply-To: <20200221191000.1027-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00208.txt


--qKhyKP9HH88saeqA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1482

Hi Takashi,

On Feb 22 04:10, Takashi Yano wrote:
> - Accessing shared_console_info accidentaly causes segmentation
>   fault when it is a NULL pointer. The cause of the problem reported
>   in https://cygwin.com/ml/cygwin/2020-02/msg00197.html is this NULL
>   pointer access in request_xterm_mode_output(). This patch fixes
>   the issue.

When does this occur?  I guess this is during initialization.  Is it
really necessary to switch to xterm mode at all at that time?  If not,
it might be simpler to just

-  if (con_is_legacy)
+  if (con_is_legacy || !shared_console_info)

at the start of the functions and only switch to xterm mode when
fully up and running.

> ---
>  winsup/cygwin/fhandler_console.cc | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 42040a971..e298dd60c 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -256,7 +256,8 @@ fhandler_console::request_xterm_mode_input (bool req)
>      return;
>    if (req)
>      {
> -      if (InterlockedIncrement (&con.xterm_mode_input) =3D=3D 1)
> +      if (!shared_console_info ||
> +	  InterlockedIncrement (&con.xterm_mode_input) =3D=3D 1)

Btw., that should be

         if (!shared_console_info
	     || InterlockedIncrement (&con.xterm_mode_input) =3D=3D 1)

Note the position of the ||


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qKhyKP9HH88saeqA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5QMuQACgkQ9TYGna5E
T6B37A//f0n9z4k5zTuzGupLC91Vuj9NNu/1g8FAou930fdY6c7EKfT6LdTro9Kc
/kEouHN3klbxx08Z2ff+BAZctcT/eEWSIk9vop8YoPPzRpYwUapfwBA3qyZhCDHq
Ezov7mC/j6Q43PLQO4ayvPiQ6FXYARjUgRo0gLlPOygSfiYJbBKtx2PKth033u2J
PxbjXWebh/++ilrhYtxcziB9p1pC+/W6Lub3HsyNDUT1mco9Osu9FpmKLQNYeQTE
uFsP8yLeXM1APzIvtiJDxV8rEGkqSqzZfnJHlbIZjeUVGwoyNXhRlR+qTHAU9pB/
ySNVZC2LJWE7J05dCfMPd69BafEKON+PrxpFNNo/Tik/xiK5DpcTfKP/NdkNF03l
iBd83ENYxxgntTcyPN2TKqo5HDd/sD8BnlBYqlu46bOH22pUm0zdUWZHWRw1OxE6
DTfMoVgi7wKGARstPUrGEtIN4t/vR7FLkrqF8E2RhoaqS4+/rcY7HdvNWMWRPv54
91KmRAgYCNdHuKWdocjWKF5/AbXUOyLC/UFWbSQC3re3YtZYI+A7IkJMy4rUIWk9
NXwCQIh0kvdcc7HvZuBKJOb9xxhAu57e70Eb5eSjvxLEL+H8UOfppzTOq2VnuakK
SgL+mLbh/F/v7/eFc1+wM7b0uhAkMfoJtRR8yhU7qJkjd0UqN7M=
=bLpt
-----END PGP SIGNATURE-----

--qKhyKP9HH88saeqA--
