Return-Path: <cygwin-patches-return-8207-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 60748 invoked by alias); 22 Jun 2015 14:55:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60727 invoked by uid 89); 22 Jun 2015 14:55:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 14:55:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A9666A8094D; Mon, 22 Jun 2015 16:55:53 +0200 (CEST)
Date: Mon, 22 Jun 2015 14:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] winsup/doc: Create info pages from cygwin documentation
Message-ID: <20150622145553.GH28301@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk> <1434983976-3612-2-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <1434983976-3612-2-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00108.txt.bz2


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1230

On Jun 22 15:39, Jon TURNEY wrote:
> v2:
> Updated to use docbook2x-texi not docbook2texi, since source is now docbo=
ok XML.
> Tweak DocBook XML so info directory entry has a description.
>=20
> v3:
> Use a custom charmap to handle &reg;
>=20
> v4:
> Proper build avoidance
> texinfo node references may not contain ':', so provide alternate text fo=
r a few
> xref targets
>=20
> 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
>=20
> 	* Makefile.in (install-info, cygwin-ug-net.info)
> 	(cygwin-api.info): Add.
> 	* cygwin-ug-net.xml: Add texinfo-node.
> 	* cygwin-api.xml: Ditto.

This is fine.

> 	* ntsec.xml (db_home): Add texinfo-node for titles containing a
> 	':' which are the targets of an xref.

This... not so much.  Let's simply remove the colons instead:

-<sect4 id=3D"ntsec-mapping-nsswitch-home"><title id=3D"ntsec-mapping-nsswi=
tch-home.title">The <literal>db_home:</literal> setting</title>
+<sect4 id=3D"ntsec-mapping-nsswitch-home"><title id=3D"ntsec-mapping-nsswi=
tch-home.title">The <literal>db_home</literal> setting</title>
[...]


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViCH5AAoJEPU2Bp2uRE+gNdAP/3zwDIdQX4ylu710JMS4SDCf
dWDQbMxnPcSZXsDoi+zmDsZqc+/dSF+OU8QeDPFY+uk2zV+6PSywdlUzV3fc9ZNJ
vpI5iB3VHITliuMBUeh0XrIMNGtJ2tEQ30fZYBfaDhH/3Nuy+3HhjV0ZLo6qgPyv
HMzsqxTT2PR88nYA8OQpRHGdmobqVt+FkgISZV4NA89TfVC8oVwGwRUXA8OeUL9n
QjOL4FuN0iOrLtvJxSrYVbyXGJl7cwP+s2wRtLL2DEngrs8JSCDGuArRgesBQXe7
6jwyJusz8YAXPUFRfwwUFi8xacJxdxJI84AqfpVbj/jKdqr8a3HyQtYdfkD4yI1T
4n0999BcREqW1Y/OdVxE0c7wST6eZCG2FZDBzJ3z05oLHoEtP++DRQuh8oFiwWBl
aPCbOywYZHoBtgwyLUAj6ngRR5I2+9TrEuE6KFFswXaY4TDyajIsr008V5jWVJ7O
1zIh0M5K4jH0xh5497NiysV78CQWnbG978KnU7Q3AcFnSJz4nHlQKXHlMoJKqNpt
1uVQWx1D7IxuRWTT2asMMS2B7g9gv+SgO5t+NkU3kAxho4RDjQkhsRDGhJ4p+mS/
Ov8ME2nFiAHyx77FZd7MP5n2CDFlvRy7q3CDFQ5wdK2bRitesAYgewxEPZwCF1XZ
C6IjYdsKDbMrAINJqreS
=BMyr
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
