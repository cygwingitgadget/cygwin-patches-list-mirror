Return-Path: <cygwin-patches-return-7998-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28103 invoked by alias); 16 Jun 2014 09:12:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28087 invoked by uid 89); 16 Jun 2014 09:12:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 16 Jun 2014 09:12:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 441408E05FF; Mon, 16 Jun 2014 11:12:54 +0200 (CEST)
Date: Mon, 16 Jun 2014 09:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: typo correction in grp.cc
Message-ID: <20140616091254.GA16684@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1EB3586B-FB0E-4DA3-8790-9964C54B0D81@Denis-Excoffier.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <1EB3586B-FB0E-4DA3-8790-9964C54B0D81@Denis-Excoffier.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q2/txt/msg00021.txt.bz2


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1081

On Jun  6 19:08, Denis Excoffier wrote:
> Hello,
>=20
> The following patch (or equivalent) is needed in order for /usr/bin/id to=
 return the full set of groups
> in case the user given as argument belongs to more than 10 groups:
>=20
> diff -uNr cygwin-snapshot-20140523-1.original/winsup/cygwin/grp.cc cygwin=
-snapshot-20140523-1.patched/winsup/cygwin/grp.cc
> --- cygwin-snapshot-20140523-1.original/winsup/cygwin/grp.cc	2014-05-23 1=
2:31:13.000000000 +0200
> +++ cygwin-snapshot-20140523-1.patched/winsup/cygwin/grp.cc	2014-05-26 15=
:08:37.542897300 +0200
> @@ -656,11 +656,11 @@
>  	  groups[cnt] =3D grp->gr_gid;
>  	++cnt;
>        }
> -  *ngroups =3D cnt;
>    if (cnt > *ngroups)
>      ret =3D -1;
>    else
>      ret =3D cnt;
> +  *ngroups =3D cnt;
>=20=20
>    syscall_printf ( "%d =3D getgrouplist(%s, %u, %p, %d)",
>  		  ret, user, gid, groups, *ngroups);
>=20
>=20
> Please apply.

Done.  Thanks a lot.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTnrUWAAoJEPU2Bp2uRE+g7QcP/2NlIB1yVVtaAGyyu169gpeE
cHCth4OA/t09+R9gFbRVwPjhl8zaFGn+DPutj2o6+o5/hd45s64Vq821FGRxprea
BgoFHbuPC/SHqjJCJDT5fVKex4ni5HD94jt6yP4zLJqNybhuoTQuqXwjUys0M6IG
59oERTR4N8bcykfkodz2zIiqudYHyIk8MhoukBCTn1ZHzV0ktQHAxAZew8i5ad1D
P0n6lrPB+NBBfVhw7gwQ28LekMPW9VsuzpAAly5MbVtNYuTXORyg2OzvURJcbtS+
xeKhWH00ssUALQoIO4WtlDip0LSIs+3chSsQF4RqtUMjcKU2Oka5BDVo05HP8hQ1
Z82DYHiGWQyhnVv4POfd6c/rjpLLDk4+hcO/gcdXhm1BbLoCcuMGe89vorEaIcTS
RS8tfDARpHx3vh/jlFUlubWvXhE5saHWFt1C9jLQ55xcHmPwpoHPEhSd0ZKi/rsK
b+pn1d12y8HvGx8TFe4kg5cPTYWQSCo3+Srvk3utNdkorTeBo9PFUP3OMlxJWG1w
l33nx9aqX2qB2a7Kn7nxNW4j/c7LbiMkSyY9qPDQX2G9gJ32RLg4E5l+Soe8Sc+m
WTIS2/SX/8BdIMXNDARd+zbwIVU1h0D/UKCtu5iah9dmFz0D9EyZ4AmdPHLOO74v
ZQEMQnmWBsky1QmzhTsq
=R6V5
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
