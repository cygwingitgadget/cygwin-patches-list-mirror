Return-Path: <cygwin-patches-return-8628-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50277 invoked by alias); 1 Sep 2016 14:05:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50265 invoked by uid 89); 1 Sep 2016 14:04:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=one's, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 01 Sep 2016 14:04:49 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 36F0D721E281A	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 16:04:35 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A5B195E051D	for <cygwin-patches@cygwin.com>; Thu,  1 Sep 2016 16:04:34 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A41CDA804AE; Thu,  1 Sep 2016 16:04:34 +0200 (CEST)
Date: Thu, 01 Sep 2016 14:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/4] dlopen (pathfinder): try each basename per dir
Message-ID: <20160901140434.GE1128@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-3-git-send-email-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline
In-Reply-To: <1472666829-32223-3-git-send-email-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-SW-Source: 2016-q3/txt/msg00036.txt.bz2


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1433

On Aug 31 20:07, Michael Haubenwallner wrote:
> Rather than searching all search dirs per one basename,
> search for all basenames within per one search dir.
>=20
> pathfinder.h (check_path_access): Interchange dir- and basename-loops.
> ---
>  winsup/cygwin/pathfinder.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/pathfinder.h b/winsup/cygwin/pathfinder.h
> index bbba168..c306604 100644
> --- a/winsup/cygwin/pathfinder.h
> +++ b/winsup/cygwin/pathfinder.h
> @@ -182,12 +182,12 @@ public:
>  	     basenamelist::member const ** found_basename =3D NULL)
>    {
>      char const * critname =3D criterion.name ();
> -    for (basenamelist::iterator name =3D basenames_.begin ();
> -	 name !=3D basenames_.end ();
> -	 ++name)
> -      for (searchdirlist::iterator dir(searchdirs_.begin ());
> -	   dir !=3D searchdirs_.end ();
> -	   ++dir)
> +    for (searchdirlist::iterator dir(searchdirs_.begin ());
> +	 dir !=3D searchdirs_.end ();
> +	 ++dir)
> +      for (basenamelist::iterator name =3D basenames_.begin ();
> +	   name !=3D basenames_.end ();
> +	   ++name)
>  	if (criterion.test (dir, name))
>  	  {
>  	    debug_printf ("(%s), take %s%s", critname,
> --=20
> 2.7.3

This one's fine, of course.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TD8GDToEDw0WLGOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyDVyAAoJEPU2Bp2uRE+gVPoQAJpYtIWxX5DGAJmKr693zb6k
Q4c7GFRIE/UNWz8++T9J/2AIqcEuJWQ7cuQdS61D2sca0el8mG8EBvYixx67ESYx
BAjWRaHbV+/fSPu0mIwZTNvlBag8l3NOzdVKw1t65ZXGWk276/Vz+giOEFMZZhjA
/4Pg5+bGIbMYVnsm9PJ5pE/MYm+jHJLUo1iUZvDJGzM8PO4PzbDbmqU3SmPQBYKm
PIuUMQI0ZP/boh0hQpJYrpcmMFPGcF/oaqc0Fz8iPLKhyUYppwEfj9bOgmmGO4M2
FV+rp7ypoF0v9n4YKBkbDlEd4s8ZnvRKAoHnsJ/2MBkTV9DM2xp4/FQHwqUZ39bd
ILa61VNx7w4NRVE4OxRw6bmyv29FyHLPoQgWVub53cayWl/B0JYhu2BjXR7HCnk5
BmuNnBNV5gSRu8eaK65qwOGXstNKUXAkeUWYy9YoLllFCKMysRCsbi0lbwDKtgsl
nkNPyqFsOTRH/4LfPSzCXfnXx9IY5kOUEg1t5ddlbsTpjXiacYGv6YFnQa5Ic034
cCRAsvLOsocBXF6w06dHjgkvvTLDTowYUT7P3a0jgTbu/utIAKTPgGvZJ5qj6hOa
5Smya5OqxASQNzZatbp3qr673tJ5IuHqTqzfPqmqunemMCOBE8XfMsIrLrlCRI0H
G3+ScDcqTKrNZdmyM1AJ
=sokb
-----END PGP SIGNATURE-----

--TD8GDToEDw0WLGOL--
