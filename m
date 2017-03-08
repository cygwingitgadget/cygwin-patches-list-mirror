Return-Path: <cygwin-patches-return-8710-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99468 invoked by alias); 8 Mar 2017 16:04:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99447 invoked by uid 89); 8 Mar 2017 16:04:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-110.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:952, D*org.uk, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Mar 2017 16:04:03 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 672A0721E280C	for <cygwin-patches@cygwin.com>; Wed,  8 Mar 2017 17:04:00 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id C8A685E04C1	for <cygwin-patches@cygwin.com>; Wed,  8 Mar 2017 17:03:59 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AC590A804A7; Wed,  8 Mar 2017 17:03:59 +0100 (CET)
Date: Wed, 08 Mar 2017 16:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement dladdr() (partially)
Message-ID: <20170308160359.GB17544@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170308142442.44824-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20170308142442.44824-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2017-q1/txt/msg00051.txt.bz2


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1006

On Mar  8 14:24, Jon Turney wrote:
> Note that this always returns with dli_sname and dli_saddr set to NULL,
> indicating no symbol matching addr could be found.
>=20
> Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
> ---
>=20
> Notes:
>     Mesa 17.1 will want to use dladdr() in order to use the mtime of a lo=
adable
>     module to control the validity of a cache, and this implementation su=
ffices
>     for that purpose (not that this caching is implemented for llvmpipe a=
t the
>     moment)
>=20
>  winsup/cygwin/common.din      |  1 +
>  winsup/cygwin/dlfcn.cc        | 34 ++++++++++++++++++++++++++++++++++
>  winsup/cygwin/include/dlfcn.h | 18 ++++++++++++++++++
>  winsup/doc/posix.xml          |  4 ++++
>  4 files changed, 57 insertions(+)

Thwe API minor version bump is missing.  With this addition, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwCtvAAoJEPU2Bp2uRE+gusgP/A1KMkoCTDHSBMWw/ie2tE63
dP6TbpgSywzjOmSHljxNA6jpDeCwxXqcs2513FvuboZVk7oPxRuzrxtS2GvDbObz
3q9MhIj1xRoWxC8CahFs4zsEPKwUfjm4XiCJvXJyj3i+CUTuyb8gv/EMZQl3k91K
d5IFXpdbj5hb88fnXp7rrQnJQkRHliD53njeqtdnmuRUfjYa5gfvYcUJUKXznzEH
/YPQNE0SVl32ZS7ruwi51lXnIory515jIRthfTTInNAtlpnDoxr2hU37ucKGg5c+
aLL9rvt5xn81+/1vGVFxJxxdyFBVuZ3s3ad6vlRAnDwM/47kzQ2vObQFCZvnHhMr
ul6i8XLaN9Ex2kfCCBPQEWLUMublEeTog50zedd/oQZBBdj3+HZf+Ysp3ltdoyJb
/NTm4JQTg4UBZxCZkql3y/ng3LcMZxArA8sfWnV5ZV+g5yoqvyO6XLGzL+MTsPWw
dswWQ9yYRiIdhvauFJuXt5gznwQ97KH3qVybwpKqZWyrS0YIF4Nay5LYybdtZvbK
KQLd4RNR+CVYp/60z8EyzJA3fqGn7qJhZ+oTWyFDV29yAt9OoGAPciaqfxIftmqR
457NHvoO7zpXRp/YtwnzH1I64GQxyyaudnGXHFhIJNxDBNl2PWTN1SHM2dSDEMbE
+UPa9Ok7FQ3tSQwrkRBW
=Gspk
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
