Return-Path: <cygwin-patches-return-9721-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4294 invoked by alias); 24 Sep 2019 18:27:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4274 invoked by uid 89); 24 Sep 2019 18:27:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=Principal, H*o:Inc
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Sep 2019 18:27:25 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 89EAFA26675	for <cygwin-patches@cygwin.com>; Tue, 24 Sep 2019 18:27:24 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5224F5D9CA	for <cygwin-patches@cygwin.com>; Tue, 24 Sep 2019 18:27:24 +0000 (UTC)
Subject: Re: [PATCH v2] Cygwin: rmdir: fail if last component is a symlink, as on Linux
To: cygwin-patches@cygwin.com
References: <20190924175530.1565-1-kbrown@cornell.edu>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5a1ced2e-ad71-0765-03af-a7bb421acad0@redhat.com>
Date: Tue, 24 Sep 2019 18:27:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924175530.1565-1-kbrown@cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="IfPmEICRc3f17HcdRl059rewFpZBzYzgo"
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00241.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfPmEICRc3f17HcdRl059rewFpZBzYzgo
Content-Type: multipart/mixed; boundary="lHyURvNOFI1PAcG3afXUs57uQ2Jddylkl";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: cygwin-patches@cygwin.com
Message-ID: <5a1ced2e-ad71-0765-03af-a7bb421acad0@redhat.com>
Subject: Re: [PATCH v2] Cygwin: rmdir: fail if last component is a symlink, as
 on Linux
References: <20190924175530.1565-1-kbrown@cornell.edu>
In-Reply-To: <20190924175530.1565-1-kbrown@cornell.edu>


--lHyURvNOFI1PAcG3afXUs57uQ2Jddylkl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Content-length: 2067

On 9/24/19 12:55 PM, Ken Brown wrote:
> If the last component of the directory name is a symlink followed by a
> slash, rmdir should fail, even if the symlink resolves to an existing
> empty directory.
>=20
> mkdir was similarly fixed in 2009 in commit
> 52dba6a5c45e8d8ba1e237a15213311dc11d91fb.  Modify a comment to clarify
> the purpose of that commit.
>=20
> Addresses https://cygwin.com/ml/cygwin/2019-09/msg00221.html.
> ---
>  winsup/cygwin/dir.cc | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
> index b757851d5..0e0535891 100644
> --- a/winsup/cygwin/dir.cc
> +++ b/winsup/cygwin/dir.cc
> @@ -305,15 +305,14 @@ mkdir (const char *dir, mode_t mode)
>=20=20
>    __try
>      {
> -      /* POSIX says mkdir("symlink-to-missing/") should create the
> -	 directory "missing", but Linux rejects it with EEXIST.  Copy
> -	 Linux behavior for now.  */
> -
>        if (!*dir)
>  	{
>  	  set_errno (ENOENT);
>  	  __leave;
>  	}
> +      /* Following Linux, do not resolve the last component of DIR if
> +	 it is a symlink, even if DIR has a trailing slash.  Achieve
> +	 this by stripping trailing slashes or backslashes.  */

Maybe even "Following Linux, and intentionally ignoring POSIX, do not..."

> +
> +      /* Following Linux, do not resolve the last component of DIR if
> +	 it is a symlink, even if DIR has a trailing slash.  Achieve
> +	 this by stripping trailing slashes or backslashes.  */
> +      if (isdirsep (dir[strlen (dir) - 1]))
> +	{
> +	  /* This converts // to /, but since both give ENOTEMPTY,
> +	     we're okay.  */
> +	  char *buf;
> +	  char *p =3D stpcpy (buf =3D tp.c_get (), dir) - 1;
> +	  dir =3D buf;
> +	  while (p > dir && isdirsep (*p))
> +	    *p-- =3D '\0';
> +	}
>        if (!(fh =3D build_fh_name (dir, PC_SYM_NOFOLLOW)))
>  	__leave;   /* errno already set */;
>=20=20

Looks okay to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--lHyURvNOFI1PAcG3afXUs57uQ2Jddylkl--

--IfPmEICRc3f17HcdRl059rewFpZBzYzgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 488

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2KYAsACgkQp6FrSiUn
Q2oCsggAitu31UBngzrQbepaWI5DqjhHQUT+x24WaRgHjurDFQfdklbd8Oq1IBwm
OKAfRjkE4gak3DzhIjoQwUBjE/b8DUkaOx3Ouuc6ajjbvLBzZWHY6wCcKsy5K0bL
YZJs9UyKOGFQsj6fOqa1rTnQDO5IrK3Txem1f4tzS5GazIHOO6NsPFgbZ/9Tm870
tZBJN2Cr7/X7cCQRnKaYvGSMxuz9/Bx5weM52XszO9/36TCbA6fqVCO+jA2XJ1x1
R6HpqDBmp4f6Kl84wpGPfLf9Kx8ruSUr/vRBNnrsyYdhUGUxSFNKzgxSuKSkSGuU
MR3MTOT5f9rQXM9OF1nkfKuIHcsFrg==
=oqPu
-----END PGP SIGNATURE-----

--IfPmEICRc3f17HcdRl059rewFpZBzYzgo--
