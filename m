Return-Path: <cygwin-patches-return-9191-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76450 invoked by alias); 10 Jan 2019 18:02:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76428 invoked by uid 89); 10 Jan 2019 18:02:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-125.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=scenario, H*Ad:U*cygwin-patches, H*F:D*cygwin.com, oder
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 10 Jan 2019 18:02:56 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MRmwM-1gsCVb2u6c-00TERO for <cygwin-patches@cygwin.com>; Thu, 10 Jan 2019 19:02:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 199EAA806D1; Thu, 10 Jan 2019 19:02:53 +0100 (CET)
Date: Thu, 10 Jan 2019 18:02:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: af_unix_spinlock_t: add initializer
Message-ID: <20190110180253.GO593@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190110175635.16940-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="oxV4ZoPwBLqAyY+a"
Content-Disposition: inline
In-Reply-To: <20190110175635.16940-1-kbrown@cornell.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SW-Source: 2019-q1/txt/msg00001.txt.bz2


--oxV4ZoPwBLqAyY+a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 885

On Jan 10 17:56, Ken Brown wrote:
> Also fix a typo.
> ---
>  winsup/cygwin/fhandler.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
> index d02b9a913..7e460701c 100644
> --- a/winsup/cygwin/fhandler.h
> +++ b/winsup/cygwin/fhandler.h
> @@ -832,9 +832,10 @@ class fhandler_socket_local: public fhandler_socket_=
wsock
>  /* Sharable spinlock with low CPU profile.  These locks are NOT recursiv=
e! */
>  class af_unix_spinlock_t
>  {
> -  LONG  locked;          /* 0 oder 1 */
> +  LONG  locked;          /* 0 or 1 */

Huh.

>  public:
> +  af_unix_spinlock_t () : locked (0) {}

Why do we need that?  The spinlock is created as part of a shared mem
region which gets initialized to all zero, no?  Or do you plan to use it
outside of this scenario?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--oxV4ZoPwBLqAyY+a
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlw3iMwACgkQ9TYGna5E
T6AJfQ//cZyFgDPcJzz1P3lUINbe5Zhf3I2IzYfoRtdEKOdTMu69Ap8xZX0LdadG
Qq0licRWDwnAoKe6C5ounYbcxnSARCLJ5mlt2Iie8eL9p5ryGFKzQzDlnhoVUxUO
qYj0Iegn1A+HZc86Cux2uIp4RGR29dSv4PT18iYtmCwdAYn4VEaXVjiuVq7CUHF/
1ZDjQg4aC7/maPT0rR/NlUXjpLNoFam5pZ+iLSRoFwhqmxYfUYg6y9IxAwD/Iexw
DNur5e2spuZFLfsTdV+cOG2IRac6aUDtLjOC6eGfHywaBzuAwiLI2v8XkESQIC39
v4bRYW96CBdfhO4+MkwJPOJEt/IbMkSIg4qJaCyEbfJ/fZm6hNGgLQFa6azE8bAi
FN3ZpKeLV3nbOlLtFBiufv876euw014mpnQpaMc7/J5470YjJIjXcUY7jULQJmlt
Jo8NHDftqXuh9UrHoaKyJY1MAOFJhvczXFl4JBunUxkrbAtzFpfsAW0YrwdnYVCM
cg8bkPWz/52xSeFq9ciljHDXHOMAYnRcGlOKzNjEQdGsde/373s5c8pCdUkkajDN
nw00UXJFqylHa/Ts6MnF35JIOu/5+ZUZmypbK5fm+KPfDrXrUZ1gwFwmehNeQlTD
QtF43GsJZlUsuVcTzOHMvmr/YJBIQMQk9xlOUt1yg7RbqhA+8dU=
=e4Nn
-----END PGP SIGNATURE-----

--oxV4ZoPwBLqAyY+a--
