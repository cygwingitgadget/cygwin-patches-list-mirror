Return-Path: <cygwin-patches-return-9025-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116293 invoked by alias); 21 Feb 2018 21:05:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 116277 invoked by uid 89); 21 Feb 2018 21:05:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, claims, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Feb 2018 21:05:43 +0000
Received: from perth.hirmke.de (aquarius.franken.de [193.175.24.89])	by mail-n.franken.de (Postfix) with ESMTP id 412C8721E281A	for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 22:05:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perth.hirmke.de (Postfix) with ESMTP id 0B490860905	for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 22:05:40 +0100 (CET)
X-Spam-Score: -2.9
Received: from perth.hirmke.de ([127.0.0.1])	by localhost (perth.hirmke.de [127.0.0.1]) (amavisd-new, port 10024)	with LMTP id kwn4oNVis0m4 for <cygwin-patches@cygwin.com>;	Wed, 21 Feb 2018 22:05:34 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by perth.hirmke.de (Postfix) with ESMTP id C8D0F8605E1	for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 22:05:34 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BFC25A806B7; Wed, 21 Feb 2018 22:05:34 +0100 (CET)
Date: Wed, 21 Feb 2018 21:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
Message-ID: <20180221210534.GA7576@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q1/txt/msg00033.txt.bz2


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 901

Hi David,

On Feb 21 18:09, David Macek wrote:
> ---
>  winsup/doc/ntsec.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> index df1d54930..03293591b 100644
> --- a/winsup/doc/ntsec.xml
> +++ b/winsup/doc/ntsec.xml
> @@ -914,7 +914,7 @@ This is not valid:
>  </screen>
>  <para>
> -Apart from this restriction, the reminder of the line can have as
> +Apart from this restriction, the remainder of the line can have as
>  many spaces and TABs as you like.
>  </para>
> --=20
> 2.16.2.windows.1

The patch is malformed.  It claims to contain 7 lines (6 lines context,
one line changed), but actually it has only 4 lines context.  Please
check your git settings.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlqN3x4ACgkQ9TYGna5E
T6A3cQ/+OOHdrsodjVwTn1C9aonPdk7kjNRZmUrjk5HotUEqzbdt/OW5P+KcBR6+
OD3qSX23DWph1OVEfx5ZiOm2Q0mqRpfDAja5/X/Npw4kM2dnVxWZtWTh8kazq7AH
hgOraCnIWi7AoWaU1OskxIDAHeFJcVOy2TJ88M+y4orCfDZD3AnPVxaPzLC0Y2S5
SlvUr3IMlX07I7xAhUxalUNwpk52xYhlwQxGgRdi5APeDO7J6CcY/qmcUFuomZWC
rMMOss2nZ0X3LlCUJP0mNZnMbNbJi3JrGKeYwEgVTzDlRMkUbC39EUqucinhoPzB
qRiPJV6Zf/9PjO+HwDip9ayOt2C4TqGmG3/LtYulRW0fkr0N3EYNXcsfB5bFJ25A
yv6t1GLBds0J571294CdS0nAba2CHBNxgwAg9GDR3RBKgxxZpZcyyd+oSfBH4j11
pkPWZ3wTV/DJ2oJAAN9YkrN+PYbL1bw4aocKFKBWhzEJuj8Lo3LODSHFKe5kqabG
3mUYroY3RbKJ3ZcJ9PX1ZiWS8X7Sq01qlJQWYyybhjtqLsqrmI5nBjyXMUdzz+2m
vTmuw7Yf0F4hC7I/gRuet5wiKTUCnOB8RKDFEQ9itxgnQyWUpBuvG1yKZzXV76ux
w3/drcWY7hizZTaJJ4WesXQkqeVf912KoWwJ9iUfYbtz6hoNmc0=
=+LQr
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
