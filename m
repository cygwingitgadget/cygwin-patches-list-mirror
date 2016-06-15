Return-Path: <cygwin-patches-return-8579-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17223 invoked by alias); 15 Jun 2016 12:49:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17207 invoked by uid 89); 15 Jun 2016 12:49:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:798, cygwin-patches, cygwinpatches, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 15 Jun 2016 12:49:49 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3979BA8063D; Wed, 15 Jun 2016 14:49:47 +0200 (CEST)
Date: Wed, 15 Jun 2016 12:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [setup] move view from left to right
Message-ID: <20160615124947.GE27295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <ea3fb37b-8c1f-38be-a52f-3e2dae74d14c@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00054.txt.bz2


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 809

Hi Marco,


in theory patches to setup should go to the cygwin-apps list, but
never mind, cygwin-patches is just as well.

On Jun 15 12:06, Marco Atzeri wrote:
> I always found counter intuitive to have the view button filter on
> the right.

Do you have a screenshot to show how this looks, by any chance?

> I was also thinking to replace the 3 button choice with
> 2 sets:
>=20
> keep vs update
> exp vs current
>=20
> but the update logic on
>=20
>  ChooserPage::keepClicked()
>  ChooserPage::changeTrust(trusts aTrust)
>=20
> it is not really immediate.

I agree, but the idea makes sense.  If you ever have fun to hack on
this, please feel free.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXYU7rAAoJEPU2Bp2uRE+g91AP/RLOpKXdWKMZG/JVJ4Oqny8N
oHK+d3K/0K69VhArkLRV9NFaQOuJpRXUCEXjD563JxCSLdvBop1g1Ex0Nxi+SQmV
V6yKW+v1DgYHwPdmDjlioFP1EPXb0wgrUHOVycOij0wc/ApoztXWkLj5U1jLAp4q
rdA/4fP0HEahrU+TG4r5CrQFwfjZmNychnWIHTgM5J5CN+7v5jOt9/oHuRU29wtY
mY9TbfIzmfK/EZjvplgEtwJ8bZJnc89MtG5XYPuSaOBTa6AL6pZ9++tisooOEBPU
o8cQnyW/8xixxBVbjcPU8kSiz8issXQ2bj+K1OcIM0PK8xK4lPWTx5NhZOiJxc5h
alwKopBBMpW3VNJyFZKYRvEQhKC7+VCG1nlSsbplcjCnimFQDgmerxVIrJDL9Bd7
+i8F7JqT+T5gRHAWnd1sRMmVWiNCNzH92OHfII+nPr/QWy5rY69x9nMB6s6wAtR6
04+lK1kMhPONfmvWJSKxf8zTblP5zFFETOmR782C1niIWE/XttIySwHpcRzLrdQo
qIzImlRkNOvwBYWv6ip6Yqu+EeRwrmjDJxtOPASQyVoye43lzpWAvPBWRJuHDm+Y
ywDkWbSYqczskE3mF1kT0cW3D6BQ5FSd297gGnWLJxoUjgZW1hB4xfh4UwrPEPgx
AdQvUhfZtCYaB4po6NQY
=2epZ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
