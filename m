Return-Path: <cygwin-patches-return-8730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124593 invoked by alias); 5 Apr 2017 07:42:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124361 invoked by uid 89); 5 Apr 2017 07:42:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:496, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 05 Apr 2017 07:42:37 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 5ACDF721E280C	for <cygwin-patches@cygwin.com>; Wed,  5 Apr 2017 09:42:35 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A72F05E009B	for <cygwin-patches@cygwin.com>; Wed,  5 Apr 2017 09:42:34 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8599EA805C9; Wed,  5 Apr 2017 09:42:34 +0200 (CEST)
Date: Wed, 05 Apr 2017 07:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Make ldd stop after any non-continuable exception
Message-ID: <20170405074234.GA31927@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170404175110.171404-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20170404175110.171404-1-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00001.txt.bz2


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 475

On Apr  4 18:51, Jon Turney wrote:
> Ensure that ldd always stops when the exception is flagged as
> non-continuable.
>=20
> Also arrange for ldd to exit with a non-zero exit code if something went
> wrong which prevented us from listing all dynamic dependencies.

Patch is ok.  In what situation occurs this?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5J/qAAoJEPU2Bp2uRE+gsGUP/1k7JffDLzivDtIBYif+SvRP
HBx2zo1WdGGwJGLFXRU+hunUQWU9lSYuH2WG2dK23Nvq9tshPxtTRw1Mz84oTF/z
IKS/bLq6IuOhlk0pJqk3zmfHcihaSUrFVIM13V0WvjQwKjsjzMeixlPneim1zH+5
IZ+LShfqQaXHaDYF1MLaFN9rzpFd2YpsRju0QOQiqhnRg4ky4dxAyoojqbjDeGIh
PZRC7Rb6ZUrbZf/J1dlRqk9H/erHlQ/OudxYP5tjCBZsqeKGar4OpRXiiNkvNDHo
uRgKGQ09L+YBeLfu0wnqR3iMdtqysops+pQ9uS0Ag8REPE8T7GVmWRpu4mobta4s
VrBdWDwYPX14MtyrVP8uBtLG7wINmkr3HDJx+jXHe9yE67hgqxSsuET9oJDlofJ1
HQpDi9lkXFokdxrwj1apg5BdMR1Vxh25QCOUdEx1pD/eDCq3uhRjW17z9rp9B2fi
LCL6tAWfIR1lWY9yPoMQWM2odbB3FqPipXUPmZz9XF526AHeWex45ZeO81SRHALh
KBL3cPwlnQH9mhlUP7pZNzuaDWJpKcUhe96q921F8t9uI5oIj0izB29wImOiCBUr
rKHf232g9+cXTiQs583nBe0L4TXyz9Zd1yQco7oET11UKOkO2VyznmGLt6eNV/Hb
6hlQ3DzbZLxCE/kKzPmj
=pH4s
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
