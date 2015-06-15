Return-Path: <cygwin-patches-return-8167-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121331 invoked by alias); 15 Jun 2015 17:16:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119055 invoked by uid 89); 15 Jun 2015 17:16:27 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 17:16:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 75863A807CE; Mon, 15 Jun 2015 19:16:24 +0200 (CEST)
Date: Mon, 15 Jun 2015 17:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 8/8] winsup/doc: Fix an issue with parallel make
Message-ID: <20150615171624.GG26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-9-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-9-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00068.txt.bz2


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 604

On Jun 15 13:36, Jon TURNEY wrote:
> The cygwin-ug-net-nochunks.html.gz target does not ensure that the
> cygwin-ug-net/ directory exists, so it can fail if run on it's own, or if=
 the
> cygwin-ug-net/cygwin-ug-net.html target has not yet created it in a paral=
lel
> make.
>=20
> 2015-06-12  Jon Turney  <...>
>=20
> 	* Makefile.in (cygwin-ug-net/cygwin-ug-net-nochunks.html.gz):
> 	Ensure cygwin-ug-net directory exists.

Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfwhoAAoJEPU2Bp2uRE+gAR4P/1dOaW2fDrrNLgTMFul6BAoz
vhON10mf3QUpGD/128Jeh+YcXdIknj9dtYw2AqMRwXc1Ws9i89xGFAwwBB4ArPp4
0w5/mN7eA3LG+I1OPNYmbYvFEEI8CnS8pBh+Gcyxi+9ppmnqSp0vw4pYWROrYkBE
ZlPAtcoZfwam2sMn9ISL/2cN6vlEYjd/NZjTfKOlL4+JgPKH20ht7n7wOA6RQrIV
HSDli04S/KvTD642M/mtUd/A+acX1Ccggrod1ebA21Ga97MHRPl84QpuaLFGW/yK
UrSH1jJCKLZF+w0ugy0WgYz6haSS28O/+l4lbzVmTBCBZ4G9pUdmBf5zbIAhClgZ
THB8+UTRp9EkbcLhbjBPICgyFRDVcmNKk+Dp4IOx7y+v1tcvHtPyzPjatS5EfocY
wbWgvytwSoCITKiRdbVLzSMWbSXes6+LWMD3ysWy/q9Ow2J3Cf0bJE5YNVJPyELi
LOGTsREmrPMp93q9X9wKvEpeVQXNWWUHdrCSbK+pBq8hVHjW+JVHfRuVB3VvQpXW
arBhlGqMj/cl+kzuab2BiuE1VmZSYFelM2BRj/KkHLMbC2JS871molBFD+XgtqDD
wOz70hpWLPGsf8vli3tpz7dXr8iu5VLq7ycWWrJgGm6v4/V+rC+muYRLJ9h2XU9N
ojrghKmGH0uT8Q4DAUVI
=1QUg
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
