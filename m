Return-Path: <cygwin-patches-return-8596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123072 invoked by alias); 5 Jul 2016 14:14:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123056 invoked by uid 89); 5 Jul 2016 14:14:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-94.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=para, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0190b.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.25.11) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 05 Jul 2016 14:14:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B2625A809F3; Tue,  5 Jul 2016 16:14:03 +0200 (CEST)
Date: Tue, 05 Jul 2016 14:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Small documentation fixes
Message-ID: <20160705141403.GF13445@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20160705100752.6684-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q3/txt/msg00004.txt.bz2


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 526

On Jul  5 11:07, Jon Turney wrote:
> Jon Turney (3):
>   Use <example> tag at same level as <para>, not inside it
>   Use <filename> tag, not <pathname> tag
>   Improve description of Cygwin ldd utility
>=20
>  winsup/doc/utils.xml | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)

Looks good, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXe8CrAAoJEPU2Bp2uRE+g9ycP/jaYXkbgs9cTYH2hH+IGFUtO
8muzo4/6n/+uxZs4mw4Jg6HKwr82JZ/5T8IG4PuOfEqWKbmyqpngkHX45QMomknt
L/xev4StiSkYm8/spZGtGLjBtmEZabJB3xLJolRt1/yzAxuCI1g1aCi82Ts9PrrQ
viONdenzS40w3An7pdbL0+0amMTOzwsl5HXXfQElI5whRG/wFnS/tTDltn55KCbb
0+cRP7yMP5oAnNCB6ip1IlE7VWC11hP4CNe2/Ir9LCe6q1AiGSGWHwAt7MmFeQUQ
6mik2YROf07jOqbLI6pDR/698poZ/OQem82yNDKNdlYMlPz433pNhVXPN5Zb7cxg
dDg2CIINZCaddTc2zGsfF6m4exkiq8ReyVrBhrbbh7OkQUvtKQVq4zjsbOMAANjY
azvaiEe/xYLeinoCeF3rs/itWSX/PpPgwD/mELvbfJmX/E0roqZdkt+qOTMC5jbv
SVuX2Pj7CUXo62WHxSzdFrVOOYlos/Dj0uE35Rc3371GNbFBCMpDpfpRnHhCNMBc
JEiYMLk3cCnRGAId0f0DJGlByPeUeIp9yDJKPTL18bYQWmcEuB+T1Tus7L1bJ2Gl
JZ5LynUIYel56F81jRPZepcFaPmeFf6EVCI0YLpQWmy13a23QAlmcTcehVYDLJh2
Y+TRFwAYiTEcxAKDp1Rd
=/tJB
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
