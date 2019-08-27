Return-Path: <cygwin-patches-return-9576-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70262 invoked by alias); 27 Aug 2019 08:14:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70253 invoked by uid 89); 27 Aug 2019 08:14:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, H*R:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Aug 2019 08:14:00 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MLz3R-1hl8Jo1Ew5-00HyIM for <cygwin-patches@cygwin.com>; Tue, 27 Aug 2019 10:13:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6D3D4A805E2; Tue, 27 Aug 2019 10:13:55 +0200 (CEST)
Date: Tue, 27 Aug 2019 08:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: get_posix_access: avoid negative subscript
Message-ID: <20190827081355.GS11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190826174324.46043-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Av0MaMCQQeg4b3so"
Content-Disposition: inline
In-Reply-To: <20190826174324.46043-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00096.txt.bz2


--Av0MaMCQQeg4b3so
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1715

Hi Ken,

On Aug 26 17:43, Ken Brown wrote:
> Don't refer to lacl[pos] unless we know that pos >=3D 0.

I'm not sure this is entirely right.  Moving the assignment to
class_perm/def_class_perm into the previous if makes sense, but the
bools has_class_perm and has_def_class_perm should be set no matter
what, to indicate that class perms had been specified.

Either way, does this solve a real-world problem?  If so, a pointer
or a short description would be nice.


Thanks,
Corinna


> ---
>  winsup/cygwin/sec_acl.cc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/winsup/cygwin/sec_acl.cc b/winsup/cygwin/sec_acl.cc
> index 933bfa69d..67749d7b1 100644
> --- a/winsup/cygwin/sec_acl.cc
> +++ b/winsup/cygwin/sec_acl.cc
> @@ -807,9 +807,9 @@ get_posix_access (PSECURITY_DESCRIPTOR psd,
>  			  lacl[pos].a_id =3D ACL_UNDEFINED_ID;
>  			  lacl[pos].a_perm =3D CYG_ACE_MASK_TO_POSIX (ace->Mask);
>  			  aclsid[pos] =3D well_known_null_sid;
> +			  has_class_perm =3D true;
> +			  class_perm =3D lacl[pos].a_perm;
>  			}
> -		      has_class_perm =3D true;
> -		      class_perm =3D lacl[pos].a_perm;
>  		    }
>  		  if (ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
>  		    {
> @@ -820,9 +820,9 @@ get_posix_access (PSECURITY_DESCRIPTOR psd,
>  			  lacl[pos].a_id =3D ACL_UNDEFINED_ID;
>  			  lacl[pos].a_perm =3D CYG_ACE_MASK_TO_POSIX (ace->Mask);
>  			  aclsid[pos] =3D well_known_null_sid;
> +			  has_def_class_perm =3D true;
> +			  def_class_perm =3D lacl[pos].a_perm;
>  			}
> -		      has_def_class_perm =3D true;
> -		      def_class_perm =3D lacl[pos].a_perm;
>  		    }
>  		}
>  	    }
> --=20
> 2.21.0

--=20
Corinna Vinschen
Cygwin Maintainer

--Av0MaMCQQeg4b3so
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1k5kMACgkQ9TYGna5E
T6B3jQ//S/nqs3am0E2SV1bXZKQQjGhE8WnQ5QWXFhxHuKZCUZ8sOVemhvBS1VPy
SHE+Lqb/4DoXu4AiQPmMNk+WjGetLaqMy3neDDIL10XNl3xg3xJskoTkld+oomEb
omkRcAKk5NyUX1VPM1OPBTr7fgFANrzxp9ef+HeqEVkjhoGaQ4azBEgIZd7JuItN
PUaos2BIYKw/lgUKEPTzV0UaOWN9xT7Qndg0e4IzOhmlzWFFNOvVl3CzeEbuerDo
nfL1MrrkeztyuT30Q8cdY5nUF9tlk3LLsAbH7AEfsJufW6o91uazU2LKWGz2XDq5
q+UoXNpQarNSVkFv+2JpuKnouuw5eGHith7WA9UGUFtEa7pqobI6C9T22GX5zAOW
EbAQ7V7dhsl5AV9RfawpzWSWgLcVzdYC//4yBtYP3GTUULsUKmOOTdT5h3KmLMoG
RcQM45BE7MlwMlaE9i5dBDqU9CQq6u3lD+m+vjiJkm7u0BfZrkeGDInbaYjgxyLD
ak++n6XxWr0Ojqz6vjSZh16OXJ/HChULFhm+fxhZCblGxU14LgG9xCnXCpoiTPDN
tKMKWqUNhu/X/LspkcPUu8c9zPzqSzyTC80MaynWIPnPerrmNIy63fc2wtc4DKmO
vi1Tne94AFSBxf5hNFnKeyeIEeoSoYcDO/ec0VbdoUkMfuTYQR8=
=ff1m
-----END PGP SIGNATURE-----

--Av0MaMCQQeg4b3so--
