Return-Path: <cygwin-patches-return-8835-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40732 invoked by alias); 24 Aug 2017 09:27:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32391 invoked by uid 89); 24 Aug 2017 09:25:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1989, Attached, H*R:D*cygwin.com, H*Ad:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 24 Aug 2017 09:25:40 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id B866E71E3F8C0	for <cygwin-patches@cygwin.com>; Thu, 24 Aug 2017 11:25:36 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 18C4E5E01D4	for <cygwin-patches@cygwin.com>; Thu, 24 Aug 2017 11:25:36 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ED13FA804A5; Thu, 24 Aug 2017 11:25:35 +0200 (CEST)
Date: Thu, 24 Aug 2017 16:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime %s
Message-ID: <20170824092535.GH7469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BY1PR09MB0343663DE41D927E67CF0CCEA5BB0@BY1PR09MB0343.namprd09.prod.outlook.com> <acc19ec5-055b-1bd4-997d-a247755163bf@SystematicSw.ab.ca> <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <92da937f-f770-f29c-651e-000f92cbf358@SystematicSw.ab.ca>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-SW-Source: 2017-q3/txt/msg00037.txt.bz2


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2040

On Aug 23 12:51, Brian Inglis wrote:
> Attached patch to support %s in Cygwin winsup libc strptime.cc __strptime=
().
>=20
> This also enables support for %s in dateutils package strptime(1).
>=20
> In case the issue comes up, if the user wants to support %s as in date(1)=
 with a
> preceding @ flag, they just have to include that verbatim before the form=
at as
> in "@%s".
>=20
> Testing revealed a separate issue with %F format which I will follow up o=
n in a
> different thread.
>=20
> Similar patch coming for newlib.
>=20
> --=20
> Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

> From 11f950597e7f66132a2ce6c8120f7199ba02316f Mon Sep 17 00:00:00 2001
> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> Date: Tue, 22 Aug 2017 15:10:27 -0600
> Subject: [PATCH] winsup/cygwin/libc/strptime.cc(__strptime) add strptime =
%s
>=20
> ---
>  winsup/cygwin/libc/strptime.cc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/winsup/cygwin/libc/strptime.cc b/winsup/cygwin/libc/strptime=
.cc
> index 62dca6e5e..a7fef4985 100644
> --- a/winsup/cygwin/libc/strptime.cc
> +++ b/winsup/cygwin/libc/strptime.cc
> @@ -573,6 +573,29 @@ literal:
>  			bp =3D conv_num(bp, &tm->tm_sec, 0, 61, ALT_DIGITS);
>  			continue;
>=20=20
> +		case 's' :	/* The seconds since Unix epoch - GNU extension */
> +		    {
> +			long long sec;
> +			time_t t;
> +			int errno_save;
> +			char *end;
> +
> +			LEGAL_ALT(0);
> +			errno_save =3D errno;

Funny enough, in other places in Cygwin we call this temp variable
"save_errno" :)


Alternatively, since you're in C++ code, you can use the save_errno
class, like this:

  {
    save_errno save;

    [do your thing]
  }

The destructor of save_errno will restore errno.

Since the code as such is fine, it's your choice if you want to stick
to it or use one of the above.  Just give the word.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZnpuPAAoJEPU2Bp2uRE+gOikP/1ghfgEksCm7iQDL4WEuOxzb
HF3ZDSZns8b/Tfvb25ZHiXqHQL/nz5Y+1Y+VpNipWBgWL743GrBDdWCSbBSbXrXy
2tnYbPy7zehgTWwnkAlGKIy47JrnaHHtBihE71J+aDuW8UBRN+pGnkmQ4JGXt8Dz
tN3Mm/qqi8zFzv5ilV/9RKlDGGvgpAI/vtAwHTVS/rYcsP5AQLXJxi0JmJz1medm
jamUcrEsU7JowekHMOIs/KbPkNHdKK2Ybmuh5pzs6ODxK98GYZK/qIwKlLBtSj09
UdBtpWzvi8OYq9aq/IexwbXuSOtXl+rR6JRXLjXWC6vCmOPqn0qVkp0xj6xhkksi
9jFPib8qxXewCub1JIdVNj4n/j3x/30vytfcwfdlzCEngZvdzfxwYhIpwkdCJVWj
agb/+2CE/HKt4S4Q2Q0BQL6UCCvb4R1xXeSUXKe6xVjMSTOZRVVw4McMZgH2ijZA
igv1g/jlej0f3ITqCMtWM9htWH49oEn2hWDKSRIkUVZzCM4F+kanUjBJBMECS7MF
OVDYzV4HW/4aHppp8cTNUDa3eeA7sUcMThOevUq0uCbsUgMVadZEERAvcG4LmWiV
5Ky0B0P/c8K1YXKpU4XNWlm18U61fM5Xv/0BurNPEdD1U64N2fX5qaHTG2kqRjhc
KdvsUJk+Mxp5UGMpvFrd
=a+LR
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
