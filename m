Return-Path: <cygwin-patches-return-8568-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104988 invoked by alias); 3 Jun 2016 09:15:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104977 invoked by uid 89); 3 Jun 2016 09:15:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Jun 2016 09:15:38 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 28585A80977; Fri,  3 Jun 2016 11:15:36 +0200 (CEST)
Date: Fri, 03 Jun 2016 09:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: include sys/types.h in sys/xattr.h
Message-ID: <20160603091536.GB28306@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20160603083932.17328-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20160603083932.17328-1-yselkowi@redhat.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00043.txt.bz2


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 913

On Jun  3 03:39, Yaakov Selkowitz wrote:
> Using libattr's <xattr/xattr.h> requires consumers to explicitly include
> <sys/types.h> first, but glibc's header in sys/ already contains the incl=
ude.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  winsup/cygwin/include/sys/xattr.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/include/sys/xattr.h b/winsup/cygwin/include/sy=
s/xattr.h
> index 1f32392..902bb86 100644
> --- a/winsup/cygwin/include/sys/xattr.h
> +++ b/winsup/cygwin/include/sys/xattr.h
> @@ -13,6 +13,7 @@ details. */
>  #ifndef _SYS_XATTR_H
>  #define _SYS_XATTR_H
>=20=20
> +#include <sys/types.h>
>  #include <attr/xattr.h>
>=20=20
>  #endif /* _SYS_XATTR_H */

ACK, please apply.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXUUq3AAoJEPU2Bp2uRE+g/QsQAJtMBB5Xgv8apKwql1Yrr5Fi
9q1LLaMhjlQBlnrNiJ2I8mZoy4nV/lpa5evVp/arEi/ZxMFctTrVJyLlBusmebDS
lQcizU0UVsbSD8KGZuDZa4dy1XWGrTKRoiyYiIhDFeRZ/7Ypxd6s7sH6smf00VA4
Vtf6hXw+A6hEjHmbRrDsflU9BKDYJB5NfbjAqing+Cda6goAWp0AeCxvUsBnOqcT
64eODZSyjr8gARrmYyJ9qo7/nkk0AYldc2gwi3dutusbqFDyor6Q3sXWh7I/9ILc
j9llkAC2+W+TzPa2XwdsU43Ezs/eXmcceEjrPTz3ssRCTyL0iEzDRbTh6OhpozdF
qUpFauZklL00ikfn4mUsJ+jyzI8/Q7fr4xk0cjN5+w7xz69lDY6FqioLEUkyBzkq
n+1w3CAbR9BjfbDT5oL7ATBytkBzPh8nyxL8e0JJ4SgccQQ++uVMJZS3rYD1zlJS
pEkoXrOVYAG9xtLCb/5TsKDjXUeiCdM7UAPtfB/HMINpfMSA32Bk3cUCSHuVwJxo
aL8b44uIGDq35fR6w1OrS1gmCQ1FcegUeqZIe9BqfUbeRn2jULavzBfD4xv4H6Qq
VTjx8a4N67sj+9lTRTkp7Pw1Gc96TfykaKKgMbUO+l7oruSxeB5IPyMMwPKJg+rK
7onZCyg1TJlI9FWfLj3W
=0nyG
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
