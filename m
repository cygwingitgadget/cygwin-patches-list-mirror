Return-Path: <cygwin-patches-return-9852-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60701 invoked by alias); 15 Nov 2019 11:34:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60688 invoked by uid 89); 15 Nov 2019 11:34:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:700
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 15 Nov 2019 11:34:02 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mbj3e-1hsNlA0aGU-00dFR0 for <cygwin-patches@cygwin.com>; Fri, 15 Nov 2019 12:33:58 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F3BABA80A3D; Fri, 15 Nov 2019 12:33:56 +0100 (CET)
Date: Fri, 15 Nov 2019 11:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygrunsrv: Added options -T and -X; fixed a couple minor issues
Message-ID: <20191115113356.GU3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191113182814.379-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YhYebsMuj/FQeBW/"
Content-Disposition: inline
In-Reply-To: <20191113182814.379-1-lavr@ncbi.nlm.nih.gov>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00123.txt.bz2


--YhYebsMuj/FQeBW/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 658

On Nov 13 13:28, Anton Lavrentiev via cygwin-patches wrote:
> 1. https://www.cygwin.com/ml/cygwin-patches/2019-q4/msg00107.html
> 2. Fixed an issue with "premature exit" error message printed if service =
is stopped from SCM by an operator
> 3. Fixed a potential issue with reporting 0 exit code when a service bein=
g stopped did not actually stop
> ---
>  ChangeLog    |   6 +++
>  cygrunsrv.cc | 125 +++++++++++++++++++++++++++++++++++++--------------
>  cygrunsrv.h  |   5 +++
>  utils.cc     |   8 ++++
>  utils.h      |   5 +++
>  5 files changed, 115 insertions(+), 34 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YhYebsMuj/FQeBW/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3OjSQACgkQ9TYGna5E
T6DViw/+JZQJOdDhac9LWFC0ik4cLEGYk4VtG+r36CBosNztsgx6Pc0kplKD/aWZ
EAajVhEuBnpqp5LuI7UrsVHrShF7QFTzWRyv9/zcQ6jNoM6avleBgzCi3/0MscEs
5IViZDsXBtllx6NlWj9zOj0W3JeUKGl1U3HlZFMXSvbZAI2Q4ENNNPJAglY5ka6s
aMy7aW6ogxyOkoHxcDukYwH/QVi+l9Zkj53NDEjbLax0AJDWyA7qc80pu4eZE7QR
JBNtSoSLgZdAu73J8m/g0igb5FjdmcRORdAniRtB0nWuSMdDrOfzZrCaBkfkDgo9
O3UaJlMBWeysak+aLLNztNwCdpiYwOffNTIP21IuzKlQuElyd8GS+iU9xnleayBi
9si86HteXTnq43NHEWRCDJHsF3qEmcLqwRLXouuFaGohBwakusrvu8FC3QhVqexD
U8LC5wbv9olTIxG5MI9NLLcl+pQBk3tgONVqvUYCRClIyzIgIH0TpBwxyzDBDeGO
CJE+JM0IPrrbkkDh9h2sbTeOJlbHBcRMOfa2hMPqIQ2FlB3KzBLOiIA840jCgJiL
wZqO+1/piyGqVeA9+7RC/F7AyUdJjx4uy2qNL1UykmeweF6HJfYLHEye68gY2eeD
lMpkXLkVbF6X3Yk7Q5/qzK+iADdnwhw3r2No7vrIJVhISUi8XB4=
=q4+W
-----END PGP SIGNATURE-----

--YhYebsMuj/FQeBW/--
