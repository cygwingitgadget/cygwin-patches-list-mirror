Return-Path: <cygwin-patches-return-8506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2925 invoked by alias); 30 Mar 2016 14:52:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2915 invoked by uid 89); 30 Mar 2016 14:52:28 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*R:D*cygwin.com, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Mar 2016 14:52:25 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 29696A80909; Wed, 30 Mar 2016 16:52:23 +0200 (CEST)
Date: Wed, 30 Mar 2016 14:52:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix typo in netinit/ip.h
Message-ID: <20160330145223.GB458@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459343755-15162-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1459343755-15162-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00212.txt.bz2


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 353

On Mar 30 09:15, Peter Foley wrote:
> The type for the ip_tos member was typoed, fix it.
>=20
> winsup/cygwin/ChangeLog:
> include/netinet/ip.h: fix type of ip_tos

Thanks for catching.  Applied.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW++gmAAoJEPU2Bp2uRE+gL3YP/RaTuUMVV7VPMrGhlk9aX2O0
bzv+ofeGms3mXz57hhx4Aj9bRTOHj1AoxvTWxcsfYmoF/YgPgMFoasleLHmD3G+K
FJygBawDebmu3BJVJJm37jXDHoX/1k6ORKJDX0HwSa0ZRhfBFBAZgNYV7Q/Vysv/
6NoN/7y3n3Nkdk8B7+4CirqZrngvvJawjHzCqrET8cvyHgXDrUXLkICTMDytUFLP
R2jx4vbEiKeoqfi8zA4A4QDh0Vr+ERIEiHOsU5tN/FVhTNGGNvQWRATjzZ0VjuLs
+P6IeshFww7VUsCGRJx5WoTi/V+z0N9zQ54U1ZHkkapyOYKnGtJwrXg+Ollq2GjC
YKCEh4ELD5zJgZA3zIxaTii8fd4LznNOSJ7Y22N4eA4zWli/EVcdcfSFuy5Tmn+4
AT10vrEhSl3bOTacvUKbE9Ugd0RTIvsLbe2Kg6sNgYnZdxdM3Sj+g2mJ3ZzcTzEq
Q0G88M3Y/bh9c0i7t+M5TVuEvslG3UxKNa2BznQCfD29+BWuMdYFHm8xraV+mGJl
Q8Kq+gDevi+4gLWAMu50LrHxSAgZTVZPVgRd768DQ0/rQTZ3SZ52HCPHmFf3UDd4
mfBa5XHmUZfrNsE5oxlij0f10/W5wdM93FRvdOylE23mePjJM01JV0N02doD+5x+
5tWiobBCFynqAxFNeM1w
=s2rI
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
