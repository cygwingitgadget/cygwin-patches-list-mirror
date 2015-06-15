Return-Path: <cygwin-patches-return-8168-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96001 invoked by alias); 15 Jun 2015 18:12:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95973 invoked by uid 89); 15 Jun 2015 18:12:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 18:12:09 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CA819A807CE; Mon, 15 Jun 2015 20:12:06 +0200 (CEST)
Date: Mon, 15 Jun 2015 18:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 7/8] winsup/doc: Make and install manpages for utils
Message-ID: <20150615181206.GH26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-8-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-8-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00069.txt.bz2


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 668

On Jun 15 13:36, Jon TURNEY wrote:
> Use 'xmlto man' to make manpages for utils
> (docbook2x-man could also be used, but since we already use xmlto...)
>=20
> This will generate multiple .1 files as an output, but we don't know what=
 they
> will be called, so use a timestamp file for build avoidance when the
> dependencies haven't changed.
>=20
> 2015-06-12  Jon Turney  <...>
>=20
> 	* Makefile.in (install-man, utils2man.stamp): Add rules to build
> 	and install manpages for utils.

Please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfxV2AAoJEPU2Bp2uRE+gtr4P/1NoWDFV3W07yr7Bm0omGVgc
jsC2MQ2CBXmDuJJAM+XKSu7a6aa3B9yFxB9GcQpdfqox5UGahX3hhFj/liynf9o7
dEiWreL5Gg2MiuXgv6Tjs9zESIk1TyiUl2LaB6mlX6AeWjppczukM0ltQ//SF9/f
uxz5mMbcgO9nbXeQwFGthgNYcoOINN42uBNF2X9UVY36y0GZ+2MUdiMD/CuX0STp
vHXOCxqPccz38zhwqWOWq3moV+gz5+f2R7aiMHHFakZhCScKe44jX59wvsyUUpCC
zIKWgEqUZwV+bsofL9p9SI2diFTG6kRRhyeboxzVRXfCtMdZebbgDCpaQ0ucjlXx
gDLI2tarjhhegwWHu+a6ZkCQtf4fkckVX/WQqilBTYrMldJuGdDOLivTTM/IJwIT
GhCVqS/IvTU0wWkzAYiOfewnr1Mj6WQG+PdkCasnaZR7fik5zUyLOWn64e2w7A/2
pUhdCK580Iw1ikM2OlfmBie1gUtE71PDHQvOE7KwfS0ONaGPbZKZFTuLoxhUxeS+
wT8ipxBN7fIrvOU8VM20/wmgQPikf35rq2IY11HkTUGgGDHr2r+7UtiGDzzNPZR+
hk3ASM+MQ0jh42/t31ANWvhc1EtocLodMhpXvpymry7Ga6U5JuAfjnx+Ep5I+Av7
LVHj35WC836E0BaHMypY
=Wd+a
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
