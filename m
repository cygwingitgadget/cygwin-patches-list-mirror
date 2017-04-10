Return-Path: <cygwin-patches-return-8736-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121737 invoked by alias); 10 Apr 2017 08:15:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121694 invoked by uid 89); 10 Apr 2017 08:14:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Apr 2017 08:14:56 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B1251721E281A	for <cygwin-patches@cygwin.com>; Mon, 10 Apr 2017 10:14:54 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 12C3A5E03CB	for <cygwin-patches@cygwin.com>; Mon, 10 Apr 2017 10:14:54 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E6397A805DB; Mon, 10 Apr 2017 10:14:53 +0200 (CEST)
Date: Mon, 10 Apr 2017 08:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Avoid decimal point localization in /proc/loadavg
Message-ID: <20170410081453.GA2848@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170408125537.15728-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20170408125537.15728-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00007.txt.bz2


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1637

On Apr  8 13:55, Jon Turney wrote:
> Explicitly format the contents of /proc/loadavg to avoid the decimal point
> getting localized according to LC_NUMERIC. Using anything other than '.'
> breaks top.
>=20
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>  winsup/cygwin/fhandler_proc.cc | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc=
.cc
> index a7e816f..ad367e4 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -30,6 +30,7 @@ details. */
>  #include <wctype.h>
>  #include "cpuid.h"
>  #include "mount.h"
> +#include <math.h>
>=20=20
>  #define _COMPILING_NEWLIB
>  #include <dirent.h>
> @@ -432,10 +433,14 @@ format_proc_loadavg (void *, char *&destbuf)
>    double loadavg[3] =3D { 0.0, 0.0, 0.0 };
>    getloadavg (loadavg, 3);
>=20=20
> +#define HUNDRETHS(l) (int)((l - floor(l))*100)
> +
>    destbuf =3D (char *) crealloc_abort (destbuf, 48);
> -  return sprintf (destbuf, "%.2f %.2f %.2f %u/%u\n",
> -		  loadavg[0], loadavg[1], loadavg[2], running,
> -		  (unsigned int)pids.npids);
> +  return __small_sprintf (destbuf, "%u.%02u %u.%02u %u.%02u %u/%u\n",
> +			  (int)loadavg[0], HUNDRETHS(loadavg[0]),
> +			  (int)loadavg[1], HUNDRETHS(loadavg[1]),
> +			  (int)loadavg[2], HUNDRETHS(loadavg[2]),
> +			  running, (unsigned int)pids.npids);
>  }
>=20=20
>  static off_t
> --=20
> 2.8.3

Looks good.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY6z79AAoJEPU2Bp2uRE+g8HkP/20TawYbi9yNCJbBDIRjeHCr
g0fWYeX6hnMq7ZvGZPH1k5Egtqx5U2uCJ9jQqq4DFACpwfWgM0RplYs6bOG+j3Mw
5TWAz87/mU11d35JhBUqQXVFh8W2RpmHttHcx+a0C1HFT3s5DXvVLtR8axVUVqhk
DKWa49tOrb+RTzlwcaQIk02TpfROoFDhXqOPaO5FgCiPZMrUT1rEh55V13baD3wB
kpNB4kpep8lyxTd2kbyOije319Re1y5AH7tua3M+8s7Mc306KOoNyUQqeMZ8g6ok
ozgDIFYG7+j2v08Ovbk14xCocn3zBc1C9O9SCkLGA8gijyA17QFf4f5vTEA7dQG0
nggka30s6hl2HTa/PRFQwnb/xd7Kc4xa9TYsAMf+VXLgB4eGDg/gWsmqt/IM2JIx
tmtiH2fPzhSokvB2OjEV379HtduTr0ukACm48X3TBnooA2FsuQu5KtnoxBQwy3L1
Y2diPAhVCRHMNdawjsQ9ayWA1U3OfZVnHvYbiw12eDo20J2no9C95p2lUUq/n48Y
8oLGFp+AQb3LMd+c5mUIhpE7eThyRujjxgx34TCXULuwwyT+t/7mNVfENaVAC33S
PNSnkwxsyT6zO0rKsZAGOGPJsAPJqrOGv4JSQFXwpmPZvC/0QIWk9ponmqxTGpjh
dnSb0pCToYx/OWD/BcKD
=omF3
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
