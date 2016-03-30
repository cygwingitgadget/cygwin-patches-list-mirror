Return-Path: <cygwin-patches-return-8507-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111872 invoked by alias); 30 Mar 2016 15:07:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111856 invoked by uid 89); 30 Mar 2016 15:07:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Mar 2016 15:07:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A13BCA80909; Wed, 30 Mar 2016 17:07:22 +0200 (CEST)
Date: Wed, 30 Mar 2016 15:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Use just-built gcc for windres
Message-ID: <20160330150722.GC458@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458740052-19618-1-git-send-email-pefoley2@pefoley.com> <1458740052-19618-3-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <1458740052-19618-3-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00213.txt.bz2


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 591

On Mar 23 09:34, Peter Foley wrote:
> When building cygwin in a combined tree with binutils,
> the just-built windres cannot find the just-buit gcc automatically.
> Parse the CC env variable to use the correct compiler, rather then
> falling back to the build-system's gcc which does not define the proper
> preprocessor macros.
>=20
> winsup/cygwin/ChangeLog
> mkvers.sh: Manually specify preprocessor based on $CC

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW++uqAAoJEPU2Bp2uRE+gci8P/1YrDroZ0cO8QVp+OOWRYzxp
FOwyRu8UyMhJzZyfO1VQ7J6kjodRCzr5QUWhfOmUl8QVF0Bdg8s5EyELGue6lJV6
yDwOQaxgbQnE2mcvUm0shBC991cDWOULLKP0qkjDNg1KUr17RawvUBSY7MlYB3QZ
ODg/De7/PSZk0z/F06Bpd6b4zFqPogjqWRBMaIpi5oSHI9AlXxliyom/ip9C88U/
qeP1yw0UhAY0h7FSsDAZOUNklPOu4E2S0uMuvCS02fHeGFbAxBrv9rLg8oXqQqoS
1mI3Cu3kP9DYgyFe2oLP0v8QDduobxBhQoHDFEgNOxKyPEmUmpl88yU3m06X3xJ+
DseHUNMBJYcZ0XoKjz/sNIIG6tGeQWayk+3pc1spr/a3dOwXrVx3ZXLktkArno2R
cIxvgQlRMmS4Dt2/U9bjzrZnbGvoAEL4As+ro7UKO3oV2SQZ8VFAJ1cOWRC5s5E7
bYc3jwpixybtNLKzQ3vq92oKhcUMgkeDcu1R2LRYpvoxuiJHWCqX/1I5HjSfTc2X
fLZ/pA4WRt5rFiHvUh63KzsGuqr/FR623vtiTEU5u/z9g0Z8phivHBN/yWp+/Rnl
WtvOqpM1qIDX9AIw0G06NzClj38JJXYGSDPYvX7WbS6uck9xQM40VzjwiDlImLu5
CtXRkbOQ8bRlp1LYmm/Z
=J+yp
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
