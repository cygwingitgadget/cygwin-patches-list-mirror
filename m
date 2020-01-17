Return-Path: <cygwin-patches-return-9947-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43647 invoked by alias); 17 Jan 2020 10:22:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43628 invoked by uid 89); 17 Jan 2020 10:22:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-121.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 10:22:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MC2k1-1imefT3sh3-00CQ1O for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2020 11:22:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 22FE6A806B2; Fri, 17 Jan 2020 11:22:30 +0100 (CET)
Date: Fri, 17 Jan 2020 10:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/3] Cygwin: readlinkat, fchownat: allow pathname to be empty
Message-ID: <20200117102230.GE5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200116204944.2348-1-kbrown@cornell.edu> <20200116204944.2348-3-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="/asd063ZXkk5ILJU"
Content-Disposition: inline
In-Reply-To: <20200116204944.2348-3-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00053.txt


--/asd063ZXkk5ILJU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3528

On Jan 16 20:50, Ken Brown wrote:
> Following Linux, allow the pathname argument to be an empty string,
> provided the dirfd argument refers to a symlink opened with O_PATH and
> O_NOFOLLOW.  The readlinkat or fchownat call then operates on that
> symlink.  In the case of fchownat, the call must specify the
> AT_EMPTY_PATH flag.
> ---
>  winsup/cygwin/syscalls.cc | 40 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 038a316db..3d87fd685 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -4785,14 +4785,29 @@ fchownat (int dirfd, const char *pathname, uid_t =
uid, gid_t gid, int flags)
>    tmp_pathbuf tp;
>    __try
>      {
> -      if (flags & ~AT_SYMLINK_NOFOLLOW)
> +      if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH))
>  	{
>  	  set_errno (EINVAL);
>  	  __leave;
>  	}
>        char *path =3D tp.c_get ();
> -      if (gen_full_path_at (path, dirfd, pathname))
> -	__leave;
> +      int res =3D gen_full_path_at (path, dirfd, pathname);
> +      if (res)
> +	{
> +	  if (!(errno =3D=3D ENOENT && (flags & AT_EMPTY_PATH)))
> +	    __leave;
> +	  /* pathname is an empty string.  This is OK if dirfd refers
> +	     to a symlink that was opened with O_PATH and O_NOFOLLOW.
> +	     In this case, fchownat operates on the symlink. */
> +	  cygheap_fdget cfd (dirfd);
> +	  if (cfd < 0)
> +	    __leave;
> +	  if (!(cfd->issymlink ()
> +		&& cfd->get_flags () & O_PATH
> +		&& cfd->get_flags () & O_NOFOLLOW))
> +	    __leave;

I think this is not quite right.  Per the Linux man page of fchownat,
if AT_EMPTY_PATH is given, any file type is ok as dirfd:

   AT_EMPTY_PATH (since Linux 2.6.39)
      If pathname is an empty string, operate on the file referred  to
      by  dirfd (which may have been obtained using the open(2) O_PATH
      flag).  In this case, dirfd can refer to any type of  file,  not
      just  a  directory...

Additionally AT_FDCWD is allowed, too:

                        ... If dirfd is AT_FDCWD, the call operates on
      the current working directory.

> +	  return lchown (cfd->get_name (), uid, gid);

Instead of calling lchown, this code could also just tweak the flags
and fall through to the below chown_worker call, I think, just as in
readlinkat below:

          strcpy (path, cfd->get_name ());
	  flags =3D AT_SYMLINK_NOFOLLOW;

> +	}
>        return chown_worker (path, (flags & AT_SYMLINK_NOFOLLOW)
>  				 ? PC_SYM_NOFOLLOW : PC_SYM_FOLLOW, uid, gid);
>      }
> @@ -4979,8 +4994,23 @@ readlinkat (int dirfd, const char *__restrict path=
name, char *__restrict buf,
>    __try
>      {
>        char *path =3D tp.c_get ();
> -      if (gen_full_path_at (path, dirfd, pathname))
> -	__leave;
> +      int res =3D gen_full_path_at (path, dirfd, pathname);
> +      if (res)
> +	{
> +	  if (errno !=3D ENOENT)
> +	    __leave;
> +	  /* pathname is an empty string.  This is OK if dirfd refers
> +	     to a symlink that was opened with O_PATH and O_NOFOLLOW.
> +	     In this case, readlinkat operates on the symlink. */
> +	  cygheap_fdget cfd (dirfd);
> +	  if (cfd < 0)
> +	    __leave;
> +	  if (!(cfd->issymlink ()
> +		&& cfd->get_flags () & O_PATH
> +		&& cfd->get_flags () & O_NOFOLLOW))
> +	    __leave;
> +	  strcpy (path, cfd->get_name ());
> +	}
>        return readlink (path, buf, bufsize);
>      }
>    __except (EFAULT) {}
> --=20
> 2.21.0

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--/asd063ZXkk5ILJU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4hiuUACgkQ9TYGna5E
T6DPIg/9EoTQqWQV3lyss+y3Xs/8MghOQFsJIBLCL/eypdU24Iojug09Hqrpnun5
kQWM2639BRAWQtrLupvpj72Hs00WWS0UfEGAIpDU+3nMo/i38oCLbF536owrNqOV
pYhrzhbkFfjYvOLXzFeXtEkHfJhpnXRzASWIFarKapGiKXYonuJGlcAgaP4AdYCw
0IPa9fALN2ajfLGWtNAphL1Hev/+wo+a6pXatBJ2nwjaPfgk2Fyx0bJdAeBEYLPf
N7fzJ1MAtjIQnkpzp+T/Oqw1MtTs5I9CTYoq+n2F0xi5sm+tDINANWZftn/bR8Bz
L44GbovIT2snx8zHf0NkcT2i/XgkR6s3Q/mueK+/XScvG9smyEhLdOzobrR1rXWf
fOHowmygZ2zci5eruoiu2d+idp/Z4V/bs1ZkKP/EyyVUjT9uK+BDD3VqA8oX7nPL
Nv8O/I2gIRRvpK60TIP9LZgTQCkua0MUlnrwkt6szINSYCPooaKeZ9YuIYWD4Sjp
YGrnZS//eiliZqui6cMKv7GF6ViBJfDKP+LQuwgcMOhdZfwtshSynMC0K6qqD3PX
5uw0Z7wESOjb8ktcASdVfsmq20uFJ7ZJn8I2LJs2rhR5yglFf4XQ7Vke/c1ErRyz
H8HxUr2+KegavGh1ex7EgoH8np28QLn9Lxws9hCu5+3dPOWLo4A=
=v3Hs
-----END PGP SIGNATURE-----

--/asd063ZXkk5ILJU--
