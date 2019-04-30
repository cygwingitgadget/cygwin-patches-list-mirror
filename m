Return-Path: <cygwin-patches-return-9396-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40213 invoked by alias); 30 Apr 2019 16:13:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40203 invoked by uid 89); 30 Apr 2019 16:13:21 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 16:13:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MYedH-1hHoVR07gh-00Vl1P for <cygwin-patches@cygwin.com>; Tue, 30 Apr 2019 18:13:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 87D77A8078C; Tue, 30 Apr 2019 18:13:17 +0200 (CEST)
Date: Tue, 30 Apr 2019 16:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: dll_list: drop FILE_BASIC_INFORMATION
Message-ID: <20190430161317.GN3383@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6166ec52-cb38-cd01-8f76-5b3500c0f3a9@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline
In-Reply-To: <6166ec52-cb38-cd01-8f76-5b3500c0f3a9@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00103.txt.bz2


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2603

On Apr 30 16:14, Michael Haubenwallner wrote:
> Querying FILE_BASIC_INFORMATION is needless since using win pid+threadid
> for forkables dirname rather than newest last write time.
> ---
>  winsup/cygwin/dll_init.cc | 1 -
>  winsup/cygwin/dll_init.h  | 1 -
>  winsup/cygwin/forkable.cc | 7 +++----
>  3 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/dll_init.cc b/winsup/cygwin/dll_init.cc
> index 4baa48dc1..28f4e53a8 100644
> --- a/winsup/cygwin/dll_init.cc
> +++ b/winsup/cygwin/dll_init.cc
> @@ -372,7 +372,6 @@ dll_list::alloc (HINSTANCE h, per_process *p, dll_typ=
e type)
>        d->image_size =3D ((pefile*)h)->optional_hdr ()->SizeOfImage;
>        d->preferred_base =3D (void*) ((pefile*)h)->optional_hdr()->ImageB=
ase;
>        d->type =3D type;
> -      d->fbi.FileAttributes =3D INVALID_FILE_ATTRIBUTES;
>        d->fii.IndexNumber.QuadPart =3D -1LL;
>        if (!forkntsize)
>  	d->forkable_ntname =3D NULL;
> diff --git a/winsup/cygwin/dll_init.h b/winsup/cygwin/dll_init.h
> index c4a133f01..0a9749638 100644
> --- a/winsup/cygwin/dll_init.h
> +++ b/winsup/cygwin/dll_init.h
> @@ -59,7 +59,6 @@ struct dll
>    DWORD image_size;
>    void* preferred_base;
>    PWCHAR modname;
> -  FILE_BASIC_INFORMATION fbi;
>    FILE_INTERNAL_INFORMATION fii;
>    PWCHAR forkable_ntname;
>    WCHAR ntname[1]; /* must be the last data member */
> diff --git a/winsup/cygwin/forkable.cc b/winsup/cygwin/forkable.cc
> index 4580610b1..30833c406 100644
> --- a/winsup/cygwin/forkable.cc
> +++ b/winsup/cygwin/forkable.cc
> @@ -158,7 +158,7 @@ rmdirs (WCHAR ntmaxpathbuf[NT_MAX_PATH])
>  static bool
>  stat_real_file_once (dll *d)
>  {
> -  if (d->fbi.FileAttributes !=3D INVALID_FILE_ATTRIBUTES)
> +  if (d->fii.IndexNumber.QuadPart !=3D -1LL)
>      return true;
>=20=20
>    tmp_pathbuf tp;
> @@ -194,13 +194,12 @@ stat_real_file_once (dll *d)
>    if (fhandle =3D=3D INVALID_HANDLE_VALUE)
>      return false;
>=20=20
> -  if (!dll_list::read_fii (fhandle, &d->fii) ||
> -      !dll_list::read_fbi (fhandle, &d->fbi))

Given this is the only place calling dll_list::read_fbi, the method
and declaration should be removed, too.

> +  if (!dll_list::read_fii (fhandle, &d->fii))
>      system_printf ("WARNING: Unable to read real file attributes for %W",
>  		   pmsi1->SectionFileName.Buffer);
>=20=20
>    NtClose (fhandle);
> -  return d->fbi.FileAttributes !=3D INVALID_FILE_ATTRIBUTES;
> +  return d->fii.IndexNumber.QuadPart !=3D -1LL;
>  }
>=20=20
>  /* easy use of NtOpenFile */
> --=20
> 2.19.2

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlzIdB0ACgkQ9TYGna5E
T6DNgA/+OWUrszXFIaY6PiRGPIu7b5Vqve74Kp7mIKYAM8v4MoB5uR/S+XxWXsow
eoCDwLtW7tDkWbquNd5KdUcUwlxGoRPMQckXBoVjGDR04VN4tacvgAPXQvCfOqHf
EHLKsZbPjSnvxgrA8Qj6Ga7oO44M10bBujxR0iwsXuld0UIiwkJ/AxQf8WBx8t1V
CwMZimMNIf/Sjgq6RZ9OZyp+p9xXZPyeo8V6L04Brxs1hR4Xdb9q+PDH68QJ2JYW
cJM+gObO0WCs10PR324XWYb578/V1So4o980+yZprfzEKcTYhQfDchf2/69q4exk
Ms9QGuZJHZEt8NN5r7E5Ky2VrpdmTXtUO85bPHBnO3Pn03gvIuw7ql6uGfqx5w1o
8fcaWmx7gSB1swqwvlrl25SWnjYE3CNhaVwBTIs7Sp458YV4TbMjNX/vrf8y8/XW
lRjUJNbp0x54mTmsJA3tzKNAvX7iR6+ASN7rbu0Rwz1BS1DEEhC8S1gUygffvHuD
nUMaWgTq64/5kh7ObUFoJrpn7+1Mufs/Pakp4/fmIqeTtE5RyGTDz9CaAl/A7hw3
VvJn8DHgrvk942ruKcF+z8Oa1TkT9XTozd2nGq0QZIW/+DtPnQOboFj/IS5gfg4u
0s12SbHLwyr+RKQ12AnyYqfLf3iYcwAlQkBY48TFOaFMkf9/Gls=
=M7p1
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--
