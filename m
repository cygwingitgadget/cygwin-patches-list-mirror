Return-Path: <cygwin-patches-return-8776-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65668 invoked by alias); 12 Jun 2017 10:27:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64747 invoked by uid 89); 12 Jun 2017 10:27:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=sensitivity, Joe, H*c:application
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Jun 2017 10:27:05 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 84A07721E280C	for <cygwin-patches@cygwin.com>; Mon, 12 Jun 2017 12:27:06 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id BA5BE5E0402	for <cygwin-patches@cygwin.com>; Mon, 12 Jun 2017 12:27:05 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9978BA805E6; Mon, 12 Jun 2017 12:27:05 +0200 (CEST)
Date: Mon, 12 Jun 2017 10:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v2
Message-ID: <20170612102705.GL13513@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <593B24DD.10209@pismotec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <593B24DD.10209@pismotec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q2/txt/msg00047.txt.bz2


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 8935

Hi Joe,


thanks for the patch.  Review inline.


On Jun  9 15:44, Joe Lowe wrote:
> 2nd pass at reparse point handling patch.
> [...]
>  static inline int
>  readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
>  {
> -  DWORD ret =3D DT_UNKNOWN;
> +  int ret =3D DT_UNKNOWN;

Given that d_type is an unsigned char type, maybe it would be better to
change the return type of the function (and `ret') accordingly instead.

>    IO_STATUS_BLOCK io;
>    HANDLE reph;
>    UNICODE_STRING subst;
> @@ -197,20 +195,11 @@ readdir_check_reparse_point (POBJECT_ATTRIBUTES att=
r)
>  		      &io, FSCTL_GET_REPARSE_POINT, NULL, 0,
>  		      (LPVOID) rp, MAXIMUM_REPARSE_DATA_BUFFER_SIZE)))
>  	{
> -	  if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_MOUNT_POINT)
> -	    {
> -	      RtlInitCountedUnicodeString (&subst,
> -		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
> -			    + rp->MountPointReparseBuffer.SubstituteNameOffset),
> -		  rp->MountPointReparseBuffer.SubstituteNameLength);
> -	      /* Only volume mountpoints are treated as directories. */
> -	      if (RtlEqualUnicodePathPrefix (&subst, &ro_u_volume, TRUE))
> -		ret =3D DT_DIR;
> -	      else
> -		ret =3D DT_LNK;
> -	    }
> -	  else if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_SYMLINK)
> -	    ret =3D DT_LNK;
> +	  /* Need to agree with path_conv, so use common helper logic.
> +	     */
> +	  ret =3D get_reparse_point_type (rp, false/*remote*/, &subst);
> +	  if (ret =3D=3D DT_UNKNOWN)
> +	    ret =3D DT_DIR;

This looks not right to me.  Every unknown type is a dir?  Unknown is
unknown and should stay this way, that's why the DT_UNKNOWN has been
defined as valid type.

> @@ -2027,13 +2016,23 @@ fhandler_disk_file::readdir_helper (DIR *dir, dir=
ent *de, DWORD w32_err,
>=20=20
>        InitializeObjectAttributes (&attr, fname, pc.objcaseinsensitive (),
>  				  get_handle (), NULL);
> -      de->d_type =3D readdir_check_reparse_point (&attr);
> -      if (de->d_type =3D=3D DT_DIR)
> +      switch (readdir_check_reparse_point (&attr))
>  	{
> -	  /* Volume mountpoints are treated as directories.  We have to fix
> -	     the inode number, otherwise we have the inode number of the
> -	     mount point, rather than the inode number of the toplevel
> -	     directory of the mounted drive. */
> +	case DT_LNK:
> +	  de->d_type =3D DT_LNK;
> +	  break;
> +	case DT_UNKNOWN:
> +	  /* Unknown reparse point type: HSM, dedup, compression, ...
> +	     Treat as normal directory. */
> +	  de->d_type =3D DT_DIR;

Same here.

> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 7d1d23d72..cd62355d7 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -2261,6 +2261,86 @@ symlink_info::check_sysfile (HANDLE h)
>    return res;
>  }
>=20=20
> +static bool
> +check_reparse_point_target (PUNICODE_STRING subst)
> +{
> +  /* Native junction reparse points, or native non-relative
> +     symbolic links, can be treated as posix symlinks only
> +     if the SubstituteName can be converted from a native NT
> +     object namespace name to a win32 name. We only know how
> +     to convert names with two prefixes :
> +       "\??\UNC\..."
> +       "\??\X:..."
> +     Other reparse points will be treated as files or
> +     directories, not as posix symlinks. Possible values
> +     include:
> +       "\??\Volume{..."
> +       "\Device\HarddiskVolume1\..."
> +       "\Device\Lanman\...\..."
> +     */
> +  if (RtlEqualUnicodePathPrefix( subst, &ro_u_uncp, TRUE))
> +    {
> +      return true;
> +    }

Please drop the braces for single line branches.

> +  else if (RtlEqualUnicodePathPrefix (subst, &ro_u_natp, TRUE) &&

The `else' is gratuitous, the if branch returns anyway.

The case sensitivity parameter can be FALSE here.

> +      subst->Length >=3D 6*sizeof(WCHAR) && subst->Buffer[5] =3D=3D ':' =
&&
> +      (subst->Length =3D=3D 6*sizeof(WCHAR) || subst->Buffer[6] =3D=3D '=
\\'))

wchar literals should have a leading L, as in L':'.

> +    {
> +      return true;
> +    }
> +  return false;

Also, wouldn't it make sense to reorder the code a bit, to avoid the
uncp comparison for local paths, given that most access is local anyway?
Kind of like

  if (RtlEqualUnicodePathPrefix (subst, &ro_u_natp, TRUE))
    {
      if (':' && ('\0' || '\\'))
	return true;
      if (uncp)
	return true;
    }
  return false;

I think it would be ok to just check for "UNC\\" then, as in

  wcsncmp (subst->Buffer + 4, L"UNC\\", 4)

> +}
> +
> +int
> +get_reparse_point_type (PREPARSE_DATA_BUFFER rp, bool remote, PUNICODE_S=
TRING subst)

Same as for readdir_check_reparse_point, I guess this should return
unsigned char.

> +{
> +  if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_SYMLINK)
> +    {
> +      /* Windows evaluates native symlink literally.  If a remote symlink
> +         points to, say, C:\foo, it will be handled as if the target is =
the
> +         local file C:\foo.  That comes in handy since that's how symlin=
ks
> +         are treated under POSIX as well. */
> +      RtlInitCountedUnicodeString (subst,
> +		  (WCHAR *)((char *)rp->SymbolicLinkReparseBuffer.PathBuffer
> +			+ rp->SymbolicLinkReparseBuffer.SubstituteNameOffset),
> +		  rp->SymbolicLinkReparseBuffer.SubstituteNameLength);
> +      /* Native symlinks are treated as posix symlinks if relative or if=
 the
> +         target has a prefix that we know how to deal with.
> +         */
> +      if ((rp->SymbolicLinkReparseBuffer.Flags & SYMLINK_FLAG_RELATIVE) =
||
> +          check_reparse_point_target (subst))
> +        return DT_LNK;
> +    }
> +  else if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_MOUNT_POINT)
> +    {
> +      RtlInitCountedUnicodeString (subst,
> +		  (WCHAR *)((char *)rp->MountPointReparseBuffer.PathBuffer
> +			  + rp->MountPointReparseBuffer.SubstituteNameOffset),
> +		  rp->MountPointReparseBuffer.SubstituteNameLength);
> +      /* Don't handle junctions on remote filesystems as symlinks.  This=
 type
> +         of reparse point is handled transparently by the OS so that the
> +         target of the junction is the remote directory it is supposed to
> +         point to.  If we handle it as symlink, it will be mistreated as
> +         pointing to a dir on the local system. */
> +      if (remote)
> +        return DT_DIR;
> +      /* Native mount points are treated as posix symlinks only if
> +         the target has a prefix that does not indicate a volume
> +         mount point and that we know how to deal with.
> +         */
> +      if (check_reparse_point_target (subst))
> +        return DT_LNK;
> +    }
> +  else
> +    {
> +      /* Maybe it's a reparse point, but it's certainly not one we recog=
nize.
> +         */
> +      memset (subst, 0, sizeof (*subst));
> +      return DT_UNKNOWN;
> +    }
> +  return DT_DIR;

Same thing with `else' here.  Especially the last else branch is
confusing, given that it always leads to a return from the function so
this last line is unreachable code (which Coverity will complain about).
The unassuming reader might wonder why the function defaults to DT_DIR
while in fact it doesn't.

> @@ -2944,22 +3017,25 @@ restart:
>  		&=3D ~FILE_ATTRIBUTE_DIRECTORY;
>  	      break;
>  	    }
> -	  else
> +	  else if (res =3D=3D -1)
>  	    {
> -	      /* Volume moint point or unrecognized reparse point type.
> +	      /* Volume moint point or unhandled reparse point.
>  		 Make sure the open handle is not used in later stat calls.
>  		 The handle has been opened with the FILE_OPEN_REPARSE_POINT
>  		 flag, so it's a handle to the reparse point, not a handle
> -		 to the volumes root dir. */
> +		 to the reparse point target. */
>  	      pflags &=3D ~PC_KEEP_HANDLE;
> -	      /* Volume mount point:  The filesystem information for the top
> -		 level directory should be for the volume top level directory,
> -		 rather than for the reparse point itself.  So we fetch the
> -		 filesystem information again, but with a NULL handle.
> -		 This does what we want because fs_info::update opens the
> -		 handle without FILE_OPEN_REPARSE_POINT. */
> -	      if (res =3D=3D -1)
> -		fs.update (&upath, NULL);
> +	      /* The filesystem information should be for the target of
> +		 the reparse point rather than for the reparse point itself.
> +		 So we fetch the filesystem information again, but with a
> +		 NULL handle. This does what we want because fs_info::update
> +		 opens the handle without FILE_OPEN_REPARSE_POINT. */
> +	      fs.update (&upath, NULL);
> +	    }
> +	  else
> +	    {
> +	      /* Unknown reparse point type: HSM, dedup, compression, ...
> +	         Treat as normal directory. */
>  	    }

Nothing against reordering the code, but this drops removing
PC_KEEP_HANDLE from pflags if res =3D=3D 0, i.e., for unknown reparse
points.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPmx5AAoJEPU2Bp2uRE+gV/0P/1ufGMAG5FAPiXRXlEm96K/a
frS1ZYe/Isuz00TKdfnUVv1muCkDHQQelNf//+9n1Zst3kMROjEs9twX48YBwq3O
U54LfD+94l8IEW7OFflwPWwS4cUEun+0Q4A5WlYyHUwd4au7ElVEQLyj+oNol8U2
4Hxb2PZ0RA1pvpJnXzgH5GOKO09NByQ9IOEMCEjRfnmRSztoQdQA5oCgyNJ3qDvm
burKYvUpVLgTSk9TA7dTYlwZCBySZTynqpeYLBy/pgChIB/upeSjXIg3wL+F7AKW
/QV7eRmNY2X6doHj2wnIDcITcvjyUGD8zs65CuPW9Xz8KbF9ZwJVCbsyu2EyGPsj
YpRTjitPJEXLYGXdQ75dGu1c/ZWhgQ/jM3Ur+ktz0fPZdFbLXWxyzqXDey1gzE66
kKndPAGuEvDWoDs6R3kVKzudLG/1d4R2ZMHkT+u9BAUn5+4R7QZLAl520tezsP2b
HSEZwo0UT9e8PuRffmXw0yNS33KI9DePi8RxLuK6tOcaEQH5j+QtVew+iw7yScgP
m/oOWOQVs4Hox8HMVqSTvUxRtnVxGFEBlUtqzS7joUiq5d8vqHAmqTffSPfV4Jdp
U5/vb6B1NSLvEYFAlIzHEpftgGhN8xcVcxByutuGwdB9uaEczX5KH85j8ZV53tYZ
FAajFxm4WGtcKNdrBNeD
=RHNZ
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
